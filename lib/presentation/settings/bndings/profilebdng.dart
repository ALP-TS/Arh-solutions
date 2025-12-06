import 'package:get/get.dart';

import '../viewmodel/profilevm.dart';

class Profilebdng extends Bindings{
  @override
    void dependencies() {
    Get.put(Profilevm());
  }
}