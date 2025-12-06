import 'dart:io';

// import 'package:flutter_windowmanager/flutter_windowmanager.dart';
// import 'package:image_picker/image_picker.dart';
import 'package:b_soft_appliction/app/config/localization/languages.dart';
import 'package:b_soft_appliction/app/config/routes/routes.dart';
import 'package:b_soft_appliction/app/config/theme/colors.dart';
import 'package:b_soft_appliction/core/constant/constants.dart';
import 'package:b_soft_appliction/core/utils/debuprint.dart';

import 'package:b_soft_appliction/presentation/shared/view/custom_flutter_error.dart';
import 'package:b_soft_appliction/presentation/shared/view/network_not_found.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:screen_protector/screen_protector.dart';
import 'package:shorebird_code_push/shorebird_code_push.dart';
import 'package:media_kit/media_kit.dart';
import 'package:toastification/toastification.dart';
// import 'package:camera/camera.dart';
// import 'package:record/record.dart';
import 'presentation/settings/bndings/profilebdng.dart';
import 'presentation/shared/viewmodel/network_viewmodel.dart';

import 'presentation/shared/viewmodel/shorebird_viewmodel.dart';
import 'package:path_provider/path_provider.dart';

Directory? tempDirectory;
Directory? appDocumentsDirectory;
final shorebirdCodePush = ShorebirdCodePush();
Future<void> main() async {
  HttpOverrides.global = new MyHttpOverrides();
  WidgetsFlutterBinding.ensureInitialized();
  MediaKit.ensureInitialized();
  try {
    tempDirectory = await getTemporaryDirectory();
    appDocumentsDirectory = await getApplicationDocumentsDirectory();
    debugPrint('Temp dir: ${tempDirectory!.path}');
    debugPrint('App docs dir: ${appDocumentsDirectory!.path}');
  } catch (e) {
    debugPrint('Directory initialization failed: $e');
  }
  try {
    // await ScreenProtector.preventScreenshotOn();
    consolePrint("Screen Protection", "Screenshot protection enabled");
  } catch (e) {
    consolePrint("Screen Protection Error", e.toString());
  }
  Get.put(NetworkController(), permanent: true);
  ErrorWidget.builder = (FlutterErrorDetails errorDetails) {
    consolePrint("Flutter Error Caught", errorDetails.exception.toString());
    return CustomFlutterErrorWidget(errorDetails: errorDetails);
  };
  runApp(const ToastificationWrapper(child: MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  secureScreen() async {
    // await FlutterWindowManager.addFlags(FlutterWindowManager.FLAG_SECURE);
    // await FlutterWindowManager.addFlags(
    //     FlutterWindowManager.FLAG_KEEP_SCREEN_ON);
  }

  // final AudioRecorder _recorder = AudioRecorder();
  // List<CameraDescription>? _cameras;
  // bool _cameraPermissionGranted = false;
  // bool _microphonePermissionGranted = false;
  // final ImagePicker _picker = ImagePicker();
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    ShorebirdViewmodel().checkForUpdates(context);
    // getPermissions();
    // secureScreen();
  }

  @override
  void dispose() {
    // _recorder.dispose();
    // _disableScreenProtection();
    super.dispose();
  }

  // Future<void> getPermissions() async {
  // Check current status
  // await _checkCameraPermission();
  // await _checkMicrophonePermission();
  // await _requestCameraPermission();
  // }

  // Future<void> _requestCameraPermission() async {
  //   setState(() {
  //     // _isLoading = true;
  //     // _statusMessage = 'Requesting camera permission...';
  //   });

  //   try {
  //     // This will automatically request camera permission if not granted
  //     final XFile? image = await _picker.pickImage(
  //       source: ImageSource.camera,
  //       maxWidth: 800,
  //       maxHeight: 600,
  //       imageQuality: 80,
  //     );

  //     if (image != null) {
  //       setState(() {
  //         _cameraPermissionGranted = true;
  //         // _selectedImage = File(image.path);
  //         // _statusMessage = 'Camera permission granted!';
  //       });
  //       // _showSuccessDialog('Camera permission granted successfully!');
  //     } else {
  //       setState(() {
  //         // _statusMessage = 'Camera permission denied or cancelled';
  //       });
  //     }
  //   } catch (e) {
  //     setState(() {
  //       _cameraPermissionGranted = false;
  //       // _statusMessage = 'Camera permission denied: $e';
  //     });
  //     // _showErrorDialog(
  //     // 'Camera access failed. Please grant camera permission in Settings.');
  //   } finally {
  //     setState(() {
  //       // _isLoading = false;
  //     });
  //   }
  // }

  // Future<void> _checkMicrophonePermission() async {
  //   try {
  //     final hasPermission = await _recorder.hasPermission();
  //     setState(() {
  //       _microphonePermissionGranted = hasPermission;
  //     });
  //   } catch (e) {
  //     print('Microphone check failed: $e');
  //     setState(() {
  //       _microphonePermissionGranted = false;
  //     });
  //   }
  // }

  // Future<void> _checkCameraPermission() async {
  //   try {
  //     _cameras = await availableCameras();
  //     setState(() {
  //       _cameraPermissionGranted = _cameras?.isNotEmpty ?? false;
  //     });
  //   } catch (e) {
  //     print('Camera check failed: $e');
  //     setState(() {
  //       _cameraPermissionGranted = false;
  //     });
  //   }
  // }

  // Alternative: Request permissions individually
  Future<bool> requestMicrophonePermission() async {
    final status = await Permission.microphone.request();
    return status == PermissionStatus.granted;
  }

  Future<bool> requestCameraPermission() async {
    final status = await Permission.camera.request();
    return status == PermissionStatus.granted;
  }

  // Check if permission is granted
  Future<bool> isMicrophonePermissionGranted() async {
    return await Permission.microphone.isGranted;
  }

  Future<bool> isCameraPermissionGranted() async {
    return await Permission.camera.isGranted;
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.resumed:
        // Re-enable protection when app comes back to foreground
        // _enableScreenProtection();
        break;
      case AppLifecycleState.paused:
        // Keep protection on when app goes to background
        break;
      case AppLifecycleState.inactive:
        // App is inactive (like during a phone call)
        break;
      case AppLifecycleState.detached:
        // App is detached
        _disableScreenProtection();
        break;
      case AppLifecycleState.hidden:
      // TODO: Handle this case.
    }
  }

  void _enableScreenProtection() async {
    try {
      await ScreenProtector.preventScreenshotOn();
      consolePrint("Screen Protection", "Screenshot protection re-enabled");
    } catch (e) {
      consolePrint("Screen Protection Error", e.toString());
    }
  }

  void _disableScreenProtection() async {
    try {
      await ScreenProtector.preventScreenshotOff();
      consolePrint("Screen Protection", "Screenshot protection disabled");
    } catch (e) {
      consolePrint("Screen Protection Error", e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFFF4F8FB),
        colorScheme: const ColorScheme.light(primary: AppColors.primary),
      ),
      title: Constants.appname,
      debugShowCheckedModeBanner: false,
      translations: Languages(),
      locale: Get.deviceLocale,
      fallbackLocale: const Locale('en', 'US'),
      initialBinding: Profilebdng(),
      // home: CourseDetailPage(),
      getPages: AppRoutes.routes,
      builder: (context, child) {
        return Scaffold(
          body: Stack(
            children: [
              child ?? const SizedBox.shrink(),
              const NetworkNotFound(),
            ],
          ),
        );
      },
    );
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
