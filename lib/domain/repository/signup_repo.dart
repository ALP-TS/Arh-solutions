import 'package:arh_solution_app/core/utils/debuprint.dart';
import 'package:arh_solution_app/data/network/network_api_services.dart';

import '../endpoints/appendpoints.dart';

class SignupRepo {
  final _apiService = NetworkApiServices();

  Future<dynamic> getCoursesForSignup() async {
    consolePrint(
      '======================> In SignupRepo (function getCoursesForSignup) Started',
    );

    consolePrint("URL => ${AppEndpoints.getCoursesForSignup}");

    dynamic response = await _apiService.getApi(
      AppEndpoints.getCoursesForSignup,
    );

    consolePrint(
      '======================> In SignupRepo (function getCoursesForSignup) Completed',
    );

    return response;
  }

  Future<dynamic> getSignupResponse({
    required String name,
    required String email,
    required String class_id,
    required String password,
    required String phone,
  }) async {
    final data = {
      "name": name,
      "email": email,
      "class_id": class_id,
      "password": password,
      "phone": phone,
    };
    consolePrint("signup registration initialized");
    consolePrint("URL => ${AppEndpoints.signUp}");
    dynamic response = await _apiService.postApi(data, AppEndpoints.signUp);
    consolePrint('======================> signup api is completed');
    return response;
  }
}
