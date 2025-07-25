class LoginResponse {
  final bool success;
  final String? token;
  final bool? hasProfile;
  final String? message;
  final Map<String, dynamic>? user;

  LoginResponse({required this.success, this.token, this.message, this.user, this.hasProfile});

  factory LoginResponse.fromJson(Map<String, dynamic> json) => LoginResponse(
    success: json['success'] as bool,
    token: json['token'] as String?,
    message: json['message'] as String?,
    user: json['vendor'] as Map<String, dynamic>?,
    // hasProfile: json['has_profile'] as bool?,
    hasProfile: true,
  );
}
