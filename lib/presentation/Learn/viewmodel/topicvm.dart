import 'package:get/get.dart';
import 'package:arh_solution_app/domain/models/topic_model.dart';
import 'package:arh_solution_app/domain/repository/topicrepo.dart';

import '../../../core/utils/debuprint.dart';
import '../view/topic/topiclist.dart';

class TopicVM extends GetxController {
  final String subjectId;
  TopicVM({required this.subjectId});

  @override
  void onInit() {
    super.onInit();
    getTopics(subjectId);
    consolePrint('==================> Topic Controller Initialized');
  }

  final api = Topicrepo();
  RxBool isLoading = false.obs;
  RxList<TopicData> topicList = <TopicData>[].obs;

  Future<void> getTopics(String subId) async {
    consolePrint('==================> Topic Controller Initialized');
    try {
      isLoading.value = true;
      final response = await api.topiclist(subId);
      topicList.value = (response['data'] as List)
          .map((e) => TopicData.fromJson(e))
          .toList();
    } catch (e) {
      consolePrint('==================> Topic Controller Error', e.toString());
    } finally {
      isLoading.value = false;
      consolePrint('==================> Topic Controller Completed');
    }
  }
}
