class Courseresponse {
  final String siteCourseid;
  final String relatedCourseid;
  final String course;
  final String subName;
  final String orgAmount;
  final String offerAmount;
  final String footerTag;
  final String highlight;
  final String profile;
  final String overview;
  final String specifications;
  final String requirements;
  final String duration;
  final String lectures;
  final String students;
  final String language;
  final String? previewVideo;
  final String? categoriesImg;

  Courseresponse({
    required this.siteCourseid,
    required this.relatedCourseid,
    required this.course,
    required this.subName,
    required this.orgAmount,
    required this.offerAmount,
    required this.footerTag,
    required this.highlight,
    required this.profile,
    required this.overview,
    required this.specifications,
    required this.requirements,
    required this.duration,
    required this.lectures,
    required this.students,
    required this.language,
    this.previewVideo,
    this.categoriesImg,
  });

  factory Courseresponse.fromJson(Map<String, dynamic> json) {
    return Courseresponse(
      siteCourseid: json['site_courseid'] ?? '',
      relatedCourseid: json['related_courseid'] ?? '',
      course: json['course'] ?? '',
      subName: json['sub_name'] ?? '',
      orgAmount: json['org_amount'] ?? '',
      offerAmount: json['offer_amount'] ?? '',
      footerTag: json['footer_tag'] ?? '',
      highlight: json['highlight'] ?? '',
      profile: json['profile'] ?? '',
      overview: json['overview'] ?? '',
      specifications: json['specifications'] ?? '',
      requirements: json['requirements'] ?? '',
      duration: json['duration'] ?? '',
      lectures: json['lectures'] ?? '',
      students: json['students'] ?? '',
      language: json['language'] ?? '',
      previewVideo: json['preview_video'],
      categoriesImg: json['categories_img'],
    );
  }

  int get discountPercentage {
    final org = int.tryParse(orgAmount) ?? 0;
    final offer = int.tryParse(offerAmount) ?? 0;
    if (org == 0) return 0;
    return (((org - offer) / org) * 100).round();
  }
}
