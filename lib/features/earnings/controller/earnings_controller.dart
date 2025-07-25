import 'package:cakewake_vendor/features/earnings/model/earning_history_req_model.dart';
import 'package:get/get.dart';
import '../model/earning_model.dart';
import '../repository/earnings_repository.dart';
import '../model/earning_stat_req_model.dart';
import '../model/earning_stat_res_model.dart';
import '../model/earning_history_response.dart';

class EarningsController extends GetxController {
  Rx<EarningModel> earning = EarningModel(
    walletBalance: 0.0,
    todayEarning: 0.0,
    weekEarning: 0.0,
    deliveries: 0,
  ).obs;

  RxBool isOnline = true.obs;

  final EarningsRepository repository = EarningsRepository();
  // Earning stats
  Rxn<EarningStatResponse> statResponse = Rxn<EarningStatResponse>();
  RxBool isStatLoading = false.obs;
  RxList<EarningHistoryItem> earningHistory = <EarningHistoryItem>[].obs;
  int _currentPage = 1;
  final int _pageSize = 10;
  final RxBool isLoading = false.obs;
  bool hasMore = true;
  Pagination? pagination;

  @override
  void onInit() {
    super.onInit();
    fetchEarningHistory(reset: true);
    fetchStats();
  }

  Future<void> fetchStats() async {
    isStatLoading.value = true;
    try {
      final req = EarningStatRequest();
      final res = await repository.fetchEarningStats(req);
      statResponse.value = res;
    } catch (e) {
      // Handle error
    } finally {
      isStatLoading.value = false;
    }
  }

  Future<void> fetchEarningHistory({bool reset = false}) async {
    if (isLoading.value) return;
    isLoading.value = true;
    if (reset) {
      _currentPage = 1;
      hasMore = true;
      earningHistory.clear();
    }
    try {
      final req = EarningHistoryRequest(
        page: _currentPage,
        pageSize: _pageSize,
      );
      final res = await repository.fetchEarningHistory(req);
      final newItems = res.earningHistory;
      pagination = res.pagination;
      if (reset) {
        earningHistory.value = newItems;
      } else {
        earningHistory.addAll(newItems);
      }
      hasMore = pagination?.hasNextPage ?? false;
      if (hasMore && pagination?.nextPage != null) {
        _currentPage = pagination!.nextPage!;
      }
      // Optionally update earning summary if your API provides it
      // earning.value = ...
    } catch (e) {
      // Handle error
    } finally {
      isLoading.value = false;
    }
  }

  void loadMore() {
    if (hasMore && !isLoading.value) {
      fetchEarningHistory();
    }
  }

  void setSampleData() {
    earning.value = EarningModel(
      walletBalance: 1565.0,
      todayEarning: 250.0,
      weekEarning: 250.0,
      deliveries: 65,
    );
  }

  void setEmptyData() {
    earning.value = EarningModel(
      walletBalance: 0.0,
      todayEarning: 0.0,
      weekEarning: 0.0,
      deliveries: 0,
    );
  }

  void toggleOnline(bool value) {
    isOnline.value = value;
  }
}
