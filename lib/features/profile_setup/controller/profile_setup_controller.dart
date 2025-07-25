import 'package:cakewake_vendor/features/profile_setup/model/business_details_res_model.dart';
import 'package:cakewake_vendor/features/profile_setup/model/delivery_setup_res_model.dart';
import 'package:cakewake_vendor/features/profile_setup/model/payment_setup_res_model.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import '../model/business_details_model.dart';
import '../model/business_details_req_model.dart';
import '../repository/profile_setup_repository.dart';
import '../model/delivery_setup_model.dart';
import '../model/delivery_setup_req_model.dart';
import '../model/payment_setup_model.dart';
import '../model/payment_setup_req_model.dart';

class ProfileSetupController extends GetxController {
  // Step completion
  var step1Completed = false.obs;
  var step2Completed = false.obs;
  var step3Completed = false.obs;

  // Location detection state
  final RxString detectedCity = ''.obs;
  final RxnString locationError = RxnString();
  final RxBool isLoading = false.obs;
  final RxBool locationLoading = false.obs;

  // Area search and filter
  final RxString areaSearchText = ''.obs;
  final RxList<Map<String, String>> allAreas = <Map<String, String>>[
    {"name": "Sector 66", "distance": "1.40km"},
    {"name": "Sector 50", "distance": "2.46km"},
    {"name": "Sector 43", "distance": "2.93km"},
    {"name": "Sector 49", "distance": "3.00km"},
    {"name": "Sector 47", "distance": "4.23km"},
  ].obs;

  // FSSAI Certificate file
  final Rx<File?> fssaiCertificateFile = Rx<File?>(null);
  final Rx<File?> contractDocumentFile = Rx<File?>(null);

  // Work areas (multiple)
  final RxList<String> workAreas = <String>[].obs;

  // Business details state
  final businessDetails = BusinessDetailsModel(
    name: '',
    email: null,
    businessName: '',
    businessType: '',
    gst: null,
    fssaiCertificatePath: '',
    contractDocumentPath: '',
  ).obs;

  // Delivery setup state
  final deliverySetup = DeliverySetupModel(city: '', areas: <String>[]).obs;

  // Payment setup state
  final paymentSetup = PaymentSetupModel(
    upiId: '',
    accountName: '',
    accountNumber: '',
    ifscCode: '',
  ).obs;

  final repo = ProfileSetupRepository();
  final errorMessage = ''.obs;

  // Payment TextEditingControllers
  late final TextEditingController upiController;
  late final TextEditingController accNameController;
  late final TextEditingController accNumController;
  late final TextEditingController reAccNumController;
  late final TextEditingController ifscController;

  @override
  void onInit() {
    super.onInit();
    upiController = TextEditingController();
    accNameController = TextEditingController();
    accNumController = TextEditingController();
    reAccNumController = TextEditingController();
    ifscController = TextEditingController();
  }

  @override
  void onClose() {
    upiController.dispose();
    accNameController.dispose();
    accNumController.dispose();
    reAccNumController.dispose();
    ifscController.dispose();
    super.onClose();
  }

  // --- Payment Details Error State ---
  final RxnString upiError = RxnString();
  final RxnString accNameError = RxnString();
  final RxnString accNumError = RxnString();
  final RxnString reAccNumError = RxnString();
  final RxnString ifscError = RxnString();

  // --- Payment Field Change Handler ---
  void onPaymentFieldChanged({
    String? upi,
    String? accountHolderName,
    String? accountNumber,
    String? reAccountNumber,
    String? ifscCode,
  }) {
    if (upi != null) paymentSetup.value.upiId = upi;
    if (accountHolderName != null)
      paymentSetup.value.accountName = accountHolderName;
    if (accountNumber != null) paymentSetup.value.accountNumber = accountNumber;
    if (ifscCode != null) paymentSetup.value.ifscCode = ifscCode;
    final p = paymentSetup.value;
    upiError.value = validateUpi(p.upiId);
    if (p.upiId.trim().isNotEmpty) {
      // If UPI is provided, clear all bank errors
      accNameError.value = null;
      accNumError.value = null;
      reAccNumError.value = null;
      ifscError.value = null;
    } else {
      accNameError.value = validateAccountHolderName(p.accountName);
      accNumError.value = validateAccountNumber(p.accountNumber);
      reAccNumError.value = validateReAccountNumber(
        reAccountNumber ?? reAccNumController.text,
        accountNumber ?? accNumController.text,
      );
      ifscError.value = validateIfsc(p.ifscCode);
    }
    update(['payment']);
  }

