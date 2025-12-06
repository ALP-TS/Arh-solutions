class StudentData {
  final String feeStatus;
  final String userId;
  final String studentId;
  final String email;
  final String name;
  final String phone;
  final int expireDate;
  final String status;
  final String studentClass;

  StudentData({
    required this.feeStatus,
    required this.userId,
    required this.studentId,
    required this.email,
    required this.name,
    required this.phone,
    required this.expireDate,
    required this.status,
    required this.studentClass,
  });

  factory StudentData.fromJson(Map<String, dynamic> json) {
    return StudentData(
      feeStatus: json['fee_status'] as String,
      userId: json['user_id'] as String,
      studentId: json['student_id'] as String,
      email: json['email'] as String,
      name: json['name'] as String,
      phone: json['phone'] as String,
      expireDate: int.tryParse(json['expire_date'] ?? '') ?? 0,
      status: json['status'] as String,
      studentClass: json['class'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'fee_status': feeStatus,
      'user_id': userId,
      'student_id': studentId,
      'email': email,
      'name': name,
      'phone': phone,
      'expire_date': expireDate,
      'status': status,
      'class': studentClass,
    };
  }
}
