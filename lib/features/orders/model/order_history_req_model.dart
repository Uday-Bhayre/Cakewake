class OrderHistoryRequest {
  final int page;
  final int pageSize;

  OrderHistoryRequest({this.page = 1, this.pageSize = 20});

  Map<String, dynamic> toJson() => {'page': page, 'pageSize': pageSize};
}
