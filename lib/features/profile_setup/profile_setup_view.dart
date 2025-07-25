import 'package:cakewake_vendor/core/widgets/custom_button.dart';
import 'package:cakewake_vendor/core/widgets/help_button.dart';
import 'package:cakewake_vendor/core/widgets/prfile_setup_step_card.dart';
import 'package:cakewake_vendor/features/profile_setup/controller/profile_setup_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ProfileSetupView extends GetView<ProfileSetupController> {
  const ProfileSetupView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Theme.of(context).colorScheme.surface,

      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Container(
                  height: 290.h,
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primary,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(20.r),
                      bottomRight: Radius.circular(20.r),
                    ),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: Column(
                    children: [
                      SizedBox(height: 44.h),
                      Row(
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
                          const Spacer(),
                          HelpButton(),
                          SizedBox(width: 20.w),
                          GestureDetector(
                            onTap: () {},
                            child: SvgPicture.asset(
                              'assets/images/profile_setup/language_icon.svg',
                              width: 28.w,
                              height: 28.h,
                            ),
                          ),
                          SizedBox(width: 15.w),
                          GestureDetector(
                            child: const Icon(
                              Icons.more_vert,
                              color: Colors.white,
                            ),
                            onTap: () {
                              // Add your action here
                            },
                          ),
                        ],
                      ),
                      SizedBox(height: 10.h),

                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  'Welcome to',
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                    fontSize: 26.sp,
                                    fontWeight: FontWeight.w600,
                                    color: Theme.of(
                                      context,
                                    ).colorScheme.onPrimary,
                                  ),
                                ),
                                Text(
                                  'CakeWake Vendor!',
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                    fontSize: 26.sp,
                                    fontWeight: FontWeight.w600,
                                    color: Theme.of(
                                      context,
                                    ).colorScheme.onPrimary,
                                  ),
                                ),
                                SizedBox(height: 10.h),
                                Text(
                                  'Start selling & grow',
                                  style: TextStyle(
                                    fontSize: 18.sp,
                                    fontWeight: FontWeight.w500,
                                    color: Color(0xFFD8D6F5),
                                  ),
                                ),
                                Text(
                                  'business in 10 min',
                                  style: TextStyle(
                                    fontSize: 18.sp,
                                    fontWeight: FontWeight.w500,
                                    color: Color(0xFFD8D6F5),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Positioned(
                  right: 0,
                  bottom: 0,
                  child: SvgPicture.asset(
                    'assets/images/profile_setup/boy.svg',
                    width: 158.h,
                    fit: BoxFit.contain,
                  ),
                ),
              ],
            ),
            SizedBox(height: 30.h),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'COMPLETE IN 3 STEPS',
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w600,
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
                  ),
                  SizedBox(height: 16.h),
                  StepCard(
                    step: "1",
                    title: "Business Details",
                    subtitle: "Name & GST Number",
                    isActive: true,
                    completed: controller.step1Completed.value,
                    onTap: () => Get.toNamed('/profile/name_email'),
                  ),
                  SizedBox(height: 12.h),
                  StepCard(
                    step: "2",
                    title: "Delivery Setup",
                    subtitle: "Location & Delivery",
                    isActive: true,
                    // isActive:
                    //     controller.step1Completed.value &&
                    //     !controller.step2Completed.value,
                    completed: controller.step2Completed.value,
                    onTap: () => Get.toNamed('/profile/location_auto_detected'),
                  ),
                  SizedBox(height: 12.h),
                  StepCard(
                    step: "3",
                    title: "Payments Info",
                    subtitle: "Bank & UPI",
                    isActive: true,
                    completed: controller.step3Completed.value,
                    onTap: () => Get.toNamed('/profile/payment_details'),
                  ),
                  SizedBox(height: 100.h),
                  CustomButton(
                    text: "Continue",
                    enabled: controller.allStepsCompleted,
                    onPressed: controller.allStepsCompleted
                        ? () {
                            Get.offAllNamed('/navigation');
                            Get.delete<ProfileSetupController>();
                          }
                        : () {},
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
