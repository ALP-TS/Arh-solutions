
import 'package:http/http.dart' as http;
import 'package:arh_solution_app/core/utils/debuprint.dart';
import 'package:arh_solution_app/data/app_exceptions.dart';
import 'dart:convert';
import 'dart:io';

import 'package:arh_solution_app/data/network/base_api_services.dart';



class NetworkApiServices extends BaseApiServices {
  @override
  Future<dynamic> getApi(String url) async {
    consolePrint('Get Api Call Started with url=========>', url);
    dynamic responseJson;
    try {
      final response = await http
          .get(Uri.parse(url))
          .timeout(const Duration(seconds: 10));
      responseJson = returnResponse(response);
    } on SocketException {
      throw InternetException('');
    } on RequestTimeOutException {
      throw RequestTimeOutException('');
    }
    // throw UnimplementedError();
    return responseJson;
  }

  @override
  Future<dynamic> postApi(var data, String url) async {
    dynamic responseJson;
    try {
      final response = await http
          .post(Uri.parse(url), body: data)
          .timeout(const Duration(seconds: 10));
      responseJson = returnResponse(response);
    } on SocketException {
      throw InternetException('');
    } on RequestTimeOutException {
      throw RequestTimeOutException('');
    }
    return responseJson;
  }

  dynamic returnResponse(http.Response response) {
    consolePrint(
      'Api response got with status code =========>',
      response.statusCode.toString(),
    );
    switch (response.statusCode) {
      case 200:
        consolePrint('Api response is =========>', response.body);
        dynamic responseJson = jsonDecode(response.body);

        consolePrint('Api response is =========111>', responseJson.toString());
        if (responseJson['status'] == 'success') {
          return responseJson;
        } else {
          consolePrint(responseJson['message']);
          // Dialougehelper.error(Get.context, 'Error', responseJson['message']);
        }
      // return responseJson;
      case 400:
        throw InvalidurlException(response.body.toString());
      default:
        throw FetchDataException(
          'Error occured while Communication with Server with StatusCode : ${response.statusCode}',
        );
    }
  }
}
