class OrderModel {
  OrderModel copyWith({
    String? id,
    String? pincode,
    String? date,
    String? customerName,
    String? productName,
    String? weight,
    int? quantity,
    String? productImageUrl,
    String? status,
    double? amount,
  }) {
    return OrderModel(
      id: id ?? this.id,
      pincode: pincode ?? this.pincode,
      date: date ?? this.date,
      customerName: customerName ?? this.customerName,
      productName: productName ?? this.productName,
      weight: weight ?? this.weight,
      quantity: quantity ?? this.quantity,
      status: status ?? this.status,
      amount: amount ?? this.amount,
      productImageUrl: productImageUrl ?? this.productImageUrl,
    );
  }

  final String id;
  final String pincode;
  final String date;
  final String customerName;
  final String productName;
  final String weight;
  final int quantity;
  final String? productImageUrl;
  final String status;
  final double amount;

  OrderModel({
    required this.id,
    required this.pincode,
    required this.date,
    required this.customerName,
    required this.productName,
    required this.weight,
    required this.quantity,
    required this.status,
    required this.amount,
    this.productImageUrl,
  });
}
