import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:async';

class ImageSourceOption extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback onTap;

  const ImageSourceOption({
    super.key,
    required this.title,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pop(context);
        onTap();
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: EdgeInsets.all(16.w),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.onSecondary.withAlpha(60),
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              size: 32.r,
              // color: AppColors.primaryButtonBackground,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            title,
            style: TextStyle(
              fontSize: 14.sp,
              color: Theme.of(context).colorScheme.onSurface,
            ),
          ),
        ],
      ),
    );
  }
}

class ImageSourceBottomSheet extends StatelessWidget {
  final String title;
  final Function(ImageSource) onImageSourceSelected;

  const ImageSourceBottomSheet({
    super.key,
    required this.title,
    required this.onImageSourceSelected,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.onSurface,
              ),
            ),
            SizedBox(height: 20.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ImageSourceOption(
                  title: 'Camera',
                  icon: Icons.camera_alt,
                  onTap: () => onImageSourceSelected(ImageSource.camera),
                ),
                ImageSourceOption(
                  title: 'Gallery',
                  icon: Icons.photo_library,
                  onTap: () => onImageSourceSelected(ImageSource.gallery),
                ),
              ],
            ),
            SizedBox(height: 16.h),
          ],
        ),
      ),
    );
  }

  static Future<void> show({
    required BuildContext context,
    required String title,
    required Function(ImageSource) onImageSourceSelected,
  }) async {
    await showModalBottomSheet(
      backgroundColor: Theme.of(context).colorScheme.secondary,
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(15.r)),
      ),
      builder:
          (context) => ImageSourceBottomSheet(
            title: title,
            onImageSourceSelected: onImageSourceSelected,
          ),
    );
  }

  static Future<XFile?> pickImage({
    required BuildContext context,
    required String title,
    int imageQuality = 70,
  }) async {
    final completer = Completer<XFile?>();

    await show(
      context: context,
      title: title,
      onImageSourceSelected: (source) async {
        final ImagePicker picker = ImagePicker();
        final XFile? image = await picker.pickImage(
          source: source,
          imageQuality: imageQuality,
        );
        completer.complete(image);
      },
    );

    return completer.future;
  }
}