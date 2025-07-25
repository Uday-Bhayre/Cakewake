import 'dart:async';
import 'package:get/get.dart';
import '../model/order_history_model.dart';
import '../repository/orders_repository.dart';
import '../model/order_history_req_model.dart';
import '../model/order_history_res_model.dart';

class OrdersController extends GetxController {
  final OrdersRepository repository;
  OrdersController(this.repository);

  RxList<OrderHistoryModel> orders = <OrderHistoryModel>[].obs;
  RxString searchQuery = ''.obs;

  int _currentPage = 1;
  final int _pageSize = 10;
  final RxBool isLoading = false.obs;
  bool hasMore = true;

  @override
  void onInit() {
    super.onInit();
    if (orders.isEmpty) {
      fetchOrderHistory();
    }
  }

  Future<void> fetchOrderHistory() async {
    if (isLoading.value) return;
    isLoading.value = true;

    try {
      final req = OrderHistoryRequest(page: _currentPage, pageSize: 10);
      OrderHistoryResponse res;
      if (_currentPage == 1 && orders.isNotEmpty) {
        isLoading.value = false;
        return;
      }
      if (_currentPage == 1) {
        res = await repository.fetchOrderHistoryFirstPage();
      } else {
        res = await repository.fetchOrderHistory(req);
      }
      final newOrders = res.orders
          .map(
            (item) => OrderHistoryModel(
              title: item.cakeName,
              date: DateTime.tryParse(item.orderDate) ?? DateTime.now(),
              status: item.status,
              pincode: item.pincode,
              earning: item.amount,
            ),
          )
          .toList();

      // Use backend pagination info for hasMore and next page
      hasMore = res.pagination.hasNextPage;
      if (_currentPage == 1) {
        orders.value = newOrders;
      } else {
        orders.addAll(newOrders);
      }
      if (hasMore && res.pagination.nextPage != null) {
        _currentPage = res.pagination.nextPage!;
      }
    } catch (e) {
      // Handle error
      Get.snackbar(
        'Error',
        'Failed to load order history: $e',
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoading.value = false;
    }
  }

  void loadMore() {
    if (hasMore && !isLoading.value) {
      fetchOrderHistory();
    }
  }

  List<OrderHistoryModel> get filteredOrders {
    final query = searchQuery.value.trim().toLowerCase();
    if (query.isEmpty) return orders;
    return orders.where((order) {
      return order.title.toLowerCase().contains(query) ||
          order.pincode.toLowerCase().contains(query);
    }).toList();
  }

  void updateSearch(String query) {
    searchQuery.value = query;
  }
}
