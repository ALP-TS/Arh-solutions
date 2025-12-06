import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:b_soft_appliction/app/config/theme/text.dart';
import 'package:b_soft_appliction/core/helpers/appbarhelper.dart';
import 'package:b_soft_appliction/core/helpers/dialougehelper.dart';
import 'package:b_soft_appliction/core/helpers/toasthelper.dart';
import 'package:b_soft_appliction/core/utils/debuprint.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:webview_flutter_android/webview_flutter_android.dart';
import 'package:webview_flutter_wkwebview/webview_flutter_wkwebview.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter_headset_detector/flutter_headset_detector.dart';

import '../../../app/Di/dimensions.dart';
import '../../../app/config/theme/colors.dart';

class ZoomMeetingScreen extends StatefulWidget {
  const ZoomMeetingScreen(
      {super.key,
      required this.meetingUrl,
      required this.stuname,
      required this.topic});
  final String meetingUrl;
  final String stuname;
  final String topic;

  @override
  State<ZoomMeetingScreen> createState() => _ZoomMeetingScreenState();
}

class _ZoomMeetingScreenState extends State<ZoomMeetingScreen> {
  late final WebViewController _controller;
  bool _meetingEnded = false;
  bool _permissionsGranted = false;
  bool _isLoadingPermissions = true;
  bool _isLoadingHeadset = true;
  bool _headsetConnected = false;
  bool _webViewInitialized = false; // tracks whether page finished loading
  Timer? _meetingCheckTimer;

  Timer? _disconnectTimer;
  bool _headsetListenerActive = false;

  late final HeadsetDetector _headsetDetector;

  Map<HeadsetType, HeadsetState> _headsetState = {
    HeadsetType.WIRED: HeadsetState.DISCONNECTED,
    HeadsetType.WIRELESS: HeadsetState.DISCONNECTED,
  };

  bool get isHeadsetConnected {
    return _headsetState[HeadsetType.WIRED] == HeadsetState.CONNECTED ||
        _headsetState[HeadsetType.WIRELESS] == HeadsetState.CONNECTED;
  }

