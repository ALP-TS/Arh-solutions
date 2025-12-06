import 'dart:convert';

import 'package:get/get.dart';

import '../../../core/utils/debuprint.dart';
import '../../../domain/models/courselist_model.dart';
import '../../../domain/repository/coursedetailrepo.dart';

class CategoryVM extends GetxController {
  void onInit() {
    super.onInit();
    consolePrint(
      '==================> Category Controller Initialized',
    );
    getCategorylist();
    getCourselist();
  }

  RxBool isLoading = false.obs;
  RxBool iscourseloading = false.obs;
  RxString selectedCategory = 'All'.obs;
  final api = Coursedetailrepo();
  RxList<String> categoryList = <String>['All'].obs;
  RxList<CourseListModel> courseList = <CourseListModel>[].obs;

  void categorySelection(String value) {
    selectedCategory.value = value;
  }

  Future<void> getCategorylist() async {
    isLoading.value = true;
    categoryList.removeRange(1, categoryList.length);
    consolePrint('==================> Category Controller Initialized');
    try {
      final response = await api.getcoursecategory();
      if (response != null && response['data'] != null) {
        // Convert each item in the list to String
        final List<dynamic> dataList = response['data'];
        categoryList.addAll(dataList.map((item) => item.toString()).toList());

        // OR if the items are maps with a 'name' field:
        // categoryList.value = dataList.map((item) => item['name'].toString()).toList();
      }
      // return response;
    } catch (e) {
      consolePrint(
          '==================> Category Controller Error', e.toString());
    } finally {
      isLoading.value = false;
      consolePrint('==================> Category Controller Completed');
    }
  }

  Future<void> getCourselist() async {
    iscourseloading.value = true;
    consolePrint('==================> Category Controller Initialized');
    try {
      final response = await api.getcourselist();
      if (response != null && response['data'] != null) {
        // Convert each item in the list to String
        final List<dynamic> dataList = response['data'];
        courseList.value =
            dataList.map((item) => CourseListModel.fromJson(item)).toList();

        // OR if the items are maps with a 'name' field:
        // categoryList.value = dataList.map((item) => item['name'].toString()).toList();
      }
      // return response;
    } catch (e) {
      consolePrint(
          '==================> Category Controller Error', e.toString());
    } finally {
      iscourseloading.value = false;
      consolePrint('==================> Category Controller Completed');
    }
  }
}
