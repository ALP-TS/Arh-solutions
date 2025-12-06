import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_headset_detector/flutter_headset_detector.dart';
import 'package:media_kit/media_kit.dart';
import 'package:media_kit_video/media_kit_video.dart';

class HeadsetVideoPlayer extends StatefulWidget {
  const HeadsetVideoPlayer({super.key});

  @override
  State<HeadsetVideoPlayer> createState() => _HeadsetVideoPlayerState();
}

class _HeadsetVideoPlayerState extends State<HeadsetVideoPlayer> {
  late final Player player;
  late final VideoController videoController;

  bool isInitialized = false;
  late String videoUrl;
  Duration currentPosition = Duration.zero;
  Duration totalDuration = Duration.zero;
  bool isFullScreen = false;

  @override
  void initState() {
    super.initState();
  }

  bool _isInitDone = false; // ✅ to prevent re-initialization

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (!_isInitDone) {
      videoUrl = ModalRoute.of(context)!.settings.arguments as String;
      _initialize(); // ✅ now videoUrl is ready
      _isInitDone = true;
    }
  }

  Future<void> _initialize() async {
    player = Player();
    videoController = VideoController(player);

    // Load video
    await player.open(Media(videoUrl));

    // Listen to position and duration changes
    player.streams.position.listen((position) {
      if (!mounted) return;
      setState(() => currentPosition = position);
    });

    player.streams.duration.listen((duration) {
      if (!mounted) return;
      setState(() => totalDuration = duration);
    });

    setState(() => isInitialized = true);
    player.pause();
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final hours = twoDigits(duration.inHours);
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));

    return duration.inHours > 0
        ? '$hours:$minutes:$seconds'
        : '$minutes:$seconds';
  }

  void _seekBackward() {
    final newPosition = currentPosition - const Duration(seconds: 10);
    player.seek(newPosition.isNegative ? Duration.zero : newPosition);
  }

  void _seekForward() {
    final newPosition = currentPosition + const Duration(seconds: 10);
    player.seek(newPosition > totalDuration ? totalDuration : newPosition);
  }

  void _toggleFullScreen() {
    setState(() {
      isFullScreen = !isFullScreen;
    });
  }

  void _togglePlayPause() {
    if (player.state.playing) {
      player.pause();
    } else {
      player.play();
    }
  }

  @override
  void dispose() {
    player.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!isInitialized) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    return Scaffold(
      appBar: isFullScreen ? null : AppBar(title: const Text('Video Player')),
      body: Column(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: _togglePlayPause,
              child: Video(controller: videoController),
            ),
          ),
          if (!isFullScreen)
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Row(
                    children: [
                      Text(_formatDuration(currentPosition)),
                      Expanded(
                        child: Slider(
                          value: totalDuration.inMilliseconds > 0
                              ? (currentPosition.inMilliseconds
                                    .toDouble()
                                    .clamp(
                                      0,
                                      totalDuration.inMilliseconds.toDouble(),
                                    ))
                              : 0.0,
                          min: 0,
                          max: totalDuration.inMilliseconds > 0
                              ? totalDuration.inMilliseconds.toDouble()
                              : 1.0,
                          onChanged: (value) {
                            final position = Duration(
                              milliseconds: value.toInt(),
                            );
                            player.seek(position);
                          },
                        ),
                      ),
                      Text(_formatDuration(totalDuration)),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.replay_10),
                        onPressed: _seekBackward,
                      ),
                      IconButton(
                        icon: Icon(
                          player.state.playing ? Icons.pause : Icons.play_arrow,
                        ),
                        iconSize: 48,
                        onPressed: _togglePlayPause,
                      ),
                      IconButton(
                        icon: const Icon(Icons.forward_10),
                        onPressed: _seekForward,
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16.0,
                    vertical: 8.0,
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.volume_up),
                      Expanded(
                        child: Slider(
                          value: player.state.volume,
                          min: 0,
                          max: 100,
                          onChanged: (value) => player.setVolume(value),
                        ),
                      ),
                      IconButton(
                        icon: Icon(
                          isFullScreen
                              ? Icons.fullscreen_exit
                              : Icons.fullscreen,
                        ),
                        onPressed: _toggleFullScreen,
                      ),
                    ],
                  ),
                ),
              ],
            ),
        ],
      ),
    );
  }
}
// class HeadsetVideoPlayer extends StatefulWidget {
//   const HeadsetVideoPlayer({super.key});

//   @override
//   State<HeadsetVideoPlayer> createState() => _HeadsetVideoPlayerState();
// }

// class _HeadsetVideoPlayerState extends State<HeadsetVideoPlayer> {
//   late final HeadsetDetector headsetDetector;
//   late final Player player;
//   late final VideoController videoController;
//   Timer? headsetCheckTimer;

//   Map<HeadsetType, HeadsetState> headsetState = {
//     HeadsetType.WIRED: HeadsetState.DISCONNECTED,
//     HeadsetType.WIRELESS: HeadsetState.DISCONNECTED,
//   };

