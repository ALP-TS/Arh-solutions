class AdminProfile {
  final String profileId;
  final String profileName;
  final String dashName;
  final String miniName;
  final String title;
  final String logo;
  final String wpNumber;
  final String termsCon;
  final String privacyPolicy;
  final String subDays;
  final String secureMod;
  final String examPermission;
  final String billNo;
  final String noticeboard;
  final String homeType;
  final String zoom;
  final dynamic diskSpaceLimit;
  final dynamic studentLimit;

  AdminProfile({
    required this.profileId,
    required this.profileName,
    required this.dashName,
    required this.miniName,
    required this.title,
    required this.logo,
    required this.wpNumber,
    required this.termsCon,
    required this.privacyPolicy,
    required this.subDays,
    required this.secureMod,
    required this.examPermission,
    required this.billNo,
    required this.noticeboard,
    required this.homeType,
    required this.zoom,
    this.diskSpaceLimit,
    this.studentLimit,
  });

  factory AdminProfile.fromJson(Map<String, dynamic> json) {
    return AdminProfile(
      profileId: json['profile_id'] as String,
      profileName: json['profile_name'] as String,
      dashName: json['dash_name'] as String,
      miniName: json['mini_name'] as String,
      title: json['title'] as String,
      logo: json['logo'] as String,
      wpNumber: json['wp_number'] as String,
      termsCon: json['terms_con'] as String,
      privacyPolicy: json['privacy_policy'] as String,
      subDays: json['sub_days'] as String,
      secureMod: json['secure_mod'] as String,
      examPermission: json['exam_permission'] as String,
      billNo: json['bill_no'] as String,
      noticeboard: json['noticeboard'] as String,
      homeType: json['home_type'] as String,
      zoom: json['zoom'] as String,
      diskSpaceLimit: json['disk_space_limit'],
      studentLimit: json['student_limit'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'profile_id': profileId,
      'profile_name': profileName,
      'dash_name': dashName,
      'mini_name': miniName,
      'title': title,
      'logo': logo,
      'wp_number': wpNumber,
      'terms_con': termsCon,
      'privacy_policy': privacyPolicy,
      'sub_days': subDays,
      'secure_mod': secureMod,
      'exam_permission': examPermission,
      'bill_no': billNo,
      'noticeboard': noticeboard,
      'home_type': homeType,
      'zoom': zoom,
      'disk_space_limit': diskSpaceLimit,
      'student_limit': studentLimit,
    };
  }
}