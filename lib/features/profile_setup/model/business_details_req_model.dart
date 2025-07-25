import 'package:dio/dio.dart';

class BusinessDetailRequest {
  final String name;
  final String? email;
  final String businessName;
  final String businessType;
  final String? gst;
  final String? fssaiCertificatePath;
  final String? contractDocumentPath;

  BusinessDetailRequest({
    required this.name,
    this.email,
    required this.businessName,
    required this.businessType,
    this.gst,
    this.fssaiCertificatePath,
    this.contractDocumentPath,
  });

  Map<String, String> toJson() {
    // For non-file fields (for JSON body or multipart fields)
    final data = <String, String>{
      'name': name,
      'email': email ?? '',
      'businessName': businessName,
      'businessType': businessType,
    };
    if (gst != null && gst!.isNotEmpty) {
      data['gst'] = gst!;
    }
    if (fssaiCertificatePath != null && fssaiCertificatePath!.isNotEmpty) {
      data['fssaiCertificate'] = fssaiCertificatePath!;
    }
    if (contractDocumentPath != null && contractDocumentPath!.isNotEmpty) {
      data['contractDocument'] = contractDocumentPath!;
    }
    return data;
  }

  Map<String, dynamic> toFormDataMap() {
    final data = <String, dynamic>{
      'businessName': businessName,
      'businessType': businessType,
    };
    if (gst != null && gst!.isNotEmpty) {
      data['gst'] = gst!;
    }
    if (name.isNotEmpty) {
      data['name'] = name;
    }
    if (email != null && email!.isNotEmpty) {
      data['email'] = email;
    }
    if (fssaiCertificatePath != null && fssaiCertificatePath!.isNotEmpty) {
      data['fssaiCertificate'] = MultipartFile.fromFileSync(
        fssaiCertificatePath!,
      );
    }
    if (contractDocumentPath != null && contractDocumentPath!.isNotEmpty) {
      data['contractDocument'] = MultipartFile.fromFileSync(
        contractDocumentPath!,
      );
    }
    return data;
  }

  // For multipart requests, you will need to handle file fields separately
}
