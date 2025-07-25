class OrderHistoryModel {
  final String title;
  final DateTime date;
  final String status;
  final String pincode;
  final double earning;

  OrderHistoryModel({
    required this.title,
    required this.date,
    required this.status,
    required this.pincode,
    required this.earning,
  });
}
