import 'dart:io';
import 'package:cakewake_vendor/core/widgets/custom_button.dart';
import 'package:cakewake_vendor/core/widgets/help_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:cakewake_vendor/core/widgets/image_picker.dart'
    as custom_picker;
import '../../controller/profile_setup_controller.dart';

class ContractUploadView extends GetView<ProfileSetupController> {
  const ContractUploadView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: colorScheme.surface,
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
          HelpButton(color: colorScheme.primary),
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
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Progress bar
            SizedBox(
              width: double.infinity,
              child: LinearProgressIndicator(
                value: 1,
                backgroundColor: colorScheme.surfaceContainerHighest,
                valueColor: AlwaysStoppedAnimation<Color>(colorScheme.primary),
                minHeight: 4,
              ),
            ),
            const SizedBox(height: 32),
            Text(
              'Upload Contract Documents',
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color: colorScheme.onSurface,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Upload a valid Contract Documents',
              style: theme.textTheme.bodyMedium?.copyWith(
                color: colorScheme.onSecondary,
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 32),
            Center(
              child: Obx(() {
                final file = controller.contractDocumentFile.value;
                return Container(
                  width: size.width * 0.7,
                  height: size.width * 0.4,
                  decoration: BoxDecoration(
                    color: colorScheme.surfaceContainerHighest,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: file == null
                      ? const Icon(
                          Icons.insert_drive_file_outlined,
                          size: 60,
                          color: Colors.grey,
                        )
                      : ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                          child: Image.file(
                            file,
                            fit: BoxFit.cover,
                            width: double.infinity,
                            height: double.infinity,
                          ),
                        ),
                );
              }),
            ),
            const Spacer(),
            Center(
              child: GestureDetector(
                onTap: () async {
                  final pickedFile =
                      await custom_picker.ImageSourceBottomSheet.pickImage(
                        context: context,
                        title: 'Select Image Source',
                      );
                  if (pickedFile != null) {
                    controller.setContractDocumentFile(File(pickedFile.path));
                  }
                },
                child: Container(
                  padding: EdgeInsets.all(1.w),
                  width: 90.w,
                  height: 90.w,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: colorScheme.onSurface,
                    boxShadow: [
                      BoxShadow(
                        color: colorScheme.onSurface.withOpacity(0.08),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Center(
                    child: Container(
                      width: 80.w,
                      height: 80.w,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: colorScheme.onSurface,
                        border: Border.all(
                          color: colorScheme.surface,
                          width: 2,
                        ),
                      ),
                      child: Center(
                        child: Icon(
                          Icons.camera_alt,
                          size: 28,
                          color: colorScheme.surface,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Center(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.verified_user_outlined,
                    color: Colors.green,
                    size: 18,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    'powered by',
                    style: theme.textTheme.labelSmall?.copyWith(
                      color: colorScheme.onSurfaceVariant,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),

            CustomButton(
              text: "Continue",
              onPressed: () async {
                if (controller.contractDocumentFile.value == null) {
                  Get.snackbar(
                    'Error',
                    'Please upload a valid Contract Document before continuing.',
                    snackPosition: SnackPosition.TOP,
                    backgroundColor: Colors.red.withOpacity(0.9),
                    colorText: Colors.white,
                    margin: EdgeInsets.all(16),
                  );
                  return;
                }
                await controller.submitBusinessDetails();
              },
            ),
            const SizedBox(height: 12),
          ],
        ),
      ),
    );
  }
}
