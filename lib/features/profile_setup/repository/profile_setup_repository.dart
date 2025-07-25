import 'package:cakewake_vendor/core/services/api_service.dart';
import 'package:cakewake_vendor/features/profile_setup/model/delivery_setup_req_model.dart';
import 'package:cakewake_vendor/features/profile_setup/model/payment_setup_req_model.dart';
import 'package:dio/dio.dart';
import '../model/business_details_req_model.dart';
import '../model/business_details_res_model.dart';
import '../model/delivery_setup_res_model.dart';
import '../model/payment_setup_res_model.dart';

class ProfileSetupRepository {
  final ApiService _api = ApiService();

  Future<BusinessDetailsResponse> submitBusinessDetails(
    BusinessDetailRequest req,
  ) async {
    final formData = FormData.fromMap(req.toJson());
    if (req.fssaiCertificatePath != null) {
      formData.files.add(
        MapEntry(
          'fssaiCertificate',
          await MultipartFile.fromFile(req.fssaiCertificatePath!),
        ),
      );
    }
    if (req.contractDocumentPath != null) {
      formData.files.add(
        MapEntry(
          'contractDocument',
          await MultipartFile.fromFile(req.contractDocumentPath!),
        ),
      );
    }
    final response = await _api.post('/business-detail', data: formData);
    print('Business details response: ${response.data}');
    return BusinessDetailsResponse.fromJson(response.data);
  }

  Future<DeliverySetupResponse> submitDeliverySetup(
    DeliverySetupRequest req,
  ) async {
    final response = await _api.post('/delivery-setup', data: req.toJson());
    print('Delivery setup response: ${response.data}');
    return DeliverySetupResponse.fromJson(response.data);
  }

  Future<PaymentSetupResponse> submitPaymentSetup(
    PaymentSetupRequest req,
  ) async {
    final response = await _api.post('/payment-details', data: req.toJson());
    return PaymentSetupResponse.fromJson(response.data);
  }
}
