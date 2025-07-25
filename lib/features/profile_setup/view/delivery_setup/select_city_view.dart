import 'package:cakewake_vendor/core/widgets/custom_button.dart';
import 'package:cakewake_vendor/core/widgets/help_button.dart';
import 'package:cakewake_vendor/core/widgets/select_list_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../../controller/profile_setup_controller.dart';

class SelectCityView extends StatelessWidget {
  SelectCityView({super.key});
  final TextEditingController searchController = TextEditingController();
  final RxString searchText = ''.obs;
  final List<String> allIndianCities = [
    "Agra",
    "Ahmedabad",
    "Alwar",
    "Ambala",
    "Amritsar",
    "Bangalore",
    "Bhopal",
    "Chandigarh",
    "Chennai",
    "Delhi",
    "Faridabad",
    "Ghaziabad",
    "Gurgaon",
    "Hyderabad",
    "Indore",
    "Jaipur",
    "Kanpur",
    "Kolkata",
    "Lucknow",
    "Ludhiana",
    "Mumbai",
    "Nagpur",
    "Noida",
    "Patna",
    "Pune",
    "Surat",
    "Thane",
    "Varanasi",
    "Visakhapatnam",
    // ... (add more as needed)
  ];

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ProfileSetupController>();
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.surface,
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
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 8),
            LinearProgressIndicator(
              value: 0.5,
              backgroundColor: Colors.grey[300],
              valueColor: AlwaysStoppedAnimation(Color(0xFF8F7BF1)),
              minHeight: 3.5,
              borderRadius: BorderRadius.circular(8),
            ),
            SizedBox(height: 24),
            Text(
              'Select Work City',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 18,
                color: Theme.of(context).colorScheme.onSurface,
              ),
            ),
            SizedBox(height: 4),
            Text(
              'Please select the city where you want to work',
              style: TextStyle(
                fontSize: 14,
                color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
              ),
            ),
            SizedBox(height: 16),
            TextField(
              controller: searchController,
              onChanged: (val) => searchText.value = val,
              decoration: InputDecoration(
                hintText: "Search your city",
                hintStyle: TextStyle(
                  color: Theme.of(
                    context,
                  ).colorScheme.onSurface.withOpacity(0.6),
                  fontWeight: FontWeight.w500,
                ),
                prefixIcon: Icon(
                  Icons.search,
                  color: Theme.of(context).colorScheme.outline,
                ),
                filled: true,
                fillColor: Theme.of(context).colorScheme.surface,
                contentPadding: EdgeInsets.symmetric(
                  vertical: 0,
                  horizontal: 12,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ),
            ),
            SizedBox(height: 8),
            Expanded(
              child: Obx(() {
                final filter = searchText.value.trim().toLowerCase();
                final filteredCities = filter.isEmpty
                    ? allIndianCities
                    : allIndianCities
                          .where((city) => city.toLowerCase().contains(filter))
                          .toList();
                return filteredCities.isEmpty
                    ? Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'No city found',
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.error,
                          ),
                        ),
                      )
                    : ListView.separated(
                        padding: EdgeInsets.zero,
                        itemCount: filteredCities.length,
                        separatorBuilder: (context, i) => Divider(
                          height: 1,
                          color: Theme.of(
                            context,
                          ).colorScheme.surfaceContainerHighest,
                        ),
                        itemBuilder: (context, i) {
                          return SelectListTile(
                            title: filteredCities[i],
                            isSelected:
                                controller.deliverySetup.value.city ==
                                filteredCities[i],
                            onTap: () {
                              controller.deliverySetup.update((d) {
                                if (d != null) d.city = filteredCities[i];
                              });
                              if (searchText.value.isNotEmpty) {
                                searchController.text = filteredCities[i];
                              } else {
                                searchController.clear();
                              }
                              controller.update();
                              searchText.refresh();
                            },
                          );
                        },
                      );
              }),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 8, 0, 16),
              child: Obx(
                () => CustomButton(
                  text: "Continue",
                  enabled: controller.deliverySetup.value.city.isNotEmpty,
                  onPressed: () {
                    Get.back();
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
