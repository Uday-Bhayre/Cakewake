// lib/features/profile/widgets/progress_indicator.dart
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProfileProgressIndicator extends StatelessWidget {
  final int currentStep;
  final int totalSteps;

  const ProfileProgressIndicator({
    super.key,
    required this.currentStep,
    required this.totalSteps,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: LinearProgressIndicator(
            value: (currentStep + 1) / totalSteps,
            // backgroundColor: AppColors.textSecondary.withOpacity(0.2),
            // valueColor: AlwaysStoppedAnimation<Color>(
            //   // AppColors.primaryButtonBackground,
            // ),
            minHeight: 6.h,
            borderRadius: BorderRadius.circular(2.r),
          ),
        ),
        SizedBox(width: 8.w),
        Text(
          '${currentStep + 1}',
          style: TextStyle(
            color: Theme.of(context).colorScheme.onSurface,
            fontSize: 22.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          '/$totalSteps',
          style: TextStyle(
            color: Theme.of(context).colorScheme.onSurface,
            fontSize: 14.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(width: 8.w),
      ],
    );
  }
}
