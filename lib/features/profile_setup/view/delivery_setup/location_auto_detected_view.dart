import 'package:cakewake_vendor/core/widgets/custom_button.dart';
import 'package:cakewake_vendor/core/widgets/help_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import '../../controller/profile_setup_controller.dart';

class LocationAutoDetectedView extends GetView<ProfileSetupController> {
  const LocationAutoDetectedView({super.key});

  @override
  Widget build(BuildContext context) {

    // Listen to isLoading and show/hide EasyLoading
    controller.detectUserCity();
    
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        backgroundColor: Colors.transparent,  
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Theme.of(context).colorScheme.onSurface,
          ),
          onPressed: () => Get.back(),
        ),
        actions: [
         HelpButton(color: Theme.of(context).colorScheme.primary),
          SizedBox(width: 20.w),
          GestureDetector(
            onTap: () {},
            child: SvgPicture.asset(
              'assets/images/profile_setup/language_icon.svg',
              width: 28.w,
              height: 28.h,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
          SizedBox(width: 15.w),
          GestureDetector(
            child: Icon(
              Icons.more_vert,
              color: Theme.of(context).colorScheme.primary,
              size: 28,
            ),
            onTap: () {
              // Add your action here
            },
          ),
          const SizedBox(width: 10),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Obx(() {
          // Remove the local loading indicator, EasyLoading will handle it
          if (controller.isLoading.value) {
            return SizedBox.shrink();
          } else if (controller.locationError.value != null) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.error, color: Colors.red, size: 32),
                SizedBox(height: 8),
                Text(
                  controller.locationError.value!,
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.red),
                ),
                SizedBox(height: 8),
                ElevatedButton(
                  onPressed: controller.detectUserCity,
                  child: Text('Try Again'),
                ),
                const Spacer(),
                CustomButton(
                  text: "Continue",
                  enabled: false,
                  onPressed: () {},
                ),
              ],
            );
          } else {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                LinearProgressIndicator(
                  value: 0.5,
                  backgroundColor: Colors.grey[300],
                  valueColor: AlwaysStoppedAnimation(Color(0xFF8F7BF1)),
                  minHeight: 3.5,
                  borderRadius: BorderRadius.circular(8),
                ),
                SizedBox(height: 32),
                Image.asset(
                  'assets/images/profile_setup/location.png',
                  width: 250.w,
                  height: 250.h,
                  fit: BoxFit.contain,
                ),
                SizedBox(height: 32),
                Text(
                  "We've auto detected your city. This is the city where you will work.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                ),
                SizedBox(height: 16),
                Text(
                  controller.deliverySetup.value.city,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
                TextButton(
                  onPressed: () => Get.toNamed('/profile/select_city'),
                  child: Text(
                    "Change city",
                    style: TextStyle(
                      color: Color(0xFF8B7BF1),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                const Spacer(),
                CustomButton(
                  text: "Continue",
                  enabled: true,
                  onPressed: () => Get.toNamed('/profile/select_area'),
                ),
              ],
            );
          }
        }),
      ),
    );
  }
}
