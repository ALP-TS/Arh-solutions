import 'package:b_soft_appliction/core/utils/debuprint.dart';

import '../../data/network/network_api_services.dart';
import '../endpoints/appendpoints.dart';

class Coursedetailrepo {
  final _apiService = NetworkApiServices();

  Future<dynamic> getcoursedetails() async {
    consolePrint(
        '======================>In Course Detail Repo (function getcoursedetailz) Started');

    consolePrint('url ${AppEndpoints.getCoursedetails()}');
    dynamic response =
        await _apiService.getApi(await AppEndpoints.getCoursedetails());
    consolePrint(
        '======================>In Course Detail Repo (function getcoursedetailz) Completed');
    return response;
  }

  Future<dynamic> getcoursecategory() async {
    consolePrint(
        '======================>In Course Detail Repo (function getcoursedetailz) Started');

    consolePrint('url ${AppEndpoints.category}');
    dynamic response = await _apiService.getApi(AppEndpoints.category);
    consolePrint(
        '======================>In Course Detail Repo (function getcoursedetailz) Completed');
    return response;
  }

  Future<dynamic> getcourselist() async {
    consolePrint(
        '======================>In Course Detail Repo (function getcourselist) Started');

    consolePrint('url ${AppEndpoints.courselist}');
    dynamic response = await _apiService.getApi(AppEndpoints.courselist);
    consolePrint(
        '======================>In Course Detail Repo (function getcourselist) Completed');
    return response;
  }
  Future<dynamic> getsinglecourse(classId) async {
    consolePrint(
        '======================>In Course Detail Repo (function getcoursedetailz) Started');
    consolePrint('url ${AppEndpoints.getSingleCoursedetails(classId)}');
    dynamic response = await _apiService
        .getApi(await AppEndpoints.getSingleCoursedetails(classId));
    consolePrint(
        '======================>In Course Detail Repo (function getcoursedetailz) Completed');
    return response;
  }
}
