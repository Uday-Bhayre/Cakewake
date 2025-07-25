import 'package:cakewake_vendor/core/widgets/custom_button.dart';
import 'package:cakewake_vendor/core/widgets/custom_textfield.dart';
import 'package:cakewake_vendor/core/widgets/help_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../../controller/profile_setup_controller.dart';

class NameEmailView extends GetView<ProfileSetupController> {
  const NameEmailView({super.key});

  @override
  Widget build(BuildContext context) {
    final b = controller.businessDetails.value;
    final nameController = TextEditingController(text: b.name);
    final emailController = TextEditingController(text: b.email ?? '');
    final formKey = GlobalKey<FormState>();

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
              value: 0.25, // 25% progress for Personal Details
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
              "Personal Details",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 22.sp,
                color: Theme.of(context).colorScheme.onSurface,
              ),
            ),
          ),
          SizedBox(height: 18.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Form(
              key: formKey,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomTextField(
                    controller: nameController,
                    keyboardType: TextInputType.name,
                    hintText: "Name",
                    validator: controller.validateName,
                    onChanged: (val) {
                      controller.businessDetails.update((b) {
                        if (b != null) b.name = val;
                      });
                    },
                  ),
                  SizedBox(height: 18.h),
                  CustomTextField(
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
                    hintText: "Email (Optional)",
                    validator: controller.validateEmail,
                    onChanged: (val) {
                      controller.businessDetails.update((b) {
                        if (b != null) b.email = val;
                      });
                    },
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
                if (formKey.currentState?.validate() ?? false) {
                  controller.businessDetails.update((b) {
                    if (b != null) {
                      b.name = nameController.text;
                      b.email = emailController.text;
                    }
                  });
                  FocusScope.of(context).unfocus();
                  Get.toNamed('/profile/business_info');
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
