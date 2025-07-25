class DeliverySetupModel {
  String city;
  List<String> areas;

  DeliverySetupModel({required this.city, List<String>? areas})
    : areas = areas ?? [];
}
