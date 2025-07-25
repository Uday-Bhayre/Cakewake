import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../controller/earnings_controller.dart';

class EarningHistoryList extends StatelessWidget {
  const EarningHistoryList({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<EarningsController>();
    final colorScheme = Theme.of(context).colorScheme;
    final ScrollController scrollController = ScrollController();

    void onScroll() {
      if (scrollController.position.pixels >=
          scrollController.position.maxScrollExtent - 100) {
        controller.loadMore();
      }
    }

    scrollController.addListener(onScroll);

    return Obx(() {
      if (controller.isLoading.value && controller.earningHistory.isEmpty) {
        return Center(child: CircularProgressIndicator());
      }
      if (controller.earningHistory.isEmpty) {
        return Center(child: Text('No earning history found.'));
      }
      return ListView.separated(
        controller: scrollController,
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
        itemCount:
            controller.earningHistory.length + (controller.hasMore ? 1 : 0),
        separatorBuilder: (context, index) =>
            Divider(height: 18.h, color: colorScheme.outline.withOpacity(0.08)),
        itemBuilder: (context, index) {
          if (index == controller.earningHistory.length && controller.hasMore) {
            return Padding(
              padding: EdgeInsets.symmetric(vertical: 16.h),
              child: Center(child: CircularProgressIndicator()),
            );
          }
          final item = controller.earningHistory[index];
          // Parse date and time from item.date
          DateTime? parsedDate;
          String dateStr = '';
          String timeStr = '';
          try {
            parsedDate = DateTime.parse(item.date);
            dateStr =
                '${parsedDate.day.toString().padLeft(2, '0')}-${parsedDate.month.toString().padLeft(2, '0')}-${parsedDate.year}';
            timeStr =
                '${parsedDate.hour.toString().padLeft(2, '0')}:${parsedDate.minute.toString().padLeft(2, '0')}';
          } catch (_) {
            dateStr = item.date;
          }
          return Container(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
            decoration: BoxDecoration(
              color: colorScheme.surface,
              borderRadius: BorderRadius.circular(16.r),
              boxShadow: [
                BoxShadow(
                  color: colorScheme.primary.withOpacity(0.04),
                  blurRadius: 8,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        dateStr,
                        style: TextStyle(
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w600,
                          color: colorScheme.onSurface,
                        ),
                      ),
                      SizedBox(height: 2.h),
                      Text(
                        timeStr,
                        style: TextStyle(
                          fontSize: 13.sp,
                          color: colorScheme.onSurface.withOpacity(0.7),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 12.w),
                Text(
                  '+ ₹${item.price.toStringAsFixed(2)}',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16.sp,
                    color: colorScheme.primary,
                  ),
                ),
              ],
            ),
          );
        },
      );
    });
  }
}
