import 'package:get/get.dart';
import 'package:b_soft_appliction/core/utils/debuprint.dart';
import 'package:b_soft_appliction/domain/repository/coursedetailrepo.dart';

import '../../../domain/models/coursedetails_model.dart';

class CoursedetailVM extends GetxController {
  @override
  void onInit() {
    super.onInit();
    consolePrint(
      '==================> Course Detail Controller Initialized',
    );
    getCourse();
  }

  final api = Coursedetailrepo();
  RxBool isloading = false.obs;
  // RxList<Course> ongoingCourses = <Course>[].obs;
  Course? ongoingCourses;

  Future<void> getCourse() async {
    isloading.value = true;
    consolePrint(
      '==================> Course Detail Controller Initialized',
    );
    try {
      final response = await api.getcoursedetails();
      ongoingCourses = Course.fromJson(response['data']);
      // ongoingCourses.value = (response['data'] as List)
      //     .map((e) => Course.fromJson(e))
      //     .toList();
      print('');
    }
     catch (e) {
      consolePrint(
        '==================> Course Detail Controller Error',
        e.toString(),
      );
    } finally {
      isloading.value = false;
      consolePrint(
        '==================> Course Detail Controller Completed',
      );
    }
  }
}
