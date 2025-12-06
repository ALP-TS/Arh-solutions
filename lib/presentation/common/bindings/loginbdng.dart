import 'package:get/get.dart';

import '../viewmodel/loginvm.dart';

class Loginbdng extends Bindings {
  @override
  void dependencies() {
    Get.put(LoginVM());
  }
}