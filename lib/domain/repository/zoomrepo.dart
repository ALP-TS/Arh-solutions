import 'package:b_soft_appliction/core/utils/debuprint.dart';
import 'package:b_soft_appliction/data/network/network_api_services.dart';

import '../../AuthPref.dart';
import '../endpoints/appendpoints.dart';

class Zoomrepo {
  final _apiService = NetworkApiServices();

  Future<dynamic> zoommeetinglist() async {
    consolePrint(
        '======================>In Zoom Repo (function zoommeetinglist) Started');
    final String? classId = await AuthPreferences.getclassId();
    consolePrint('url ${AppEndpoints.zoommeetlist + classId!}');

    dynamic response =
        await _apiService.getApi(AppEndpoints.zoommeetlist + classId);
    consolePrint(
        '======================>In Zoom Repo (function zoommeetinglist) Completed');
    return response;
  }
}
