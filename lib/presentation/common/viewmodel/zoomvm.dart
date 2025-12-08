import 'package:get/get.dart';
import 'package:arh_solution_app/domain/repository/zoomrepo.dart';

import '../../../core/utils/debuprint.dart';
import '../../../domain/models/zoommeetlist_model.dart';

class ZoomVM extends GetxController {
  void onInit() {
    super.onInit();
    getZoomlist();
    consolePrint('==================> Zoom Controller Initialized');
  }

  final api = Zoomrepo();
  RxInt swipcard = 0.obs;
  RxBool isloading = false.obs;
  RxList<ZoomMeeting> meetlist = <ZoomMeeting>[].obs;

  Future<void> getZoomlist() async {
    swipcard.value = 0;
    isloading.value = true;
    consolePrint('==================> Zoom Controller Initialized');
    try {
      final response = await api.zoommeetinglist();
      meetlist.value = (response['data'] as List)
          .map((e) => ZoomMeeting.fromJson(e))
          .toList();
    } catch (e) {
      consolePrint('==================> Zoom Controller Error', e.toString());
    } finally {
      isloading.value = false;
      consolePrint('==================> Zoom Controller Completed');
    }
  }
}
