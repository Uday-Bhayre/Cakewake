import 'package:cakewake_vendor/features/home/model/order_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:cakewake_vendor/features/home/controller/home_controller.dart';

class OrderCard extends StatelessWidget {
  final HomeController controller;
  final OrderModel order;
  const OrderCard({super.key, required this.controller, required this.order});

  @override
  Widget build(BuildContext context) {
    return PhysicalModel(
      color: Theme.of(context).colorScheme.surface.withAlpha(0xFFF7F7FA),
      elevation: 2,
      borderRadius: BorderRadius.circular(16.r),
      clipBehavior: Clip.antiAlias,
      child: Container(
        width: double.infinity,
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
            // Header: Order ID, Amount, Paid
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '#${order.id ?? ''}',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18.sp,
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                    ),
                    SizedBox(height: 2.h),
                    Text(
                      order.date ?? '',
                      style: TextStyle(
                        fontSize: 13.sp,
                        color: Theme.of(
                          context,
                        ).colorScheme.onSurface.withOpacity(0.5),
                      ),
                    ),
                  ],
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      '₹${order.amount.toStringAsFixed(2) ?? '--'}',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20.sp,
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                    ),
                    SizedBox(width: 4.w),
                    Text(
                      'Paid',
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 15.sp,
                        color: Colors.green,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 20.h),
            // Product image, name, weight, qty
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(12.r),
                  child:
                      order.productImageUrl != null &&
                          order.productImageUrl!.isNotEmpty
                      ? Image.network(
                          order.productImageUrl!,
                          width: 70.w,
                          height: 70.w,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) =>
                              Container(
                                width: 70.w,
                                height: 70.w,
                                color: Colors.grey[200],
                                child: Icon(
                                  Icons.image,
                                  size: 32,
                                  color: Colors.grey,
                                ),
                              ),
                        )
                      : Container(
                          width: 70.w,
                          height: 70.w,
                          color: Colors.grey[200],
                          child: Icon(
                            Icons.cake,
                            size: 36.sp,
                            color: Colors.grey[400],
                          ),
                        ),
                ),
                SizedBox(width: 16.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        order.productName ?? '-',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 20.sp,
                          color: Theme.of(context).colorScheme.onSurface,
                        ),
                      ),
                      SizedBox(height: 4.h),
                      Row(
                        children: [
                          Text(
                            '${order.weight ?? '-'} gm',
                            style: TextStyle(
                              fontSize: 14.sp,
                              color: Theme.of(
                                context,
                              ).colorScheme.onSurface.withOpacity(0.5),
                            ),
                          ),
                          SizedBox(width: 12.w),
                          Text(
                            'Qty: ${order.quantity ?? '-'}',
                            style: TextStyle(
                              fontSize: 14.sp,
                              color: Theme.of(
                                context,
                              ).colorScheme.onSurface.withOpacity(0.5),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 16.h),
            // Customer Name & Pincode
            // Customer Name & Pincode (titles and values in two rows)
            Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        'Customer Name',
                        style: TextStyle(fontSize: 14.sp, color: Colors.grey),
                      ),
                    ),
                    SizedBox(width: 70.w),
                    Expanded(
                      child: Text(
                        'Pincode',
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: Theme.of(
                            context,
                          ).colorScheme.onSurface.withOpacity(0.5),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 4.h),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        order.customerName ?? '-',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 17.sp,
                          color: Theme.of(context).colorScheme.onSurface,
                        ),
                      ),
                    ),
                    Container(
                      width: 1,
                      height: 30.h,
                      color: Colors.grey,
                      margin: EdgeInsets.fromLTRB(40, 0, 20, 0),
                    ),
                    Expanded(
                      child: Text(
                        order.pincode ?? '-',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 17.sp,
                          color: Theme.of(context).colorScheme.onSurface,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),

            SizedBox(height: 20.h),
            // Accept Order Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: controller.onOrderAction,
                style: ElevatedButton.styleFrom(
                  backgroundColor: controller.getOrderButtonColor(
                    order.status,
                    context,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16.r),
                  ),
                  padding: EdgeInsets.symmetric(vertical: 16.h),
                  elevation: 0,
                ),
                child: Text(
                  order.status,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 18.sp,
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
