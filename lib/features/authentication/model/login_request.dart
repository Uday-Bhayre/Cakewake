class LoginRequest {
  final String mobileNumber;
  final String otp;

  LoginRequest({required this.mobileNumber, required this.otp});

  Map<String, dynamic> toJson() => {'mobileNumber': mobileNumber, 'otp': otp};

  factory LoginRequest.fromJson(Map<String, dynamic> json) => LoginRequest(
    mobileNumber: json['mobileNumber'] as String,
    otp: json['otp'] as String,
  );
}
