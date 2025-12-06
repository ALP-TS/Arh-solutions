import 'package:flutter_headset_detector/flutter_headset_detector.dart';
import 'package:get/get.dart';

class HeadsetdetectionVM extends GetxController{
  late final HeadsetDetector headsetDetector;
  Map<HeadsetType, HeadsetState> headsetState = {
    HeadsetType.WIRED: HeadsetState.DISCONNECTED,
    HeadsetType.WIRELESS: HeadsetState.DISCONNECTED,
  };
  
}