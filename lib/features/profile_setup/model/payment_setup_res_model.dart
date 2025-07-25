class PaymentSetupResponse {
  final bool success;
  final String message;
  final String error;
  PaymentSetupResponse({required this.success, required this.message, required this.error});

  factory PaymentSetupResponse.fromJson(Map<String, dynamic> json) {
    return PaymentSetupResponse(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      error: json['error'] ?? '',
    );
  }
}
