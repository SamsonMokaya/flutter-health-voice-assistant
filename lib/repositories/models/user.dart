class UserModel {
  final String? userId;
  final String? firstName;
  final String? lastName;
  final bool otpVerified;
  final String? email;
  final String? token;
  final String? password;
  final String? otp;

  const UserModel({
    this.userId,
    this.otp,
    required this.otpVerified,
    this.password,
    this.token,
    this.firstName,
    this.lastName,
    this.email,
  });

  static UserModel empty = const UserModel(
      userId: '',
      firstName: '',
      lastName: '',
      email: '',
      otpVerified: false,
      token: '',
      password: '',
      otp: '');

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      userId: json['userId'] ?? '',
      firstName: json['firstName'] ?? '',
      lastName: json['lastName'] ?? '',
      email: json['email'] ?? '',
      otpVerified: json['otpVerified'] ?? false,
      token: json['token'] ?? '',
      password: json['password'] ?? '',
      otp: json['otp'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'otpVerified': otpVerified,
      'otp': otp,
      'token': token,
      'password': password,
    };
  }
}
