import 'package:cakewake_vendor/features/splash_screen/controller/splash_screen_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class SplashScreen extends StatelessWidget {
  SplashScreen({super.key});

  // Register SplashController if not already registered
  final controller = Get.put(SplashController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primary,
          image: DecorationImage(
            image: AssetImage('assets/images/onboarding/splash.png'),
            repeat: ImageRepeat.repeat,
            fit: BoxFit.none,
            colorFilter: ColorFilter.mode(
              Theme.of(context).colorScheme.primary.withAlpha(70),
              BlendMode.dstATop,
            ),
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset('assets/images/onboarding/cup2.svg'),
              SizedBox(height: 1.h),
              Text(
                'CakeWake',
                style: TextStyle(
                  fontFamily: 'Pacifico',
                  fontWeight: FontWeight.w400,
                  fontStyle: FontStyle.italic,
                  fontSize: 34.sp,
                  color: Colors.white,
                  letterSpacing: 1.5,
                  shadows: [
                    Shadow(
                      blurRadius: 6,
                      color: Colors.black.withAlpha((0.5 * 255).toInt()),
                      offset: Offset(2, 2),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
