class CourseData {
  final String course;
  final String relatedCourseId;

  CourseData({
    required this.course,
    required this.relatedCourseId,
  });

  factory CourseData.fromJson(Map<String, dynamic> json) {
    return CourseData(
      course: json['course'] ?? '',
      relatedCourseId: json['related_courseid'] ?? '',
    );
  }
}
