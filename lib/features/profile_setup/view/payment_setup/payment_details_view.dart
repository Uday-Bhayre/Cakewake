import 'package:cakewake_vendor/core/widgets/custom_button.dart';
import 'package:cakewake_vendor/core/widgets/custom_textfield.dart';
import 'package:cakewake_vendor/core/widgets/help_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../../controller/profile_setup_controller.dart';

class PaymentDetailsView extends StatelessWidget {
  const PaymentDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ProfileSetupController>();
    final formKey = GlobalKey<FormState>();
    // Track if user has attempted to submit
    final showErrors = ValueNotifier(false);
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
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: SingleChildScrollView(
          child: StatefulBuilder(
            builder: (context, setState) {
              return GetBuilder<ProfileSetupController>(
                id: 'payment',
                builder: (_) {
                  return ValueListenableBuilder<bool>(
                    valueListenable: showErrors,
                    builder: (context, show, _) {
                      return Form(
                        key: formKey,
                        autovalidateMode: show
                            ? AutovalidateMode.always
                            : AutovalidateMode.disabled,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 40),
                            Text(
                              'Add a payout details',
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 18,
                                color: Theme.of(context).colorScheme.onSurface,
                              ),
                            ),
                            SizedBox(height: 4),
                            Text(
                              'Enter your UPI or bank account details to receive payments',
                              style: TextStyle(
                                fontSize: 14,
                                color: Color(0xFF7B7B7B),
                              ),
                            ),
                            SizedBox(height: 24),
                            CustomTextField(
                              hintText: 'UPI',
                              controller: controller.upiController,
                              validator: (val) => controller.validateUpi(val),
                              onChanged: (val) =>
                                  controller.onPaymentFieldChanged(upi: val),
                            ),
                            SizedBox(height: 24),
                            Row(
                              children: [
                                Expanded(
                                  child: Divider(
                                    thickness: 1,
                                    color: Color(0xFF7B7B7B),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 8.0,
                                  ),
                                  child: Text(
                                    'or',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Color(0xFF7B7B7B),
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Divider(
                                    thickness: 1,
                                    color: Color(0xFF7B7B7B),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 24),
                            Text(
                              'Bank Info',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            SizedBox(height: 8),
                            CustomTextField(
                              hintText: 'Account Holder Name',
                              controller: controller.accNameController,
                              validator: (val) =>
                                  controller.upiController.text
                                      .trim()
                                      .isNotEmpty
                                  ? null
                                  : controller.validateAccountHolderName(val),
                              onChanged: (val) =>
                                  controller.onPaymentFieldChanged(
                                    accountHolderName: val,
                                  ),
                            ),
                            SizedBox(height: 16),
                            CustomTextField(
                              hintText: 'Account Number',
                              controller: controller.accNumController,
                              validator: (val) =>
                                  controller.upiController.text
                                      .trim()
                                      .isNotEmpty
                                  ? null
                                  : controller.validateAccountNumber(val),
                              keyboardType: TextInputType.number,
                              onChanged: (val) => controller
                                  .onPaymentFieldChanged(accountNumber: val),
                            ),
                            SizedBox(height: 16),
                            CustomTextField(
                              hintText: 'Re-enter Account Number',
                              controller: controller.reAccNumController,
                              validator: (val) =>
                                  controller.upiController.text
                                      .trim()
                                      .isNotEmpty
                                  ? null
                                  : controller.validateReAccountNumber(
                                      val,
                                      controller.accNumController.text,
                                    ),
                              keyboardType: TextInputType.number,
                              onChanged: (val) => controller
                                  .onPaymentFieldChanged(reAccountNumber: val),
                            ),
                            SizedBox(height: 16),
                            CustomTextField(
                              hintText: 'IFSC Code',
                              controller: controller.ifscController,
                              validator: (val) =>
                                  controller.upiController.text
                                      .trim()
                                      .isNotEmpty
                                  ? null
                                  : controller.validateIfsc(val),
                              keyboardType: TextInputType.text,
                              onChanged: (val) => controller
                                  .onPaymentFieldChanged(ifscCode: val),
                            ),
                            SizedBox(height: 50),
                            CustomButton(
                              text: "Continue",
                              onPressed: () async {
                                showErrors.value = true;
                                setState(() {}); // Force rebuild to show errors
                                if (!(formKey.currentState?.validate() ??
                                    false))
                                  return;
                                // Only call submitPaymentSetup if all fields are valid
                                await controller.submitPaymentSetup();
                              },
                            ),
                          ],
                        ),
                      );
                    },
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
