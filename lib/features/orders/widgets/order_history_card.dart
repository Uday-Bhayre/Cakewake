import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../model/order_history_model.dart';

class OrderHistoryCard extends StatelessWidget {
  final OrderHistoryModel order;
  final VoidCallback? onViewDetails;
  final VoidCallback? onDownloadInvoice;
  final VoidCallback? onReportIssue;

  const OrderHistoryCard({
    super.key,
    required this.order,
    this.onViewDetails,
    this.onDownloadInvoice,
    this.onReportIssue,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8.h, horizontal: 0.w),
      padding: EdgeInsets.all(16.w),
       decoration: BoxDecoration(
          border: Border.all(
            color: Theme.of(context).colorScheme.outline.withOpacity(0.08),
          ),
          color: Theme.of(context).colorScheme.surface.withAlpha(0xFFF7F7FA),
          borderRadius: BorderRadius.circular(16.r),
        ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Product Name
          Text(
            order.title,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20.sp,
              color: colorScheme.onSurface,
            ),
          ),
          SizedBox(height: 4.h),
          // PinCode
          Text(
            'PinCode: ${order.pincode}',
            style: TextStyle(
              fontSize: 16.sp,
              color: colorScheme.onSurface.withOpacity(0.7),
            ),
          ),
          SizedBox(height: 12.h),
          // Status and Amount Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                children: [
                  Text(
                    order.status,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 18.sp,
                      color: colorScheme.onSurface,
                    ),
                  ),
                  SizedBox(width: 6.w),
                  Icon(Icons.check_circle, color: Colors.green, size: 18),
                ],
              ),
              Text(
                '₹${order.earning.toStringAsFixed(2)}',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20.sp,
                  color: colorScheme.onSurface,
                ),
              ),
            ],
          ),
          SizedBox(height: 2.h),
          // Delivery date/time
          Text(
            'Delivered on ${_formatDate(order.date)} ${_formatTime(order.date)}',
            style: TextStyle(
              fontSize: 15.sp,
              color: colorScheme.onSurface.withOpacity(0.6),
            ),
          ),
          SizedBox(height: 18.h),
          // Buttons Row
          Divider(color: colorScheme.onSecondary.withOpacity(0.5)),
          Row(
            children: [
              Expanded(
                child: InkWell(
                  onTap: onReportIssue,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(12.r),
                  ),
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 12.h),
                    alignment: Alignment.center,
                    child: Text(
                      'Report Issue',
                      style: TextStyle(
                        color: colorScheme.onSurface,
                        fontWeight: FontWeight.w600,
                        fontSize: 18.sp,
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                width: 1,
                height: 40.h,
                color: colorScheme.outline.withOpacity(0.15),
              ),
              Expanded(
                child: InkWell(
                  onTap: onViewDetails,
                  borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(12.r),
                  ),
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 12.h),
                    alignment: Alignment.center,
                    child: Text(
                      'View details',
                      style: TextStyle(
                        color: colorScheme.primary,
                        fontWeight: FontWeight.w600,
                        fontSize: 18.sp,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day.toString().padLeft(2, '0')} ${_monthName(date.month)}, ${date.year}';
  }

  String _formatTime(DateTime date) {
    final hour = date.hour % 12 == 0 ? 12 : date.hour % 12;
    final ampm = date.hour >= 12 ? 'PM' : 'AM';
    final minute = date.minute.toString().padLeft(2, '0');
    return '$hour:$minute $ampm';
  }

  String _monthName(int month) {
    const months = [
      '',
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];
    return months[month];
  }
}
