class DeliverySetupRequest {
  final String city;
  final List<String> areas;

  DeliverySetupRequest({required this.city, required this.areas});

  Map<String, dynamic> toJson() {
    return {'city': city, 'workingArea': areas};
  }
}
