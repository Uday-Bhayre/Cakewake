import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HelpButton extends StatelessWidget {
  final VoidCallback? onTap;
  final Color? color;
  final String label;
  final double? fontSize;
  final EdgeInsetsGeometry? padding;

  const HelpButton({
    super.key,
    this.onTap,
    this.color,
    this.label = 'Help',
    this.fontSize,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    return InkWell(
      borderRadius: BorderRadius.circular(20.r),
      onTap: onTap,
      child: Container(
        padding:
            padding ?? EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
        decoration: BoxDecoration(
          border: Border.all(color: color ?? colorScheme.onPrimary),
          borderRadius: BorderRadius.circular(20.r),
          color: Colors.transparent,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.help_outline,
              color: color ?? colorScheme.onPrimary,
              size: fontSize != null ? fontSize! + 4 : 18.sp,
            ),
            SizedBox(width: 4.w),
            Text(
              label,
              style: TextStyle(
                color: color ?? colorScheme.onPrimary,
                fontSize: fontSize ?? 14.sp,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
