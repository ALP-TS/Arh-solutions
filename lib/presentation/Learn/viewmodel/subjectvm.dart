import 'package:get/get.dart';
import 'package:arh_solution_app/core/utils/debuprint.dart';
import 'package:arh_solution_app/domain/repository/subjectrepo.dart';

import '../../../domain/models/subject_model.dart';

class SubjectVM extends GetxController {
  @override
  void onInit() {
    super.onInit();
    getSubjectlist();
    consolePrint('==================> Subject Controller Initialized');
  }

  final api = SubjectRepo();
  RxBool isLoading = false.obs;
  RxList<Subject> subjectList = <Subject>[].obs;
  double getpercent(int index) {
    int viewedcount =
        subjectList[index].viewedVideoCount +
        subjectList[index].viewedAudioCount +
        subjectList[index].viewedNotesCount;
    int totalcount =
        subjectList[index].videoCount +
        subjectList[index].audioCount +
        subjectList[index].notesCount;
    if (totalcount == 0) {
      return 0;
    }
    dynamic percent = viewedcount * 100 ~/ totalcount;

    return double.parse((percent).toStringAsFixed(2));
  }

  Future<void> getSubjectlist() async {
    isLoading.value = true;
    consolePrint('==================> Subject Controller Initialized');
    try {
      final response = await api.getSubjects();
      subjectList.value = (response['data'] as List)
          .map((e) => Subject.fromJson(e))
          .toList();
      consolePrint('subjectlength ${subjectList.length}');
    } catch (e) {
      consolePrint(
        '==================> Subject Controller Error',
        e.toString(),
      );
    } finally {
      isLoading.value = false;
      consolePrint('==================> Subject Controller Completed');
    }
  }
}
