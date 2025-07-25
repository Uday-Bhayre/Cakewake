class PaymentSetupRequest {
  final String ?upiId;
  final String ?accountName;
  final String ?accountNumber;
  final String ?ifscCode;

  PaymentSetupRequest({
    this.upiId,
    this.accountName,
    this.accountNumber,
    this.ifscCode,
  });

  Map<String, dynamic> toJson() {
    return {
      'upi': upiId,
      'bankInfo': {
        'accountHolderName': accountName,
        'accountNumber': accountNumber,
        'ifscCode': ifscCode,
      },
    };
  }
}