//   bool wasPlayingBeforeDisconnect = false;
//   bool isInitialized = false;
//   late String videoUrl;
//   Duration currentPosition = Duration.zero;
//   Duration totalDuration = Duration.zero;
//   bool isFullScreen = false;

//   bool get isAnyHeadsetConnected {
//     return headsetState[HeadsetType.WIRED] == HeadsetState.CONNECTED ||
//         headsetState[HeadsetType.WIRELESS] == HeadsetState.CONNECTED;
//   }

//   @override
//   void initState() {
//     super.initState();

//     _initialize();
//   }

//   @override
//   void didChangeDependencies() {
//     super.didChangeDependencies();
//     videoUrl = ModalRoute.of(context)!.settings.arguments as String;
//   }

//   Future<void> _initialize() async {
//     headsetDetector = HeadsetDetector();
//     player = Player();
//     videoController = VideoController(player);
//     await _updateHeadsetState();

//     headsetDetector.setListener((event) {
//       debugPrint('Headset event: $event');
//       switch (event) {
//         case HeadsetChangedEvent.WIRED_CONNECTED:
//           setState(() {
//             headsetState[HeadsetType.WIRED] = HeadsetState.CONNECTED;
//           });
//           break;
//         case HeadsetChangedEvent.WIRED_DISCONNECTED:
//           setState(() {
//             headsetState[HeadsetType.WIRED] = HeadsetState.DISCONNECTED;
//           });
//           break;
//         case HeadsetChangedEvent.WIRELESS_CONNECTED:
//           setState(() {
//             headsetState[HeadsetType.WIRELESS] = HeadsetState.CONNECTED;
//           });
//           break;
//         case HeadsetChangedEvent.WIRELESS_DISCONNECTED:
//           setState(() {
//             headsetState[HeadsetType.WIRELESS] = HeadsetState.DISCONNECTED;
//           });
//           break;
//       }

//       _handleHeadsetChange();
//     });

//     // Setup periodic headset check (as backup for unreliable events)
//     // headsetCheckTimer = Timer.periodic(const Duration(seconds: 2), () {
//     //   _updateHeadsetState();
//     // });
//     headsetCheckTimer = Timer.periodic(const Duration(seconds: 2), (_) {
//       _updateHeadsetState();
//     });
//     // Load video
//     await player.open(Media(videoUrl
//         // 'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4'
//         ));

//     // Listen to position and duration changes
//     player.streams.position.listen((position) {
//       if (!mounted) return;
//       setState(() => currentPosition = position);
//     });

//     player.streams.duration.listen((duration) {
//       if (!mounted) return;
//       setState(() => totalDuration = duration);
//     });

//     setState(() => isInitialized = true);
//     player.pause();
//   }

//   Future<void> _updateHeadsetState() async {
//     try {
//       final previousConnected = isAnyHeadsetConnected;
//       final currentState = await headsetDetector.getCurrentState;

//       if (!mounted) return;

//       setState(() {
//         headsetState = currentState;
//       });

//       // Only handle change if connection status actually changed
//       if (previousConnected != isAnyHeadsetConnected) {
//         debugPrint('Headset state changed from poll: $headsetState');
//         _handleHeadsetChange();
//       }
//     } catch (e) {
//       debugPrint('Error checking headset state: $e');
//     }
//   }

//   void _handleHeadsetChange() {
//     debugPrint('Handling headset state change: $headsetState');
//     if (!mounted) return;

//     if (isAnyHeadsetConnected) {
//       debugPrint(
//           'Headset connected. wasPlayingBeforeDisconnect: $wasPlayingBeforeDisconnect');
//       if (wasPlayingBeforeDisconnect) {
//         debugPrint('Resuming playback');
//         player.play();
//         wasPlayingBeforeDisconnect = false;
//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(
//             content: Text('Headset connected - video resumed'),
//             duration: Duration(seconds: 2),
//           ),
//         );
//       }
//     } else {
//       debugPrint('Headset disconnected. isPlaying: ${player.state.playing}');
//       if (player.state.playing) {
//         debugPrint('Pausing playback');
//         wasPlayingBeforeDisconnect = true;
//         player.pause();
//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(
//             content: Text('Headset disconnected - video paused'),
//             duration: Duration(seconds: 2),
//           ),
//         );
//       }
//     }
//   }

//   String _formatDuration(Duration duration) {
//     String twoDigits(int n) => n.toString().padLeft(2, '0');
//     final hours = twoDigits(duration.inHours);
//     final minutes = twoDigits(duration.inMinutes.remainder(60));
//     final seconds = twoDigits(duration.inSeconds.remainder(60));

//     return duration.inHours > 0
//         ? '$hours:$minutes:$seconds'
//         : '$minutes:$seconds';
//   }

//   void _seekBackward() {
//     final newPosition = currentPosition - const Duration(seconds: 10);
//     player.seek(newPosition.isNegative ? Duration.zero : newPosition);
//   }

//   void _seekForward() {
//     final newPosition = currentPosition + const Duration(seconds: 10);
//     player.seek(newPosition > totalDuration ? totalDuration : newPosition);
//   }

