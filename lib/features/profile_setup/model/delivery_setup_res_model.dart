class DeliverySetupResponse {
  final bool success;
  final String message;
  final String error;
  DeliverySetupResponse({required this.success, required this.message, required this.error});

  factory DeliverySetupResponse.fromJson(Map<String, dynamic> json) {
    return DeliverySetupResponse(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      error: json['error'] ?? '',
    );
  }
}
