class BusinessDetailsModel {
  String name;
  String? email;
  String businessName;
  String businessType;
  String? gst;
  String fssaiCertificatePath;
  String contractDocumentPath;

  BusinessDetailsModel({
    required this.name,
    this.email,
    required this.businessName,
    required this.businessType,
    this.gst,
    required this.fssaiCertificatePath,
    required this.contractDocumentPath,
  });
}