//   void _toggleFullScreen() {
//     setState(() {
//       isFullScreen = !isFullScreen;
//     });
//   }

//   void _togglePlayPause() {
//     if (player.state.playing) {
//       player.pause();
//     } else {
//       if (isAnyHeadsetConnected) {
//         player.play();
//       } else {
//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(
//             content: Text('Please connect headphones to play video'),
//             duration: Duration(seconds: 2),
//           ),
//         );
//       }
//     }
//   }

//   @override
//   void dispose() {
//     headsetCheckTimer?.cancel();
//     headsetDetector.removeListener();
//     player.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     if (!isInitialized) {
//       return const Scaffold(
//         body: Center(child: CircularProgressIndicator()),
//       );
//     }

//     return Scaffold(
//       appBar: isFullScreen
//           ? null
//           : AppBar(
//               title: const Text('Headset Video Player'),
//               actions: [
//                 IconButton(
//                   icon: Icon(
//                     isAnyHeadsetConnected ? Icons.headset : Icons.headset_off,
//                     color: isAnyHeadsetConnected ? Colors.green : Colors.red,
//                   ),
//                   onPressed: _updateHeadsetState,
//                   tooltip: 'Refresh headset status',
//                 ),
//                 const SizedBox(width: 8),
//               ],
//             ),
//       body: Column(
//         children: [
//           Expanded(
//             child: Stack(
//               children: [
//                 GestureDetector(
//                   onTap: _togglePlayPause,
//                   child: Video(controller: videoController),
//                 ),
//                 if (!isAnyHeadsetConnected)
//                   Container(
//                     color: Colors.black54,
//                     child: Center(
//                       child: Column(
//                         mainAxisSize: MainAxisSize.min,
//                         children: [
//                           const Icon(Icons.headset_off,
//                               size: 64, color: Colors.white),
//                           const SizedBox(height: 16),
//                           Text(
//                             'Please connect headphones',
//                             style: Theme.of(context)
//                                 .textTheme
//                                 .titleLarge
//                                 ?.copyWith(
//                                   color: Colors.white,
//                                 ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 // Playback indicator overlay
//                 if (player.state.playing)
//                   Positioned.fill(
//                     child: GestureDetector(
//                       onTap: _togglePlayPause,
//                       child: AnimatedOpacity(
//                         opacity: 0.0,
//                         duration: const Duration(seconds: 1),
//                         child: Container(
//                           color: Colors.black26,
//                           child: const Center(
//                             child: Icon(
//                               Icons.play_arrow,
//                               size: 80,
//                               color: Colors.white70,
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//               ],
//             ),
//           ),
//           if (!isFullScreen)
//             Column(
//               children: [
//                 Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 16.0),
//                   child: Row(
//                     children: [
//                       Text(_formatDuration(currentPosition)),
//                       Expanded(
//                         child: Slider(
//                           value: totalDuration.inMilliseconds > 0
//                               ? (currentPosition.inMilliseconds
//                                   .toDouble()
//                                   .clamp(0,
//                                       totalDuration.inMilliseconds.toDouble()))
//                               : 0.0,
//                           min: 0,
//                           max: totalDuration.inMilliseconds > 0
//                               ? totalDuration.inMilliseconds.toDouble()
//                               : 1.0,
//                           onChanged: isAnyHeadsetConnected
//                               ? (value) {
//                                   final position =
//                                       Duration(milliseconds: value.toInt());
//                                   player.seek(position);
//                                 }
//                               : null,
//                         ),
//                       ),
//                       Text(_formatDuration(totalDuration)),
//                     ],
//                   ),
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.all(16.0),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                     children: [
//                       IconButton(
//                         icon: const Icon(Icons.replay_10),
//                         onPressed: isAnyHeadsetConnected ? _seekBackward : null,
//                       ),
//                       IconButton(
//                         icon: Icon(player.state.playing
//                             ? Icons.pause
//                             : Icons.play_arrow),
//                         iconSize: 48,
//                         onPressed:
//                             isAnyHeadsetConnected ? _togglePlayPause : null,
//                       ),
//                       IconButton(
//                         icon: const Icon(Icons.forward_10),
//                         onPressed: isAnyHeadsetConnected ? _seekForward : null,
//                       ),
//                     ],
//                   ),
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.symmetric(
//                       horizontal: 16.0, vertical: 8.0),
//                   child: Row(
//                     children: [
//                       const Icon(Icons.volume_up),
//                       Expanded(
//                         child: Slider(
//                           value: player.state.volume,
//                           min: 0,
//                           max: 100,
//                           onChanged: isAnyHeadsetConnected
//                               ? (value) => player.setVolume(value)
//                               : null,
//                         ),
//                       ),
//                       IconButton(
//                         icon: Icon(isFullScreen
//                             ? Icons.fullscreen_exit
//                             : Icons.fullscreen),
//                         onPressed: _toggleFullScreen,
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//         ],
//       ),
//     );
//   }
// }
