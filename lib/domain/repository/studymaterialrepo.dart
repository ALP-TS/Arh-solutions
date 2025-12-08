import 'package:arh_solution_app/core/utils/debuprint.dart';

import '../../AuthPref.dart';
import '../../data/network/network_api_services.dart';
import '../endpoints/appendpoints.dart';

class Studymaterialrepo {
  final _apiService = NetworkApiServices();
  Future<dynamic> getVideos(String topicId) async {
    consolePrint(
      '======================>In Studymaterialrepo (function getVideos) Started',
    );
    consolePrint('url ${AppEndpoints.videos + topicId}');
    dynamic response = await _apiService.getApi(AppEndpoints.videos + topicId);
    consolePrint(
      '======================>In Studymaterialrepo(function getVideos) Completed',
    );
    return response;
  }

  Future<dynamic> getnotes(String topicId) async {
    consolePrint(
      '======================>In Studymaterialrepo (function getnotes) Started',
    );
    consolePrint('url ${AppEndpoints.getNotes(topicId)}');
    dynamic response = await _apiService.getApi(
      await AppEndpoints.getNotes(topicId),
    );
    consolePrint(
      '======================>In Studymaterialrepo (function getnotes) Completed',
    );
    return response;
  }

  Future<dynamic> videoseen(String videoId) async {
    var data = {
      'video_id': videoId,
      'user_id': await AuthPreferences.getUserId(),
    };
    consolePrint(
      '======================>In Studymaterialrepo (function getnotes) Started',
    );
    consolePrint('url ${AppEndpoints.videoseen}');
    dynamic response = await _apiService.postApi(data, AppEndpoints.videoseen);
    consolePrint(
      '======================>In Studymaterialrepo (function getnotes) Completed',
    );

    if (response['status'] == 'success') {
      return true;
    } else {
      return false;
    }
  }

  Future<dynamic> noteseen(String noteId) async {
    var data = {
      'notes_id': noteId,
      'user_id': await AuthPreferences.getUserId(),
    };
    consolePrint(
      '======================>In Studymaterialrepo (function noteseenApi) Started',
    );
    consolePrint('url ${AppEndpoints.noteseen}');
    dynamic response = await _apiService.postApi(data, AppEndpoints.noteseen);
    consolePrint(
      '======================>In Studymaterialrepo (function noteseenApi) Completed',
    );
    if (response['status'] == 'success') {
      return true;
    } else {
      return false;
    }
  }
}
