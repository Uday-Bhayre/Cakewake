class OrderHistoryResponse {
  final List<OrderHistoryItem> orders;
  final int count;
  final int totalOrders;
  final Pagination pagination;

  OrderHistoryResponse({
    required this.orders,
    required this.count,
    required this.totalOrders,
    required this.pagination,
  });

  factory OrderHistoryResponse.fromJson(Map<String, dynamic> json) {
    return OrderHistoryResponse(
      orders: (json['orders'] as List<dynamic>? ?? [])
          .map((e) => OrderHistoryItem.fromJson(e))
          .toList(),
      count: json['count'] ?? 0,
      totalOrders: json['totalOrders'] ?? 0,
      pagination: Pagination.fromJson(json['pagination'] ?? {}),
    );
  }
}

class Pagination {
  final int currentPage;
  final int totalPages;
  final int limit;
  final bool hasNextPage;
  final bool hasPrevPage;
  final int? nextPage;
  final int? prevPage;

  Pagination({
    required this.currentPage,
    required this.totalPages,
    required this.limit,
    required this.hasNextPage,
    required this.hasPrevPage,
    this.nextPage,
    this.prevPage,
  });

  factory Pagination.fromJson(Map<String, dynamic> json) {
    return Pagination(
      currentPage: json['currentPage'] ?? 1,
      totalPages: json['totalPages'] ?? 1,
      limit: json['limit'] ?? 10,
      hasNextPage: json['hasNextPage'] ?? false,
      hasPrevPage: json['hasPrevPage'] ?? false,
      nextPage: json['nextPage'],
      prevPage: json['prevPage'],
    );
  }
}

class OrderHistoryItem {
  final String id;
  final String cakeName;
  final double amount;
  final int quantity;
  final String cakeWeight;
  final String customerName;
  final String pincode;
  final String status;
  final String orderDate;
  final String orderTime;

  OrderHistoryItem({
    required this.id,
    required this.cakeName,
    required this.amount,
    required this.quantity,
    required this.cakeWeight,
    required this.customerName,
    required this.pincode,
    required this.status,
    required this.orderDate,
    required this.orderTime,
  });

  factory OrderHistoryItem.fromJson(Map<String, dynamic> json) {
    return OrderHistoryItem(
      id: json['_id'] ?? '',
      cakeName: json['cakeName'] ?? '',
      amount: (json['amount'] is int)
          ? (json['amount'] as int).toDouble()
          : (json['amount'] ?? 0.0),
      quantity: json['quantity'] ?? 0,
      cakeWeight: json['cakeWeight'] ?? '',
      customerName: json['customerName'] ?? '',
      pincode: json['pincode']?.toString() ?? '',
      status: json['status'] ?? '',
      orderDate: json['orderDate'] ?? '',
      orderTime: json['orderTime'] ?? '',
    );
  }
}
