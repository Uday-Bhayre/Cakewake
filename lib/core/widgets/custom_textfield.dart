import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class CustomTextField extends StatelessWidget {
  final String hintText;
  final String? Function(String?)? validator;
  final TextEditingController controller;
  final bool obscureText;
  final VoidCallback? toggleVisibility;
  final TextInputType keyboardType;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final Function(String)? onChanged;

  const CustomTextField({
    super.key,
    required this.hintText,
    required this.validator,
    required this.controller,
    this.obscureText = false,
    this.toggleVisibility,
    this.keyboardType = TextInputType.text,
    this.prefixIcon,
    this.suffixIcon,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    Widget? effectiveSuffixIcon = suffixIcon;

    // If toggleVisibility is provided, show the eye icon
    if (toggleVisibility != null) {
      effectiveSuffixIcon = IconButton(
        onPressed: toggleVisibility,
        icon: Icon(
          obscureText ? Icons.visibility_off : Icons.visibility,
          color: Colors.grey,
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 2.0),
      child: TextFormField(
        controller: controller,
        obscureText: obscureText,

        decoration: InputDecoration(
          suffixIcon: effectiveSuffixIcon,
          prefixIcon: prefixIcon,
          // hintText: hintText,
          // hintStyle: TextStyle(
          //   color: Theme.of(context).colorScheme.onSecondary,
          //   fontSize: 16.sp,
          // ),
          filled: true,
          fillColor: Theme.of(context).colorScheme.surface,
          contentPadding: EdgeInsets.symmetric(
            vertical: 18.h,
            horizontal: 18.w,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16.r),
            borderSide: BorderSide(
              color: Theme.of(context).colorScheme.primary,
              width: 1,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16.r),
            borderSide: BorderSide(
              color: Theme.of(context).colorScheme.primary,
              width: 1,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16.r),
            borderSide: BorderSide(
              color: Theme.of(context).colorScheme.primary,
              width: 2,
            ),
          ),
          labelText: hintText,
          labelStyle: TextStyle(
            color: Theme.of(context).colorScheme.onSecondary,
            fontSize: 16.sp,
          ),
          floatingLabelBehavior: FloatingLabelBehavior.auto,
        ),
        keyboardType: keyboardType,
        validator: validator,
        // Disable auto-validation - validation will happen on form submission
        autovalidateMode: AutovalidateMode.disabled,
      ),
    );
  }
}