  @override
  void initState() {
    super.initState();

    // prefer starting headset detection first to avoid race conditions
    _initializeHeadsetDetection();

    // request permissions (this will check headset state again after granting)
    // moved to addPostFrame to avoid calling dialogs in initState before build
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _requestPermissions();
    });

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }

  @override
  void dispose() {
    _meetingCheckTimer?.cancel();
    _disconnectTimer?.cancel();

    try {
      // remove listener if plugin supports it
      _headsetDetector.removeListener();
    } catch (_) {}

    // cleanup webview safely on next frame (avoid modifying layers off main thread)
    // we don't await here because dispose can't be async, but we still call cleanup
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _cleanupWebView();
    });

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
    super.dispose();
  }

  Future<void> _cleanupWebView() async {
    // Always run UI-affecting calls on the main/UI frame
    if (!_webViewInitialized) return;
    try {
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        try {
          // Try to leave meeting gracefully
          await _controller.runJavaScript('''
            (function() {
              try {
                const leaveButton = document.querySelector('[aria-label*="Leave"]') ||
                                   document.querySelector('[data-testid*="leave"]') ||
                                   document.querySelector('button[title*="Leave"]') ||
                                   document.querySelector('.leave-btn') ||
                                   document.querySelector('#footer-button-leave');
                if (leaveButton) leaveButton.click();
                const endButton = document.querySelector('[aria-label*="End"]') ||
                                  document.querySelector('[data-testid*="end"]') ||
                                  document.querySelector('button[title*="End"]');
                if (endButton) endButton.click();
              } catch(e) { /* ignore */ }
            })();
          ''');
        } catch (e) {
          debugPrint('Error running JS during cleanup: $e');
        }

        await Future.delayed(const Duration(milliseconds: 300));
        try {
          await _controller.loadRequest(Uri.parse('about:blank'));
        } catch (e) {
          debugPrint('Error loading about:blank during cleanup: $e');
        }
      });
    } catch (e) {
      debugPrint('Cleanup scheduling error: $e');
    }
  }

  Timer? _headsetCheckTimer;

  Future<void> _initializeHeadsetDetection() async {
    _headsetDetector = HeadsetDetector();

    debugPrint('Headset detector plugin initialized');

    // Initial state check
    await _updateHeadsetState();

    try {
      if (Platform.isAndroid) {
        // 🔹 Android: periodic polling every 1s
        _headsetCheckTimer = Timer.periodic(const Duration(seconds: 1), (_) {
          _updateHeadsetState();
        });
      } else if (Platform.isIOS) {
        // 🔹 iOS: event listener + debounce
        _headsetDetector.setListener((event) {
          debugPrint('iOS headset event: $event');

          _handleHeadsetEvent(event);

          if (event == HeadsetChangedEvent.WIRED_DISCONNECTED ||
              event == HeadsetChangedEvent.WIRELESS_DISCONNECTED) {
            _disconnectTimer?.cancel();
            _disconnectTimer = Timer(const Duration(seconds: 2), () {
              if (!isHeadsetConnected) {
                _handleHeadsetChange();
              }
            });
          } else {
            _disconnectTimer?.cancel();
            _handleHeadsetChange();
          }
        });
      }
    } catch (e) {
      debugPrint('Error setting headset detection: $e');
    }

    setState(() => _isLoadingHeadset = false);
  }

  Future<void> _updateHeadsetState() async {
    try {
      final previousConnected = isHeadsetConnected;
      final currentState = await _headsetDetector.getCurrentState;

      consolePrint('Headset state: $currentState');
      consolePrint(
          'Wired headset: ${currentState[HeadsetType.WIRED] == HeadsetState.CONNECTED ? "Connected" : "Disconnected"}');
      consolePrint(
          'Wireless headset: ${currentState[HeadsetType.WIRELESS] == HeadsetState.CONNECTED ? "Connected" : "Disconnected"}');

      if (!mounted) {
        _headsetState = currentState;
      } else {
        setState(() {
          _headsetState = currentState;
        });
      }

      if (previousConnected != isHeadsetConnected) {
        _handleHeadsetChange();
      }
    } catch (e) {
      debugPrint('Error checking headset state: $e');
    }
  }

  void _handleHeadsetEvent(HeadsetChangedEvent event) {
    if (!mounted) {
      // still update internal map even if widget not mounted
      switch (event) {
        case HeadsetChangedEvent.WIRED_CONNECTED:
          _headsetState[HeadsetType.WIRED] = HeadsetState.CONNECTED;
          return;
        case HeadsetChangedEvent.WIRED_DISCONNECTED:
          _headsetState[HeadsetType.WIRED] = HeadsetState.DISCONNECTED;
          return;
        case HeadsetChangedEvent.WIRELESS_CONNECTED:
          _headsetState[HeadsetType.WIRELESS] = HeadsetState.CONNECTED;
          return;
        case HeadsetChangedEvent.WIRELESS_DISCONNECTED:
          _headsetState[HeadsetType.WIRELESS] = HeadsetState.DISCONNECTED;
          return;
      }
    }

    // when mounted, update via setState
    switch (event) {
      case HeadsetChangedEvent.WIRED_CONNECTED:
        if (mounted)
          setState(
              () => _headsetState[HeadsetType.WIRED] = HeadsetState.CONNECTED);
        break;
      case HeadsetChangedEvent.WIRED_DISCONNECTED:
        if (mounted)
          setState(() =>
              _headsetState[HeadsetType.WIRED] = HeadsetState.DISCONNECTED);
        break;
      case HeadsetChangedEvent.WIRELESS_CONNECTED:
        if (mounted)
          setState(() =>
              _headsetState[HeadsetType.WIRELESS] = HeadsetState.CONNECTED);
        break;
      case HeadsetChangedEvent.WIRELESS_DISCONNECTED:
        if (mounted)
          setState(() =>
              _headsetState[HeadsetType.WIRELESS] = HeadsetState.DISCONNECTED);
        break;
    }
  }

  void _handleHeadsetChange() {
    if (!mounted) return;

    if (isHeadsetConnected) {
      if (!_headsetConnected) {
        setState(() => _headsetConnected = true);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Headset connected - you can join the meeting'),
            duration: Duration(seconds: 2),
          ),
        );
      }

      // if permissions are already granted and webview not initialized, join now
      if (_permissionsGranted && !_webViewInitialized) {
        _initializeWebView();
        _startMeetingCheckTimer();
      }
    } else {
      // lost headset
      if (_headsetConnected) {
        setState(() => _headsetConnected = false);

        // If meeting already started, exit
        if (!_meetingEnded && _webViewInitialized) {
          // On iOS we already debounced before calling this; on Android this is immediate
          _endMeeting(reason: 'Headset disconnected - you left the meeting');
        }
      }
    }
  }

  Future<void> _requestPermissions() async {
    // Request or check permissions, then check headset and join if allowed
    if (Platform.isAndroid) {
      Map<Permission, PermissionStatus> permissions = await [
        Permission.microphone,
        Permission.camera,
      ].request();

      bool allGranted = permissions.values.every(
        (status) => status == PermissionStatus.granted,
      );

      if (!mounted) {
        _permissionsGranted = allGranted;
      } else {
        setState(() {
          _permissionsGranted = allGranted;
          _isLoadingPermissions = false;
        });
      }

      // re-check headset state (avoid race where permissions caused route change)
      await _updateHeadsetState();

      if (allGranted && isHeadsetConnected) {
        _initializeWebView();
        _startMeetingCheckTimer();
      } else if (allGranted && !isHeadsetConnected) {
        _showHeadsetRequiredDialog();
      } else {
        _showPermissionDialog();
      }
    } else if (Platform.isIOS) {
      final micStatus = await Permission.microphone.status;
      final camStatus = await Permission.camera.status;

      if (micStatus == PermissionStatus.denied ||
          camStatus == PermissionStatus.denied) {
        Map<Permission, PermissionStatus> permissions = await [
          Permission.microphone,
          Permission.camera,
        ].request();

        final newMicStatus =
            permissions[Permission.microphone] ?? PermissionStatus.denied;
        final newCamStatus =
            permissions[Permission.camera] ?? PermissionStatus.denied;

        final allGranted = newMicStatus == PermissionStatus.granted &&
            newCamStatus == PermissionStatus.granted;

        if (!mounted) {
          _permissionsGranted = allGranted;
        } else {
          setState(() {
            _permissionsGranted = allGranted;
            _isLoadingPermissions = false;
          });
        }

        // re-check headset state
        await _updateHeadsetState();

        if (allGranted && isHeadsetConnected) {
          _initializeWebView();
          _startMeetingCheckTimer();
        } else if (allGranted && !isHeadsetConnected) {
          _showHeadsetRequiredDialog();
        } else {
          _showPermissionDialog();
        }
      } else if (micStatus == PermissionStatus.permanentlyDenied ||
          camStatus == PermissionStatus.permanentlyDenied) {
        if (mounted) {
          setState(() {
            _permissionsGranted = false;
            _isLoadingPermissions = false;
          });
        }
        _showPermissionDialog();
      } else if (micStatus == PermissionStatus.granted &&
          camStatus == PermissionStatus.granted) {
        if (mounted) {
          setState(() {
            _permissionsGranted = true;
            _isLoadingPermissions = false;
          });
        }

        // re-check headset state
        await _updateHeadsetState();

        if (isHeadsetConnected) {
          _initializeWebView();
          _startMeetingCheckTimer();
        } else {
          _showHeadsetRequiredDialog();
        }
      } else {
        if (mounted) {
          setState(() {
            _permissionsGranted = false;
            _isLoadingPermissions = false;
          });
        }
        _showPermissionDialog();
      }
    }
  }

  void _showHeadsetRequiredDialog() {
    if (!mounted) return;
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Headset Required'),
          content: const Text(
            'You must connect headphones to join this meeting for better audio quality and privacy.',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context).pop(); // exit screen
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                _updateHeadsetState();
              },
              child: const Text('Retry'),
            ),
          ],
        );
      },
    );
  }

  void _showPermissionDialog() {
    if (!mounted) return;
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Permissions Required'),
          content: const Text(
            'This app needs microphone and camera permissions to join Zoom meetings. Please grant these permissions in app settings.',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                openAppSettings();
              },
              child: const Text('Open Settings'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                _requestPermissions();
              },
              child: const Text('Retry'),
            ),
          ],
        );
      },
    );
  }

  void _initializeWebView() {
    // avoid initializing twice
    if (_webViewInitialized || _meetingEnded) return;

    late final PlatformWebViewControllerCreationParams params;
    if (WebViewPlatform.instance is WebKitWebViewPlatform) {
      params = WebKitWebViewControllerCreationParams(
        allowsInlineMediaPlayback: true,
        mediaTypesRequiringUserAction: const <PlaybackMediaTypes>{},
      );
    } else {
      params = const PlatformWebViewControllerCreationParams();
    }

    final WebViewController controller =
        WebViewController.fromPlatformCreationParams(
      params,
      onPermissionRequest: (WebViewPermissionRequest request) {
        _handleWebViewPermissionRequest(request);
      },
    );

    controller
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onNavigationRequest: (request) {
            return NavigationDecision.navigate;
          },
          onUrlChange: (change) {
            debugPrint('URL changed to: ${change.url}');
          },
          onPageFinished: (String url) {
            if (!mounted) return;
            setState(() {
              _webViewInitialized = true;
            });
          },
        ),
      )
      ..loadRequest(Uri.parse(widget.meetingUrl));

    if (controller.platform is AndroidWebViewController) {
      AndroidWebViewController androidController =
          controller.platform as AndroidWebViewController;
      androidController
        ..setMediaPlaybackRequiresUserGesture(false)
        ..setOnShowFileSelector(_androidFileSelectorHandler);
    }

    _controller = controller;
  }

  Future<void> _handleWebViewPermissionRequest(
      WebViewPermissionRequest request) async {
    debugPrint('WebView permission request for: ${request.types}');

    bool needsMicrophone =
        request.types.contains(WebViewPermissionResourceType.microphone);
    bool needsCamera =
        request.types.contains(WebViewPermissionResourceType.camera);

    if (Platform.isIOS) {
      bool shouldGrant = true;

      if (needsMicrophone) {
        final micStatus = await Permission.microphone.status;
        if (micStatus == PermissionStatus.permanentlyDenied) {
          shouldGrant = false;
        }
      }

      if (needsCamera) {
        final cameraStatus = await Permission.camera.status;
        if (cameraStatus == PermissionStatus.permanentlyDenied) {
          shouldGrant = false;
        }
      }

      if (shouldGrant) {
        await request.grant();
      } else {
        await request.deny();
        if (mounted) _showWebViewPermissionDialog();
      }
    } else {
      bool hasAppPermissions = true;
      if (needsMicrophone) {
        final micStatus = await Permission.microphone.status;
        hasAppPermissions = hasAppPermissions && micStatus.isGranted;
      }
      if (needsCamera) {
        final cameraStatus = await Permission.camera.status;
        hasAppPermissions = hasAppPermissions && cameraStatus.isGranted;
      }

      if (hasAppPermissions) {
        await request.grant();
      } else {
        await request.deny();
        if (mounted) _showWebViewPermissionDialog();
      }
    }
  }

  void _showWebViewPermissionDialog() {
    if (!mounted) return;
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Permission Required'),
          content: const Text(
            'Zoom needs access to your microphone and camera to join the meeting. Please enable these permissions.',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                openAppSettings();
              },
              child: const Text('Open Settings'),
            ),
          ],
        );
      },
    );
  }

  Future<List<String>> _androidFileSelectorHandler(
      FileSelectorParams params) async {
    return <String>[];
  }

  void _startMeetingCheckTimer() {
    _meetingCheckTimer = Timer.periodic(const Duration(seconds: 5), (timer) {
      _checkMeetingStatus();
    });
  }

  Future<void> _checkMeetingStatus() async {
    try {
      final currentUrl = await _controller.currentUrl();
      debugPrint('Current URL: $currentUrl');

      if (currentUrl?.contains('zoom.us/postattendee') ?? false) {
        _endMeeting(reason: 'Meeting has ended');
        return;
      }

      if (currentUrl?.contains('zoom.us/thankyou') ?? false) {
        _endMeeting(reason: 'Meeting has ended');
        return;
      }

      final meetingEnded = await _controller.runJavaScriptReturningResult(
        '''
        (function() {
          const endedMessage = document.querySelector('[data-testid="meeting-ended"]') || 
                               document.querySelector('.meeting-ended') ||
                               document.querySelector('[aria-label*="meeting has ended"]');
          
          const isPostMeeting = window.location.href.includes('postattendee') ||
                                window.location.href.includes('thankyou') ||
                                document.title.toLowerCase().includes('thank you');
          
          return endedMessage !== null || isPostMeeting;
        })();
        ''',
      );

      if (meetingEnded.toString() == 'true') {
        _endMeeting(reason: 'Meeting has ended');
      }
    } catch (e) {
      debugPrint('Error checking meeting status: $e');
    }
  }

  void _endMeeting({String reason = ''}) async {
    if (_meetingEnded) return;

    if (mounted) {
      setState(() {
        _meetingEnded = true;
      });
    } else {
      _meetingEnded = true;
    }

    _meetingCheckTimer?.cancel();

    await _cleanupWebView();

    if (mounted) {
      Navigator.of(context).pop();
      if (reason.isNotEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(reason)),
        );
      }
    }
  }

  bool _initialLoad = true;

  @override
  Widget build(BuildContext context) {
    if (_initialLoad) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) {
          setState(() => _initialLoad = false);
          // _requestPermissions() already called in initState post-frame
        }
      });
    }

    if (_isLoadingPermissions || _isLoadingHeadset) {
      return Scaffold(
        appBar: Appbarhelper.pageAppbar(title: widget.topic, leading: false),
        body: const Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularProgressIndicator(),
              SizedBox(height: 16),
              Text('Checking requirements...'),
            ],
          ),
        ),
      );
    }

    if (!_permissionsGranted) {
      return Scaffold(
        appBar: Appbarhelper.pageAppbar(title: widget.topic, leading: false),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.mic_off,
                size: 64,
                color: Colors.grey,
              ),
              const SizedBox(height: 16),
              const Text(
                'Microphone and Camera permissions are required',
                style: TextStyle(fontSize: 18),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              const Text(
                'Please grant permissions to join the meeting',
                style: TextStyle(color: Colors.grey),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: _requestPermissions,
                child: const Text('Request Permissions'),
              ),
              const SizedBox(height: 8),
              TextButton(
                onPressed: () => openAppSettings(),
                child: const Text('Open App Settings'),
              ),
            ],
          ),
        ),
      );
    }

    if (!isHeadsetConnected) {
      return Scaffold(
        appBar: AppBar(
          title: Text(widget.topic),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.headset_off,
                size: 64,
                color: Colors.grey,
              ),
              const SizedBox(height: 16),
              const Text(
                'Headset is required to join this meeting',
                style: TextStyle(fontSize: 18),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              const Text(
                'Please connect wired or wireless headphones ',
                style: TextStyle(color: Colors.grey),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: _updateHeadsetState,
                child: const Text('Check Again'),
              ),
              const SizedBox(height: 8),
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('Cancel'),
              ),
            ],
          ),
        ),
      );
    }

    return WillPopScope(
      onWillPop: () async {
        ToastHelper.warningToast(context,
            title: 'Warning',
            desc: 'You cant go back without leaving the meeting');
        return false;
      },
      child: Scaffold(
        appBar: Appbarhelper.pageAppbar(title: widget.topic, leading: false),
        body: Stack(
          children: [
            if (_webViewInitialized)
              WebViewWidget(controller: _controller)
            else
              // show placeholder until webview finishes initial load
              const Center(child: CircularProgressIndicator()),
            Align(
              alignment: Alignment.topCenter,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                ),
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.vertical(
                    bottom: Radius.circular(Di.screenWidth * 0.1),
                  ),
                ),
                height: Di.screenWidth * 0.1,
                width: Di.screenWidth * 0.6,
                child: Center(
                    child: AppTextHelper.button(
                        text: widget.stuname, fcolor: AppColors.white)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
