import 'package:cakewake_vendor/core/widgets/custom_button.dart';
import 'package:cakewake_vendor/features/authentication/controller/login_controller.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

import 'package:intl_phone_field/intl_phone_field.dart';

class MobileAuth extends GetView<LoginController> {
  const MobileAuth({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        elevation: 0,
        automaticallyImplyLeading: false,
      ),
      body: Column(
        children: [
          Expanded(
            child: Stack(
              alignment: Alignment.center,
              children: [
                Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    width: 390.w,
                    height: 211.h,
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    child: Column(
                      children: [
                        SvgPicture.asset(
                          'assets/images/onboarding/cup2.svg',
                          width: 33.w,
                          height: 33.h,
                          semanticsLabel: 'CakeWake Logo',
                        ),
                        SizedBox(height: 1.h),
                        Text(
                          'CakeWake',
                          style: TextStyle(
                            fontFamily: 'Pacifico',
                            fontWeight: FontWeight.w400,
                            fontSize: 22.sp,
                            fontStyle: FontStyle.italic,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(height: 2.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Transform.rotate(
                              angle: math.pi / 7,
                              child: Image.asset(
                                'assets/images/authentication/cakeImg1.png',
                                width: 110.w,
                                height: 125.h,
                              ),
                            ),
                            Image.asset(
                              'assets/images/authentication/cakeImg2.png',
                              width: 90.w,
                              height: 113.h,
                            ),
                            Transform.rotate(
                              angle: -math.pi / 7,
                              child: Image.asset(
                                'assets/images/authentication/cakeImg3.png',
                                width: 90.w,
                                height: 127.h,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  top: 150.h, // adjust as needed for overlap
                  left: 0,
                  right: 0,
                  child: Container(
                    height: 600.h,
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.surface,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(35.r),
                        topRight: Radius.circular(35.r),
                      ),
                    ),
                    child: SingleChildScrollView(
                      child: Form(
                        key: controller.formKey,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 14),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: 30.h),
                              Text(
                                'Enter your Phone Number',
                                style: TextStyle(
                                  fontSize: 22.sp,
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w700,
                                  color: Theme.of(
                                    context,
                                  ).colorScheme.onSurface,
                                ),
                              ),
                              SizedBox(height: 26.h),
                              SizedBox(
                                width: 356.w,
                                height: 79.h,
                                child: IntlPhoneField(
                                  cursorWidth: 1.w,
                                  validator: (phone) {
                                    if (phone == null || phone.number.isEmpty) {
                                      return 'Please enter your Phone Number';
                                    }
                                    if (phone.number.length < 8) {
                                      return 'Enter a valid Phone Number';
                                    }
                                    return null;
                                  },
                                  initialCountryCode: 'IN',
                                  decoration: InputDecoration(
                                    labelText: 'Phone Number',
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(13.r),
                                      borderSide: BorderSide(
                                        color: Theme.of(
                                          context,
                                        ).colorScheme.primary,
                                        width: 1.w,
                                      ),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(13.r),
                                      borderSide: BorderSide(
                                        color: Theme.of(
                                          context,
                                        ).colorScheme.primary,
                                        width: 1.w,
                                      ),
                                    ),
                                    errorBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(13.r),
                                      borderSide: BorderSide(
                                        color: Colors.red,
                                        width: 1.w,
                                      ),
                                    ),
                                    focusedErrorBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(13.r),
                                      borderSide: BorderSide(
                                        color: Colors.red,
                                        width: 1.w,
                                      ),
                                    ),
                                  ),
                                  onChanged: (phone) {
                                    controller.mobileNumber.value =
                                        phone.completeNumber;
                                  },
                                ),
                              ),
                              SizedBox(height: 90.h),
                              CustomButton(
                                text: 'Get OTP',
                                onPressed: controller.sendOtp,
                              ),
                              SizedBox(height: 10.h),
                              Text.rich(
                                TextSpan(
                                  text: 'By clicking in, I accept the ',
                                  style: TextStyle(
                                    fontSize: 14.sp,
                                    fontFamily: 'Inter',
                                    fontWeight: FontWeight.w400,
                                    color: Theme.of(
                                      context,
                                    ).colorScheme.onSecondary,
                                  ),
                                  children: [
                                    TextSpan(
                                      text: 'terms of services',
                                      style: TextStyle(
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.bold,
                                        decoration: TextDecoration.underline,
                                        color: Theme.of(
                                          context,
                                        ).colorScheme.onSurface,
                                      ),
                                    ),
                                    TextSpan(text: ' & '),
                                    TextSpan(
                                      text: 'privacy policy',
                                      style: TextStyle(
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.bold,
                                        decoration: TextDecoration.underline,
                                        color: Theme.of(
                                          context,
                                        ).colorScheme.onSurface,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
