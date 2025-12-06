import 'package:b_soft_appliction/core/utils/debuprint.dart';
import 'package:b_soft_appliction/domain/models/signup_model.dart';
import 'package:b_soft_appliction/domain/repository/signup_repo.dart';
import 'package:get/get.dart';

class SignUpvm extends GetxController {
  final api = SignupRepo();

  RxBool isLoading = false.obs;
  RxList<CourseData> coursedata = <CourseData>[].obs;

  @override
  void onInit() {
    super.onInit();
    consolePrint('==================> SignUp Controller Initializing');
    loadCourses();
  }

  // ================================
  // 🔥 LOAD COURSES FOR DROPDOWN
  // ================================
  Future<void> loadCourses() async {
    consolePrint('====================== Signup Courses Loading Started');

    try {
      isLoading.value = true;

      var response = await api.getCoursesForSignup();

      consolePrint("COURSE API RESPONSE => $response");

      // Handle NULL API response
      if (response == null) {
        consolePrint("Response is NULL");
        return;
      }

      // Ensure data exists
      if (response['data'] != null && response['data'] is List) {
        coursedata.value = (response['data'] as List)
            .map((e) => CourseData.fromJson(e))
            .toList();

        consolePrint(
            '====================== Courses Loaded: ${coursedata.length}');
      } else {
        consolePrint('====================== No course data found');
      }
    } catch (e) {
      consolePrint('========================= Signup Controller Error: $e');

      Get.snackbar(
        'Error',
        'Failed to load courses. Please try again.',
        snackPosition: SnackPosition.BOTTOM,
        duration: const Duration(seconds: 3),
      );
    } finally {
      isLoading.value = false;
      consolePrint("====================== Signup Controller Completed");
    }
  }

  // ================================
  // 🔥 SIGNUP API CALL (CORRECTED)
  // ================================
  Future<dynamic> submitSignup({
    required String name,
    required String email,
    required String password,
    required String phone,
    required String classId,
  }) async {
    consolePrint("Calling Signup API...");

    try {
      var response = await api.getSignupResponse(
        name: name,
        email: email,
        password: password,
        phone: phone,
        class_id: classId,
      );

      consolePrint("Signup Response: $response");

      return response;
    } catch (e) {
      consolePrint("Signup ERROR: $e");
      return null;
    }
  }

  // Refresh dropdown courses
  Future<void> refreshCourses() async {
    await loadCourses();
  }
}
