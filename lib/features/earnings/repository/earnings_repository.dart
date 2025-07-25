import 'package:cakewake_vendor/core/services/api_service.dart';

import '../model/earning_history_response.dart';
import '../model/earning_history_req_model.dart';
import '../model/earning_stat_req_model.dart';
import '../model/earning_stat_res_model.dart';

// Placeholder for EarningsRepository. Implement data fetching here if needed.
class EarningsRepository {
  final ApiService _apiService;
  EarningsRepository({ApiService? apiService})
    : _apiService = apiService ?? ApiService();

  Future<EarningHistoryResponse> fetchEarningHistory(
    EarningHistoryRequest req,
  ) async {
    final response = await _apiService.get(
      '/earning/history',
      params: req.toJson(),
    );
    return EarningHistoryResponse.fromJson(response.data);
  }

  Future<EarningStatResponse> fetchEarningStats(EarningStatRequest req) async {
    final response = await _apiService.get(
      '/earning/all-stats',
      params: req.toJson(),
    );
    return EarningStatResponse.fromJson(response.data);
  }
}
