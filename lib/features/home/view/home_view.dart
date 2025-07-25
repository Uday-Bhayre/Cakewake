import 'package:cakewake_vendor/core/widgets/availability_switch.dart';
import 'package:cakewake_vendor/core/widgets/help_button.dart';
import 'package:cakewake_vendor/core/widgets/notification_icon.dart';
import 'package:cakewake_vendor/features/home/widgets/order_card.dart';
import 'package:cakewake_vendor/features/home/widgets/stat_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:cakewake_vendor/features/home/controller/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      // Example: you can expand this logic for all states
      return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.surface,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(130.h),
          child: Container(
            padding: EdgeInsets.only(top: 40.h, left: 16.w, right: 16.w),
            color: Theme.of(context).colorScheme.primary,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 10.h),
                Row(
                  // mainAxisAlignment: MainAxisAlignment.spaceBetwe,
                  children: [
                    Text(
                      'CakeWake',
                      style: TextStyle(
                        fontFamily: 'Pacifico',
                        fontStyle: FontStyle.italic,
                        fontSize: 24.sp,
                        fontWeight: FontWeight.w400,
                        color: Theme.of(context).colorScheme.onPrimary,
                      ),
                    ),
                    Spacer(),
                    const NotificationIcon(),
                    SizedBox(width: 10.w),
                    HelpButton(),
                    SizedBox(width: 10.w),
                    AvailabilitySwitch(
                      value: controller.isOnline.value,
                      onChanged: (value) {
                        controller.toggleOnline(value);
                      },
                    ),
                  ],
                ),
                SizedBox(height: 30.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Hello, Sweet Bakes',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.circle,
                          color: controller.isOnline.value
                              ? Colors.green
                              : Colors.red,
                          size: 6.sp,
                        ),
                        SizedBox(width: 4.w),
                        Text(
                          controller.isOnline.value ? 'ONLINE' : 'OFFLINE',
                          style: TextStyle(
                            color: controller.isOnline.value
                                ? Colors.green
                                : Colors.red,
                            fontWeight: FontWeight.bold,
                            fontSize: 13.sp,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(16.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    StatCard(
                      title: 'Today Order',
                      value: controller.todayOrder.value.toString(),
                      changeText: '+0% ',
                      change: controller.todayOrderChange.value,
                      iconAsset: 'assets/images/home/order.png',
                    ),
                    SizedBox(width: 10.w),
                    StatCard(
                      title: 'Today Earning',
                      value: " ₹${controller.todayEarning.value.toString()}",
                      changeText: '+0% ',
                      change: controller.todayEarningChange.value,
                      iconAsset: 'assets/images/home/money.png',
                    ),
                  ],
                ),
                SizedBox(height: 24.h),

                Row(
                  children: [
                    Text(
                      'New Order',
                      style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                    ),
                    Spacer(),
                    TextButton(
                      onPressed: () {
                        controller.handleOrderAccepted({
                          'orderId': '68711d6942c53aebd58b0316',
                          'userId': '6870fcce2f3e4695405eb6f2',
                        });
                        // controller.handleDeliveryRequest({
                        //     "orderId": "1234567",
                        //     "workArea": "Bandra",
                        //     "workCity": "Mumbai",
                        //     "customerName": "Priyanshu Gupta",
                        //     "pickupAddress": "ABV-IIITM, Gwalior, Madhya Pradesh",
                        //     "deliveryAddress": "Old housing board,Rewari, Haryana",
                        //     "customerPhone": "+91 9876543210",
                        //     "earning": "₹999",
                        //     "estimatedTime": "23",
                        //     "vendorId": "6866952d98b866e42490e3ae",
                        // });
                        // controller.handleDeliveryRequest({
                        //     "orderId": "dfsdfwdff",
                        //     "workArea": "Bandra",
                        //     "workCity": "Mumbai",
                        //     "customerName": "Anshu Jhatu",
                        //     "pickupAddress": "Sucker Street, Mumbai",
                        //     "deliveryAddress": "Red light, Mumbai",
                        //     "customerPhone": "+91 9876543210",
                        //     "earning": "₹999",
                        //     "estimatedTime": "23",
                        //     "vendorId": "6866952d98b866e42490e3ae",
                        // });
                      },
                      child: Text('See All Orders'),
                    ),
                  ],
                ),

                SizedBox(height: 5.h),

                controller.hasOrder.value && controller.orders.isNotEmpty
                    ? ListView.separated(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: controller.orders.length,
                        separatorBuilder: (context, idx) =>
                            SizedBox(height: 16.h),
                        itemBuilder: (context, idx) => OrderCard(
                          controller: controller,
                          order: controller.orders[idx],
                        ),
                      )
                    : Center(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(height: 32.h),
                            Image.asset(
                              'assets/images/home/empty_box.png',
                              width: 250.w,
                              height: 250.h,
                            ),
                            SizedBox(height: 24.h),
                            Text(
                              'You are online.',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18.sp,
                                color: Theme.of(context).colorScheme.onSurface,
                              ),
                            ),
                            SizedBox(height: 8.h),
                            Text(
                              'Waiting for new orders',
                              style: TextStyle(
                                fontSize: 15.sp,
                                color: Theme.of(
                                  context,
                                ).colorScheme.onSurface.withOpacity(0.6),
                              ),
                            ),
                          ],
                        ),
                      ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
