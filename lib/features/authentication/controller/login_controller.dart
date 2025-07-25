import 'dart:async';

import 'package:cakewake_vendor/core/services/auth_service.dart';
import 'package:cakewake_vendor/features/authentication/model/login_request.dart';
import 'package:cakewake_vendor/features/authentication/model/user.dart';
import 'package:cakewake_vendor/features/authentication/repository/auth_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class LoginController extends GetxController {
  final AuthRepository _authRepository;

  LoginController(this._authRepository);

  RxString mobileNumber = ''.obs;
  final formKey = GlobalKey<FormState>();
  RxString otpCode = ''.obs;
  final timer = 25.obs;
  RxBool isLoading = false.obs;

  Timer? _timer;

  @override
  void onInit() {
    super.onInit();
    startTimer();
  }

  void startTimer() {
    timer.value = 25;
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (t) {
      if (timer.value == 0) {
        t.cancel();
      } else {
        timer.value--;
      }
    });
  }

  Future<void> onOtpChanged(String value) async {
    otpCode.value = value;
    if (value.length == 6) {
      // Automatically submit OTP when it reaches 6 digits
      await signup();
    }
  }

  Future<void> sendOtp() async {
    if (!formKey.currentState!.validate() || mobileNumber.value.isEmpty) {
      Get.snackbar(
        'Error',
        'Please fill all required fields and accept the terms',
      );
      return;
    }

    try {
      isLoading.value = true;
      EasyLoading.show(status: 'Sending OTP...');
      print(
        'Sending OTP for mobile number: ${mobileNumber.value.substring(3)}',
      );
      final response = await _authRepository.sendOtp(
        mobileNumber.value.substring(3),
      );
      print('Send OTP response: $response');
      // if (response['success']) {
      if (response['success'] == true) {
        Get.snackbar(
          'OTP Sent',
          response['message'] ?? "OTP sent successfully",
          duration: const Duration(seconds: 3),
          snackPosition: SnackPosition.BOTTOM,
        );
        startTimer();
        Get.toNamed('/otp');
      } else {
        print('Send OTP error: ');
        Get.snackbar(
          'Error',
          response['message'] ?? "Failed to send OTP",
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    } catch (e) {
      print('Send OTP error: $e');
      Get.snackbar('Error', e.toString(), snackPosition: SnackPosition.BOTTOM);
    } finally {
      isLoading.value = false;
      EasyLoading.dismiss();
    }
  }

  Future<void> signup() async {
    if (otpCode.value.isEmpty) {
      Get.snackbar('Error', 'Please enter the OTP');
      return;
    }

    try {
      isLoading.value = true;
      EasyLoading.show(status: 'Creating your account...');

      final LoginRequest request = LoginRequest(
        mobileNumber: mobileNumber.value.substring(3),
        otp: otpCode.value,
      );
      print('Signup request: ${request.toJson()}');
      final response = await _authRepository.login(request);

      if (response.success == true &&
          response.token != null &&
          response.user != null) {
        // Save user session or token as needed
        final userData = response.user!;
        final user = User(
          id: userData['_id'],
          mobileNumber: userData['mobileNumber'],
          createdAt: DateTime.parse(userData['createdAt']),
          lastLoginAt: DateTime.parse(userData['updatedAt']),
        );

        await AuthService.to.saveUserSession(response.token!, response.hasProfile, user);
        Get.snackbar('Success', 'Account created successfully');

        if(response.hasProfile == true) {
          Get.offAllNamed('/navigation');
        } else {
          // Navigate to profile setup if user doesn't have a profile
          Get.offAllNamed('/profile/setup');
        }
        
      } else {
        Get.snackbar(
          'Error',
          response.message ?? 'Failed to verify OTP',
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    } catch (e) {
      print('Signup error: $e');
      Get.snackbar(
        'Error',
        'Failed to verify OTP. Please try again.',
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoading.value = false;
      EasyLoading.dismiss();
    }
  }

  @override
  void onClose() {
    _timer?.cancel();
    super.onClose();
  }
}
