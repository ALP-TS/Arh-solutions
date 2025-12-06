class SignUpResponse {
  final String? name;
  final String? email;
  final String  classId;
  final String? password;
  final String? phone;
  final String? status;
  final String? message;
  final dynamic data;

  SignUpResponse({
    this.name,
    this.email,
    required this.classId,
    this.password,
    this.phone,
    this.status,
    this.message,
    this.data,
  });

  factory SignUpResponse.fromJson(Map<String, dynamic> json) {
    return SignUpResponse(
      name: json['name'],
      email: json['email'],
      classId: json['class_id'],
      password: json['password'],
      phone: json['phone'],
      status: json['status'],
      message: json['message'],
      data: json['data'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'class_id': classId,
      'password': password,
      'phone': phone,
      'status': status,
      'message': message,
      'data': data,
    };
  }
}
