import 'package:get/get.dart';

import '../viewmodel/audiolistvm.dart';

class Audiolistbdng extends Bindings {
  @override
  void dependencies() {
    Get.put(Audiolistvm());
  }
}