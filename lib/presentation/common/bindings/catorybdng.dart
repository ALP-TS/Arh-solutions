import 'package:get/get.dart';

import '../viewmodel/categoryvm.dart';

class Catorybdng extends Bindings {
  @override
  void dependencies() {
    Get.put(CategoryVM());
  }
}