  bool get allStepsCompleted =>
      step1Completed.value && step2Completed.value && step3Completed.value;

  void completeStep(int step) {
    if (step == 1) step1Completed.value = true;
    if (step == 2) step2Completed.value = true;
    if (step == 3) step3Completed.value = true;
  }

  void reset() {
    step1Completed.value = false;
    step2Completed.value = false;
    step3Completed.value = false;
    businessDetails.value = BusinessDetailsModel(
      name: '',
      email: null,
      businessName: '',
      businessType: '',
      gst: null,
      fssaiCertificatePath: '',
      contractDocumentPath: '',
    );
    deliverySetup.value = DeliverySetupModel(city: '', areas: <String>[]);
    paymentSetup.value = PaymentSetupModel(
      upiId: '',
      accountName: '',
      accountNumber: '',
      ifscCode: '',
    );
    workAreas.clear();
  }

  Future<void> detectUserCity() async {
    isLoading.value = true;
    locationLoading.value = true;
    locationError.value = null;
    EasyLoading.show(status: 'Detecting location...');
    try {
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          locationError.value =
              'Location permission denied. Please allow location access.';
          isLoading.value = false;
          locationLoading.value = false;
          EasyLoading.dismiss();
          return;
        }
      }
      if (permission == LocationPermission.deniedForever) {
        locationError.value =
            'Location permissions are permanently denied. Please enable them in settings.';
        isLoading.value = false;
        locationLoading.value = false;
        EasyLoading.dismiss();
        return;
      }
      final position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
      final placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );
      if (placemarks.isNotEmpty) {
        final foundCity =
            placemarks.first.locality ??
            placemarks.first.subAdministrativeArea ??
            placemarks.first.administrativeArea ??
            'Unknown';
        detectedCity.value = foundCity;
        deliverySetup.update((d) {
          if (d != null) d.city = foundCity;
        });
        EasyLoading.dismiss();
        isLoading.value = false;
        locationLoading.value = false;
      } else {
        locationError.value = 'Could not determine city from location.';
        isLoading.value = false;
        locationLoading.value = false;
        EasyLoading.dismiss();
      }
    } catch (e) {
      EasyLoading.dismiss();
      locationError.value = 'Failed to get location: \\${e.toString()}';
      isLoading.value = false;
      locationLoading.value = false;
    }
  }

  List<Map<String, String>> get filteredAreas {
    final filter = areaSearchText.value.trim().toLowerCase();
    if (filter.isEmpty) return allAreas;
    return allAreas
        .where((area) => area["name"]!.toLowerCase().contains(filter))
        .toList();
  }

  void setAreaSearchText(String value) {
    areaSearchText.value = value;
  }

  void selectArea(String areaName) {
    if (workAreas.contains(areaName)) {
      removeWorkArea(areaName);
    } else {
      addWorkArea(areaName);
    }
    deliverySetup.update((d) {
      if (d != null) d.areas = workAreas.toList();
    });
    update();
  }

  void addWorkArea(String area) {
    if (!workAreas.contains(area)) {
      workAreas.add(area);
      deliverySetup.update((d) {
        if (d != null) d.areas = workAreas.toList();
      });
    }
  }

  void removeWorkArea(String area) {
    workAreas.remove(area);
    deliverySetup.update((d) {
      if (d != null) d.areas = workAreas.toList();
    });
  }

  Future<void> submitBusinessDetails() async {
    isLoading.value = true;
    errorMessage.value = '';
    // print('Submitting business details: ${businessDetails.value}');
    EasyLoading.show(status: 'Submitting business details...');
    try {
      final req = BusinessDetailRequest(
        name: businessDetails.value.name,
        email: businessDetails.value.email,
        businessName: businessDetails.value.businessName,
        businessType: businessDetails.value.businessType,
        gst: businessDetails.value.gst,
        fssaiCertificatePath: businessDetails.value.fssaiCertificatePath,
        contractDocumentPath: businessDetails.value.contractDocumentPath,
      );

      BusinessDetailsResponse response = await repo.submitBusinessDetails(req);
      print('Business details submission success: ${response.success}');

      EasyLoading.dismiss();
      completeStep(1);
      Get.offAllNamed('/profile/setup');
    } catch (e) {
      errorMessage.value = e.toString();
      EasyLoading.dismiss();
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> submitDeliverySetup() async {
    isLoading.value = true;
    errorMessage.value = '';
    EasyLoading.show(status: 'Submitting details...');
    try {
      final req = DeliverySetupRequest(
        city: deliverySetup.value.city,
        areas: deliverySetup.value.areas,
      );
      print(req.toJson());
      DeliverySetupResponse response = await repo.submitDeliverySetup(req);
      print('Delivery setup submission success: ${response.success}');

      EasyLoading.dismiss();
      completeStep(2);
      Get.offAllNamed('/profile/setup');
    } catch (e) {
      errorMessage.value = e.toString();
      EasyLoading.dismiss();
    } finally {
      isLoading.value = false;
      EasyLoading.dismiss();
    }
  }

  Future<void> submitPaymentSetup() async {
    isLoading.value = true;
    errorMessage.value = '';
    EasyLoading.show(status: 'Submitting details...');
    try {
      final req = PaymentSetupRequest(
        upiId: paymentSetup.value.upiId,
        accountName: paymentSetup.value.accountName,
        accountNumber: paymentSetup.value.accountNumber,
        ifscCode: paymentSetup.value.ifscCode,
      );

      PaymentSetupResponse response = await repo.submitPaymentSetup(req);

      EasyLoading.dismiss();
      completeStep(3);
      Get.offAllNamed('/profile/setup');
      // Handle navigation or success state
    } catch (e) {
      errorMessage.value = e.toString();
      EasyLoading.dismiss();
    } finally {
      isLoading.value = false;
      EasyLoading.dismiss();
    }
  }

  // --- Payment Details Validation ---
  String? validateUpi(String? value) {
    if (value == null || value.trim().isEmpty) {
      // UPI is optional, but if filled, must be valid
      return null;
    }
    // Simple UPI regex (can be improved)
    final upiRegex = RegExp(r'^[\w.-]+@[\w.-]+$');
    if (!upiRegex.hasMatch(value.trim())) {
      return 'Enter a valid UPI ID';
    }
    return null;
  }

  String? validateAccountHolderName(String? value) {
    if ((paymentSetup.value.upiId.trim().isEmpty) &&
        (value == null || value.trim().isEmpty)) {
      return 'Account holder name is required if UPI is not provided';
    }
    return null;
  }

  String? validateAccountNumber(String? value) {
    if ((paymentSetup.value.upiId.trim().isEmpty) &&
        (value == null || value.trim().isEmpty)) {
      return 'Account number is required if UPI is not provided';
    }
    if (value != null && value.isNotEmpty && value.length < 8) {
      return 'Account number seems too short';
    }
    return null;
  }

  String? validateReAccountNumber(String? value, String accountNumber) {
    if ((paymentSetup.value.upiId.trim().isEmpty) &&
        (value == null || value.trim().isEmpty)) {
      return 'Please re-enter account number';
    }
    if (value != null && value != accountNumber) {
      return 'Account numbers do not match';
    }
    return null;
  }

  String? validateIfsc(String? value) {
    if ((paymentSetup.value.upiId.trim().isEmpty) &&
        (value == null || value.trim().isEmpty)) {
      return 'IFSC code is required if UPI is not provided';
    }
    // Simple IFSC regex (can be improved)
    final ifscRegex = RegExp(r'^[A-Z]{4}0[A-Z0-9]{6}$', caseSensitive: false);
    if (value != null &&
        value.isNotEmpty &&
        !ifscRegex.hasMatch(value.trim())) {
      return 'Enter a valid IFSC code';
    }
    return null;
  }

  String? validateName(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Name is required';
    }
    return null;
  }

  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) return null;
    final emailRegex = RegExp(r'^[\w\.-]+@([\w-]+\.)+[\w-]{2,}$');
    if (!emailRegex.hasMatch(value.trim())) {
      return 'Enter a valid email';
    }
    return null;
  }

  // --- Business Details Validation ---
  String? validateBusinessName(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Business name is required';
    }
    return null;
  }

  String? validateBusinessType(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Business type is required';
    }
    return null;
  }

  String? validateGst(String? value) {
    if (value != null && value.isNotEmpty && value.length != 15) {
      return 'GST number must be 15 characters';
    }
    return null;
  }

  String? validateFssaiCertificatePath(String? value) {
    if (value == null || value.isEmpty) {
      return 'FSSAI certificate is required';
    }
    return null;
  }

  Map<String, String?> validateBusinessDetailsFields() {
    final b = businessDetails.value;
    return {
      'businessName': validateBusinessName(b.businessName),
      'businessType': validateBusinessType(b.businessType),
      'gst': (b.gst != null && b.gst!.isNotEmpty) ? validateGst(b.gst) : null,
      'fssaiCertificatePath': validateFssaiCertificatePath(
        b.fssaiCertificatePath,
      ),
    };
  }

  bool get isBusinessDetailsFormValid {
    final errors = validateBusinessDetailsFields();
    return errors.values.every((e) => e == null);
  }

  // Returns true if payment form is valid (UPI or all bank fields)
  bool get isPaymentValid {
    final p = paymentSetup.value;
    final upiValid = validateUpi(p.upiId) == null && p.upiId.trim().isNotEmpty;
    final bankValid =
        validateAccountHolderName(p.accountName) == null &&
        validateAccountNumber(p.accountNumber) == null &&
        validateIfsc(p.ifscCode) == null &&
        p.accountName.trim().isNotEmpty &&
        p.accountNumber.trim().isNotEmpty &&
        p.ifscCode.trim().isNotEmpty;
    // At least one method must be valid
    return upiValid || bankValid;
  }

  // Validate payment setup and show errors if needed
  bool validatePaymentSetup({
    bool showErrors = false,
    String? reAccountNumber,
  }) {
    final p = paymentSetup.value;
    onPaymentFieldChanged(reAccountNumber: reAccountNumber);
    final upiFilled = p.upiId.trim().isNotEmpty;
    final bankFilled =
        p.accountName.trim().isNotEmpty ||
        p.accountNumber.trim().isNotEmpty ||
        p.ifscCode.trim().isNotEmpty;
    if (!upiFilled && !bankFilled) {
      if (showErrors) {
        upiError.value = 'Please enter UPI or all bank details';
        accNameError.value = 'Please enter UPI or all bank details';
        accNumError.value = 'Please enter UPI or all bank details';
        reAccNumError.value = 'Please enter UPI or all bank details';
        ifscError.value = 'Please enter UPI or all bank details';
        update(['payment']);
      }
      return false;
    }
    if (upiFilled && upiError.value != null) {
      if (showErrors) update(['payment']);
      return false;
    }
    if (bankFilled) {
      if (accNameError.value != null ||
          accNumError.value != null ||
          reAccNumError.value != null ||
          ifscError.value != null) {
        if (showErrors) update(['payment']);
        return false;
      }
    }
    return true;
  }

  // Call this before allowing navigation to next step
  // Refactored: return all errors in a map for field-level display, no snackbar
  // Map<String, String?> validateBusinessDetailsFields() {
  //   final b = businessDetails.value;
  //   return {
  //     'businessName': validateBusinessName(b.businessName),
  //     'businessType': validateBusinessType(b.businessType),
  //     'gst': (b.gst != null && b.gst!.isNotEmpty) ? validateGst(b.gst) : null,
  //     'fssaiCertificatePath': validateFssaiCertificatePath(b.fssaiCertificatePath),
  //   };
  // }

  // Returns true if all required fields are valid
  // bool get isBusinessDetailsFormValid {
  //   final errors = validateBusinessDetailsFields();
  //   return errors.values.every((e) => e == null);
  // }

  // Returns a map of field errors for business details
  Map<String, String?> get businessDetailsFieldErrors {
    final b = businessDetails.value;
    return {
      'businessName': validateBusinessName(b.businessName),
      'businessType': validateBusinessType(b.businessType),
      'gst': validateGst(b.gst),
      'fssaiCertificatePath': validateFssaiCertificatePath(
        b.fssaiCertificatePath,
      ),
    };
  }

  // Call this after picking a file for FSSAI certificate
  void setFssaiCertificateFile(File file) {
    fssaiCertificateFile.value = file;
    businessDetails.update((b) {
      if (b != null) b.fssaiCertificatePath = file.path;
    });
    update();
  }

  // Call this after picking a file for contract document
  void setContractDocumentFile(File file) {
    contractDocumentFile.value = file;
    businessDetails.update((b) {
      if (b != null) b.contractDocumentPath = file.path;
    });
    update();
  }
}
