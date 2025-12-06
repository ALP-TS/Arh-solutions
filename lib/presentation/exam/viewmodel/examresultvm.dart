import 'package:get/get.dart';

import '../../../core/utils/debuprint.dart';
import '../../../domain/models/markmodel.dart';
import '../../../domain/models/resultdata_model.dart';
import '../../../domain/repository/examrepo.dart';

class Examresultvm extends GetxController {
  final String examid;
  Examresultvm({required this.examid});
  @override
  void onInit() {
    super.onInit();
    getresult(examid);
    consolePrint(
      '==================> Exam Result Controller Initialized, Exam ID: $examid',
    );
  }

  final api = Examrepo();
  RxBool isloading = false.obs;
  RxList<ResultModel> resultData = RxList<ResultModel>([]);
  FResult? mark = null;
  Future<void> getresult(String examid) async {
    isloading.value = true;
    consolePrint(
      '==================>In Exam Result VM (function getresult) Initialized',
    );
    try {
      final response = await api.examresult(examid);
      resultData.value = (response['data'] as List)
          .map((e) => ResultModel.fromJson(e))
          .toList();
      mark = FResult.fromJson(response['f_result']);
      consolePrint(
        'resultData ${resultData.length}',
      );
    } catch (e) {
      consolePrint(
        '==================> Exam Result VM (function getresult) Error',
        e.toString(),
      );
    } finally {
      isloading.value = false;
      consolePrint(
        '==================> Exam Result VM (function getresult) Completed',
      );
    }
  }
}
