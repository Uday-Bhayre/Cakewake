class PaymentSetupModel {
  String upiId;
  String accountName;
  String accountNumber;
  String ifscCode;

  PaymentSetupModel({
    required this.upiId,
    required this.accountName,
    required this.accountNumber,
    required this.ifscCode,
  });
}
