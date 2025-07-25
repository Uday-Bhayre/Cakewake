import 'package:cakewake_vendor/core/widgets/custom_button.dart';
import 'package:cakewake_vendor/core/widgets/help_button.dart';
import 'package:cakewake_vendor/core/widgets/select_list_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../controller/profile_setup_controller.dart';

class SelectAreaView extends StatelessWidget {
  SelectAreaView({super.key});
  final TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ProfileSetupController>();
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
              size: 28.sp,
            ),
            onTap: () {},
          ),
          SizedBox(width: 10.w),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            LinearProgressIndicator(
              value: 1,
              backgroundColor: Theme.of(
                context,
              ).colorScheme.surfaceContainerHighest,
              valueColor: AlwaysStoppedAnimation<Color>(
                Theme.of(context).colorScheme.primary,
              ),
              minHeight: 3.5.h,
              borderRadius: BorderRadius.circular(8.r),
            ),
            SizedBox(height: 24.h),
            Text(
              'Select Work Area in ${controller.deliverySetup.value.city}',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 18.sp,
                color: Theme.of(context).colorScheme.onSurface,
              ),
            ),
            SizedBox(height: 4.h),
            Text(
              'Please select the area where you want to work',
              style: TextStyle(
                fontSize: 14.sp,
                color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
              ),
            ),
            SizedBox(height: 16.h),
            TextField(
              controller: searchController,
              onChanged: controller.setAreaSearchText,
              decoration: InputDecoration(
                hintText: "Search your area",
                hintStyle: TextStyle(
                  color: Theme.of(
                    context,
                  ).colorScheme.onSurface.withOpacity(0.6),
                  fontWeight: FontWeight.w500,
                  fontSize: 16.sp,
                ),
                prefixIcon: Icon(
                  Icons.search,
                  color: Theme.of(context).colorScheme.outline,
                ),
                filled: true,
                fillColor: Theme.of(context).colorScheme.surface,
                contentPadding: EdgeInsets.symmetric(
                  vertical: 0,
                  horizontal: 12.w,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.r),
                  borderSide: BorderSide(
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.r),
                  borderSide: BorderSide(
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.r),
                  borderSide: BorderSide(
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ),
            ),
            SizedBox(height: 8.h),
            Expanded(
              child: Obx(() {
                final filteredAreas = controller.filteredAreas;
                return filteredAreas.isEmpty
                    ? Padding(
                        padding: EdgeInsets.all(8.w),
                        child: Text(
                          'No area found',
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.error,
                          ),
                        ),
                      )
                    : ListView.builder(
                        padding: EdgeInsets.zero,
                        itemCount: filteredAreas.length,
                        itemBuilder: (context, i) {
                          final areaName = filteredAreas[i]["name"]!;
                          final isSelected = controller
                              .deliverySetup
                              .value
                              .areas
                              .contains(areaName);
                          return SelectListTile(
                            title: areaName,
                            subtitle: filteredAreas[i]["distance"],
                            isSelected: isSelected,

                            onTap: () {
                              controller.selectArea(areaName);
                              controller.areaSearchText.refresh();
                            },
                          );
                        },
                      );
              }),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(16.w, 0, 16.w, 16.h),
              child: Obx(
                () => CustomButton(
                  text: "Continue",
                  enabled: controller.deliverySetup.value.areas.isNotEmpty,
                  onPressed: controller.deliverySetup.value.areas.isNotEmpty
                      ? () async {
                          await controller.submitDeliverySetup();
                        }
                      : () {},
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
