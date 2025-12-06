class LoginModel {
  final String studentId;
  final String userId;
  final String classId;
  final String name;
  final String phone;
  final String expireDate;
  final List<int> seenVideo;
  final List<int> seenNote;
  final List<int> seenAudio;
  final String ip;
  final String? deviceId;
  final String status;
  final String? utype;

  LoginModel({
    required this.studentId,
    required this.userId,
    required this.classId,
    required this.name,
    required this.phone,
    required this.expireDate,
    required this.seenVideo,
    required this.seenNote,
    required this.seenAudio,
    required this.ip,
    required this.deviceId,
    required this.status,
    required this.utype,
  });

  factory LoginModel.fromJson(Map<String, dynamic> json) {
    return LoginModel(
      studentId: json['student_id'],
      userId: json['user_id'],
      classId: json['class_id'],
      name: json['name'],
      phone: json['phone'],
      expireDate: json['expire_date'],
      seenVideo: _parseCommaSeparatedInts(json['seen_video']),
      seenNote: _parseCommaSeparatedInts(json['seen_note']),
      seenAudio: _parseCommaSeparatedInts(json['seen_audio']),
      ip: json['ip'],
      deviceId: json['device_id'],
      status: json['status'],
      utype: json['utype']??'',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'student_id': studentId,
      'user_id': userId,
      'class_id': classId,
      'name': name,
      'phone': phone,
      'expire_date': expireDate,
      'seen_video': seenVideo.join(','),
      'seen_note': seenNote.join(','),
      'seen_audio': seenAudio.join(','),
      'ip': ip,
      'device_id': deviceId,
      'status': status,
      'utype': utype,
    };
  }

  static List<int> _parseCommaSeparatedInts(String data) {
    if (data.isEmpty) return [];
    return data.split(',').map(int.parse).toList();
  }
}
