import 'package:cakewake_vendor/core/widgets/availability_switch.dart';
import 'package:cakewake_vendor/core/widgets/help_button.dart';
import 'package:cakewake_vendor/features/orders/model/order_history_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../controller/orders_controller.dart';
import '../widgets/order_history_card.dart';

class OrdersView extends StatefulWidget {
  const OrdersView({super.key});

  @override
  State<OrdersView> createState() => _OrdersViewState();
}

class _OrdersViewState extends State<OrdersView> {
  late OrdersController controller;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    controller = Get.find<OrdersController>();
    _scrollController.addListener(_onScroll);
    // Only load when this page is first shown
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.fetchOrderHistory();
    });
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 100) {
      controller.loadMore();
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      backgroundColor: colorScheme.surface,
      appBar: AppBar(
        backgroundColor: colorScheme.primary,
        title: Text(
          'Order history',
          style: TextStyle(
            color: colorScheme.onPrimary,
            fontSize: 22.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Container(
                    height: 44.h,
                    decoration: BoxDecoration(
                      color: colorScheme.surface,
                      borderRadius: BorderRadius.circular(12.r),
                      border: Border.all(
                        color: colorScheme.outline.withOpacity(0.5),
                      ),
                    ),
                    child: Row(
                      children: [
                        SizedBox(width: 12.w),
                        Icon(
                          Icons.search,
                          color: colorScheme.onSecondary,
                          size: 26.sp,
                        ),
                        SizedBox(width: 8.w),
                        Expanded(
                          child: TextField(
                            onChanged: controller.updateSearch,
                            decoration: InputDecoration(
                              hintText: 'Search in orders',
                              hintStyle: TextStyle(
                                color: colorScheme.onSecondary,
                                fontSize: 15.sp,
                              ),
                              border: InputBorder.none,
                              isDense: true,
                              contentPadding: EdgeInsets.zero,
                            ),
                            style: TextStyle(fontSize: 18.sp),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(width: 10.w),
                GestureDetector(
                  onTap: () {},
                  child: Container(
                    height: 44.h,
                    padding: EdgeInsets.symmetric(horizontal: 18.w),
                    decoration: BoxDecoration(
                      color: colorScheme.surface,
                      borderRadius: BorderRadius.circular(12.r),
                      border: Border.all(
                        color: colorScheme.outline.withOpacity(0.5),
                      ),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.filter_list_alt,
                          color: colorScheme.onSecondary,
                          size: 22.sp,
                        ),
                        SizedBox(width: 6.w),
                        Text(
                          'Filter',
                          style: TextStyle(
                            color: colorScheme.onSecondary,
                            fontSize: 15.sp,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 16.h),
            Expanded(
              child: Obx(
                () => RefreshIndicator(
                  onRefresh: () async {
                    await controller.fetchOrderHistory();
                  },
                  child: controller.orders.isEmpty && controller.isLoading.value
                      ? Center(child: CircularProgressIndicator())
                      : ListView.builder(
                          controller: _scrollController,
                          itemCount:
                              controller.filteredOrders.length +
                              (controller.hasMore ? 1 : 0),
                          itemBuilder: (context, index) {
                            if (index == controller.filteredOrders.length) {
                              return Padding(
                                padding: EdgeInsets.symmetric(vertical: 16.h),
                                child: Center(
                                  child: CircularProgressIndicator(),
                                ),
                              );
                            }
                            final order = controller.filteredOrders[index];
                            return OrderHistoryCard(
                              order: order,
                              onViewDetails: () {},
                              onDownloadInvoice: () {},
                              onReportIssue: () {},
                            );
                          },
                        ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
