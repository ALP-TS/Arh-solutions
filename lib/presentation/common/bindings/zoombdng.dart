import 'package:get/get.dart';

import '../viewmodel/zoomvm.dart';

class Zoombdng extends Bindings {
  @override
  void dependencies() {
    Get.put(ZoomVM());
  }
}