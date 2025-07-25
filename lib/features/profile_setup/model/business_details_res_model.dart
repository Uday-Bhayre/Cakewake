class BusinessDetailsResponse {
  final bool success;
  final String message;
  final String error;

  BusinessDetailsResponse({required this.success, required this.message, required this.error});

  factory BusinessDetailsResponse.fromJson(Map<String, dynamic> json) {
    return BusinessDetailsResponse(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      error: json['error'] ?? '',
    );
  }
}
