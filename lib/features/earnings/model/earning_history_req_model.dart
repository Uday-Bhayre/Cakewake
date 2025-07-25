class EarningHistoryRequest {
  final int page;
  final int pageSize;

  EarningHistoryRequest({this.page = 1, this.pageSize = 20});

  Map<String, dynamic> toJson() => {'page': page, 'pageSize': pageSize};
}
