// import 'dart:nativewrappers/_internal/vm/lib/internal_patch.dart';

import 'package:b_soft_appliction/domain/models/coursemodel.dart';
import 'package:b_soft_appliction/domain/models/signup_model.dart';
import 'package:get/get.dart';

import '../../../core/utils/debuprint.dart';

import '../../../domain/repository/coursedetailrepo.dart';

class CourseDetailsController extends GetxController {
  final Rx<Courseresponse?> courseData = Rx<Courseresponse?>(null);
  final RxBool isLoading = false.obs;
  final RxInt selectedTab = 0.obs;
  final api = Coursedetailrepo();
  final String courseId;

  CourseDetailsController({
    required this.courseId,
    // required this.classId,
  });
  // final classId = '5'; // Replace with actual classId as needed

  @override
  void onInit() {
    super.onInit();
    loadCourseData();
  }

  Future<void> loadCourseData() async {
    isLoading.value = true;
    consolePrint(
      '==================> Course Detail Controller Initialized',
    );
    try {
      final response = await api.getsinglecourse(courseId);
      courseData.value = Courseresponse.fromJson(response['data']);
      // ongoingCourses.value = (response['data'] as List)
      //     .map((e) => Course.fromJson(e))
      //     .toList();
    } catch (e) {
      consolePrint(
        '==================> Course Detail Controller Error',
        e.toString(),
      );
    } finally {
      isLoading.value = false;
      consolePrint(
        '==================> Course Detail Controller Completed',
      );
    }
    // isLoading.value = true;

    // // Simulating API response
    // final jsonData = {
    //   "site_courseid": "5",
    //   "related_courseid": "3",
    //   "course": "Plustwo",
    //   "sub_name": "school",
    //   "org_amount": "1999",
    //   "offer_amount": "999",
    //   "footer_tag": "",
    //   "highlight": "1",
    //   "profile":
    //       "https:\/\/pradeeps.coursenrich.com\/assets\/images\/1762661442.png",
    //   "overview":
    //       "Each chapter of chemistry in plustwo classes and its topics are separately categorized and recorded videos and PDF notes are available. Classes including previous questions and model question papers will be included as part of the class .",
    //   "specifications":
    //       " The classes are conducted by skilled teachers in a systematic and oderly manner. Through PRADEEPS ACADEMY learning app, you can easily study your subjects ,get full marks and A+.",
    //   "requirements": "Test",
    //   "duration": "50",
    //   "lectures": "1",
    //   "students": "0",
    //   "language": "English",
    //   "preview_video": null,
    //   "categories_img": null
    // };

    // courseData.value = CourseData.fromJson(jsonData);
    // isLoading.value = false;
  }

  void changeTab(int index) {
    selectedTab.value = index;
  }
}