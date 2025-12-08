import 'package:get/get.dart';
import 'package:arh_solution_app/core/utils/debuprint.dart';
import 'package:arh_solution_app/domain/repository/examrepo.dart';

import '../../../app/config/routes/route_name.dart';
import '../../../domain/models/examlist_model.dart';

class Examlistvm extends GetxController {
  @override
  void onInit() {
    super.onInit();
    getExamslist();
  }

  RxString activeFilter = 'All'.obs;
  final api = Examrepo();
  RxList<ExamlistModel> examlist = <ExamlistModel>[].obs;

  void updatefilter(String filter) {
    activeFilter.value = filter;
  }

  void updateActiveFilter(String text) {
    activeFilter.value = text;
    update();
  }

  String getexamstatusbyfilter(String status) {
    if (activeFilter.value == 'All') {
      return activeFilter.value;
    } else if (status == 'Start Now') {
      return 'Upcoming';
    } else if (status == 'View Result') {
      return 'Completed';
    } else {
      return status;
    }
  }

  void navigation(String examtype, String examid) {
    switch (examtype) {
      case 'Start Now':
        Get.toNamed(RouteName.examinstruction, arguments: examid);

        break;
      case 'View Result':
        Get.toNamed(RouteName.examresult, arguments: examid);

        break;
      case 'Missed':
        // Get.toNamed(RouteName.exampage);

        break;
      default:
      // Get.toNamed(RouteName.exampage);
    }
  }

  Future<void> getExamslist() async {
    consolePrint(
      '==================>In Exam VM (function getExamslist) Initialized',
    );
    try {
      final response = await api.examslist();
      examlist.value = (response['data'] as List)
          .map((e) => ExamlistModel.fromJson(e))
          .toList();
    } catch (e) {
      consolePrint(
        '==================> Exam VM (function getExamslist) Error',
        e.toString(),
      );
    } finally {
      consolePrint(
        '==================> Exam VM (function getExamslist) Completed',
      );
    }
  }
}
