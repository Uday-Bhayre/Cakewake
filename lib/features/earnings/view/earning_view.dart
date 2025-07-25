import 'package:cakewake_vendor/core/widgets/availability_switch.dart';
import 'package:cakewake_vendor/core/widgets/help_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../controller/earnings_controller.dart';
import '../widgets/earning_stat_card.dart';
import '../widgets/earning_history_list.dart';

class EarningView extends GetView<EarningsController> {
  const EarningView({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      backgroundColor: colorScheme.surface,
      appBar: AppBar(
        backgroundColor: colorScheme.primary,
        title: Text(
          'Earning',
          style: TextStyle(
            color: colorScheme.onPrimary,
            fontSize: 22.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          HelpButton(),
          SizedBox(width: 20.w),
        ],
      ),
      body: Obx(() {
        final earning = controller.earning.value;
        return Column(
          children: [
            Container(
              width: double.infinity,
              padding: EdgeInsets.only(top: 24.h, bottom: 24.h),
              decoration: BoxDecoration(
                color: colorScheme.primary,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(32.r),
                  bottomRight: Radius.circular(32.r),
                ),
              ),
              child: Column(
                children: [
                  Text(
                    'Total wallet Balance',
                    style: TextStyle(
                      color: colorScheme.onPrimary,
                      fontSize: 18.sp,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    '₹${earning.walletBalance.toStringAsFixed(2)}',
                    style: TextStyle(
                      color: colorScheme.onPrimary,
                      fontSize: 36.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 12.h),
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: colorScheme.surface,
                      foregroundColor: colorScheme.onSurface,
                      elevation: 2,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24.r),
                      ),
                      padding: EdgeInsets.symmetric(
                        horizontal: 32.w,
                        vertical: 8.h,
                      ),
                    ),
                    child: Text('Withdraw', style: TextStyle(fontSize: 15.sp)),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Obx(() {
                final stat = controller.statResponse.value?.data;
                if (controller.isStatLoading.value) {
                  return Center(child: CircularProgressIndicator());
                }
                if (stat == null) {
                  return SizedBox.shrink();
                }
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    EarningStatCard(
                      title: 'Today',
                      value: '₹${stat.today.earning.toStringAsFixed(2)}',
                    ),
                    EarningStatCard(
                      title: 'This Week',
                      value: '₹${stat.weekly.earning.toStringAsFixed(2)}',
                    ),
                    EarningStatCard(
                      title: 'Deliveries',
                      value: stat.total.deliveries.toString()  ,
                    ),
                  ],
                );
              }),
            ),
            SizedBox(height: 24.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Earning History',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20.sp,
                  ),
                ),
              ),
            ),
            SizedBox(height: 10.h),
            Expanded(child: EarningHistoryList()),
          ],
        );
      }),
    );
  }
}
