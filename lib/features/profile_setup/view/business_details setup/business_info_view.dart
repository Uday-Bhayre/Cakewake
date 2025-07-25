import 'package:cakewake_vendor/core/widgets/custom_button.dart';
import 'package:cakewake_vendor/core/widgets/custom_textfield.dart';
import 'package:cakewake_vendor/core/widgets/help_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../../controller/profile_setup_controller.dart';

class BusinessInfoView extends GetView<ProfileSetupController> {
  BusinessInfoView({super.key});

  final businessNameController = TextEditingController();
  final gstController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final b = controller.businessDetails.value;
    businessNameController.text = b.businessName;
    gstController.text = b.gst ?? '';
    // Set default business type to 'Bakery' if not set
    if (controller.businessDetails.value.businessType.isEmpty) {
      controller.businessDetails.update((b) {
        if (b != null) b.businessType = 'Bakery';
      });
    }

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
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 8.h),
          // Progress indicator
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: LinearProgressIndicator(
              value: .5, // 50% progress for Business Info
              backgroundColor: Colors.grey[300],
              valueColor: AlwaysStoppedAnimation(Color(0xFF8F7BF1)),
              minHeight: 3.5,
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          SizedBox(height: 18.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Text(
              "Business Information",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 22.sp,
                color: Theme.of(context).colorScheme.onSurface,
              ),
            ),
          ),
          SizedBox(height: 15.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Form(
              key: _formKey,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomTextField(
                    controller: businessNameController,
                    keyboardType: TextInputType.name,
                    hintText: "Business Name",
                    validator: controller.validateBusinessName,
                    onChanged: (val) => controller.businessDetails.update((b) {
                      if (b != null) b.businessName = val;
                    }),
                  ),
                  SizedBox(height: 18.h),
                  CustomTextField(
                    controller: gstController,
                    keyboardType: TextInputType.text,
                    hintText: "GST (Optional)",
                    validator: controller.validateGst,
                    onChanged: (val) => controller.businessDetails.update((b) {
                      if (b != null) b.gst = val;
                    }),
                  ),
                  SizedBox(height: 30.h),
                  Text(
                    "Select Business Type",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 22.sp,
                    ),
                  ),
                  Obx(
                    () => Row(
                      children: [
                        Radio<String>(
                          value: 'Bakery',
                          groupValue:
                              controller.businessDetails.value.businessType,
                          onChanged: (val) {
                            controller.businessDetails.update((b) {
                              if (b != null) b.businessType = val!;
                            });
                            controller.update(['businessType']);
                          },
                          activeColor: Color(0xFF8F7BF1),
                        ),
                        Text("Bakery", style: TextStyle(fontSize: 15.sp)),
                        SizedBox(width: 16),
                        Radio<String>(
                          value: 'Home Baker',
                          groupValue:
                              controller.businessDetails.value.businessType,
                          onChanged: (val) {
                            controller.businessDetails.update((b) {
                              if (b != null) b.businessType = val!;
                            });
                            controller.update(['businessType']);
                          },
                          activeColor: Color(0xFF8F7BF1),
                        ),
                        Text("Home Baker", style: TextStyle(fontSize: 15.sp)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Spacer(),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
            child: CustomButton(
              text: "Continue",
              onPressed: () {
                if (_formKey.currentState?.validate() ?? false) {
                  controller.businessDetails.update((b) {
                    if (b != null) {
                      b.businessName = businessNameController.text;
                      b.gst = gstController.text;
                    }
                  });
                  FocusScope.of(context).unfocus();
                  Get.toNamed('/profile/fssai_upload');
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
