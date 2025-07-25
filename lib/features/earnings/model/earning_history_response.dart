class EarningHistoryResponse {
  final bool success;
  final int count;
  final int totalEarnings;
  final Pagination pagination;
  final List<EarningHistoryItem> earningHistory;

  EarningHistoryResponse({
    required this.success,
    required this.count,
    required this.totalEarnings,
    required this.pagination,
    required this.earningHistory,
  });

  factory EarningHistoryResponse.fromJson(Map<String, dynamic> json) {
    return EarningHistoryResponse(
      success: json['success'] ?? false,
      count: json['count'] ?? 0,
      totalEarnings: json['totalEarnings'] ?? 0,
      pagination: Pagination.fromJson(json['pagination'] ?? {}),
      earningHistory: (json['earningHistory'] as List<dynamic>? ?? [])
          .map((e) => EarningHistoryItem.fromJson(e))
          .toList(),
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

class EarningHistoryItem {
  final double price;
  final String date;
  final String cakeName;

  EarningHistoryItem({
    required this.price,
    required this.date,
    required this.cakeName,
  });

  factory EarningHistoryItem.fromJson(Map<String, dynamic> json) {
    return EarningHistoryItem(
      price: (json['price'] is int)
          ? (json['price'] as int).toDouble()
          : (json['price'] ?? 0.0),
      date: json['date'] ?? '',
      cakeName: json['cakeName'] ?? '',
    );
  }
}
