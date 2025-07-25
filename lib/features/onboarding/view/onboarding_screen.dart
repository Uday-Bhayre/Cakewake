import 'package:cakewake_vendor/core/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class OnBoardingScreen extends StatelessWidget {
  const OnBoardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.surface,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SvgPicture.asset(
                'assets/images/onboarding/vendors.svg',
                width: 366.w,
                height: 366.h,
                semanticsLabel: 'Delivery Partner',
                
              ),
              SizedBox(height: 15.h),
              Text(
                'Bake More. Sell\nSmart. Grow Faster',
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontSize: 32.sp,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w600,
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              ),
              SizedBox(height: 10.h),

              Text(
                'Be the Reason Someone Smiles Today – With Cake!',
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontSize: 15.sp,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w600,
                  color: Theme.of(context).colorScheme.onSecondary,
                ),
              ),
              SizedBox(height: 70.h),
              CustomButton(
                text: 'Get Started',
                onPressed: () {
                  Get.toNamed('/login');
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
