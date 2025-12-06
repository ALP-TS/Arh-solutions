import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:b_soft_appliction/core/helpers/dialougehelper.dart';
import 'package:b_soft_appliction/core/helpers/toasthelper.dart';

import '../../../app/config/routes/route_name.dart';
import '../../../core/utils/debuprint.dart';
import '../../../domain/models/examdata_model.dart';
import '../../../domain/models/questionlist_model.dart';
import '../../../domain/repository/examrepo.dart';

class Examattendvm extends GetxController {
  final String examid;
  Examattendvm({required this.examid});
  @override
  void onInit() {
    super.onInit();
    getQuestions(examid);
    consolePrint(
      '==================> Exam Attend Controller Initialized',
    );
  }

  final api = Examrepo();
  RxInt currentindex = 0.obs;
  RxString selectedoption = ''.obs;
  RxBool isloading = false.obs;
  RxList<Question> questions = <Question>[].obs;
  final examData = Rxn<ExamDataModel>();

  int timeconvert(String time) {
    List<String> parts = time.split(':');

    // Parse hours and minutes as integers
    int hours = int.parse(parts[0]);
    int minutes = int.parse(parts[1]);

    // Calculate total minutes
    return (hours * 60) + minutes;
  }

  Future<void> nextquestion(String qusId, String ans) async {
    consolePrint(
        'Current Index ${currentindex.value}, ${questions.length - 1}');
    if (currentindex.value < questions.length - 1) {
      final status = await submitanswer(qusId, ans);
      if (status) {
        currentindex.value++;
        selectedoption.value = '';
      } else {
        Dialougehelper.error(Get.context, 'Error', 'Failed to submit answer');
      }
    } else if (currentindex.value == questions.length - 1) {
      final status = await submitanswer(qusId, ans);
      if (status) {
        await api.submitexam(examid);
        ToastHelper.successToast(Get.context,
            title: 'Success', desc: 'Exam submitted successfully');
        Get.offNamedUntil(
          RouteName.examresult,
          ModalRoute.withName(RouteName.navbar),
          arguments: examid,
        );

        // Get.offNamed(RouteName.navbar);
      } else {
        Dialougehelper.error(Get.context, 'Error', 'Failed to submit answer');
      }
    }
  }

  void previousquestion() {
    if (currentindex.value > 0) {
      currentindex.value--;
    }
  }

  void handleTimerFinish(bool finished) {
    Get.offNamed(RouteName.timeout);
  }

  void updateselection(String option) {
    if (selectedoption.value == option) {
      selectedoption.value = '';
    } else {
      selectedoption.value = option;
    }

    consolePrint('index ${selectedoption.value}');
  }

  Future<bool> submitanswer(String qusId, String ans) async {
    consolePrint(
        '==================>In Exam Attend VM (function submitanswer) Initialized');
    try {
      final response = await api.submitanswer(qusId, ans, examid);
      return true;
    } catch (e) {
      consolePrint(
          '==================> Exam Attend VM (function submitanswer) Error',
          e.toString());
      return false;
    } finally {
      consolePrint(
          '==================> Exam Attend VM (function submitanswer) Completed');
    }
  }

  Future<void> getQuestions(String examid) async {
    consolePrint(
        '==================>In Exam Attend VM (function getQuestions) Initialized');
    try {
      isloading.value = true;
      final response = await api.questions(examid);
      questions.value =
          (response['data'] as List).map((e) => Question.fromJson(e)).toList();
      examData.value = ExamDataModel.fromJson(response['exam']);
      // questions.assignAll(response.map((json) => Question.fromJson(json)).toList());
    } catch (e) {
      consolePrint(
          '==================> Exam Attend VM (function getQuestions) Error',
          e.toString());
    } finally {
      isloading.value = false;
      consolePrint(
          '==================> Exam Attend VM (function getQuestions) Completed');
    }
  }

  void onClose() {
    super.onClose();
    consolePrint('==================> Exam Attend Controller Closed');
  }
}
