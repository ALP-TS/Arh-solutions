import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:b_soft_appliction/domain/repository/profilerepo.dart';

import '../../../core/utils/debuprint.dart';
import '../../../domain/models/login_model.dart';
import '../../../domain/models/profile_model.dart';

class Profilevm extends GetxController {
  @override
  void onInit() {
    super.onInit();
    consolePrint(
      '==================> Profile Controller Initialized',
    );
  }

  final api = Profilerepo();
  RxBool isloading = false.obs;
  StudentData? profileData;
  Future<void> getProfile() async {
    isloading.value = true;
    consolePrint(
      '==================> Profile Controller Initialized',
    );
    try {
      final response = await api.profile();
      profileData = StudentData.fromJson(response['data']);
      consolePrint('profile data ${response['data']}');
    } catch (e) {
      consolePrint(
        '==================> Profile Controller Error',
        e.toString(),
      );
    } finally {
      isloading.value = false;
      consolePrint(
        '==================> Profile Controller Completed',
      );
    }
  }

  String timestampToDate(int timestamp, {String format = 'dd-MM-yyyy'}) {
    // Convert seconds to milliseconds (if timestamp is in seconds)
    final dateTime = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
    // Format the DateTime object
    return DateFormat(format).format(dateTime);
  }
}
