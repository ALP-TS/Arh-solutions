import 'package:get/get.dart';
import 'package:b_soft_appliction/presentation/common/viewmodel/splashvm.dart';
import 'package:b_soft_appliction/presentation/settings/viewmodel/profilevm.dart';

import '../../shared/viewmodel/shorebird_viewmodel.dart';

class SplashscreenBdng extends Bindings {
  @override
  void dependencies() {
    Get.put(SplashscreeVM());
    // Get.put(ShorebirdViewmodel());
    // Get.put(Profilevm());
  }
}
