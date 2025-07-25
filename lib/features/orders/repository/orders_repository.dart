import 'package:cakewake_vendor/core/services/api_service.dart';

import '../model/order_history_req_model.dart';
import '../model/order_history_res_model.dart';

class OrdersRepository {
  final ApiService _apiService;
  OrdersRepository({ApiService? apiService})
    : _apiService = apiService ?? ApiService();

  Future<OrderHistoryResponse> fetchOrderHistory(
    OrderHistoryRequest req,
  ) async {
    // For follow-up pages: /order/history?page=page&limit=10
    final response = await _apiService.get(
      '/order/history',
      params: {'page': req.page, 'limit': req.pageSize},
    );
    return OrderHistoryResponse.fromJson(response.data);
  }

  Future<OrderHistoryResponse> fetchOrderHistoryFirstPage() async {
    final response = await _apiService.get('/order/history');
    return OrderHistoryResponse.fromJson(response.data);
  }
}
