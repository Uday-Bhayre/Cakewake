class EarningStatResponse {
  final bool success;
  final EarningStatData data;

  EarningStatResponse({required this.success, required this.data});

  factory EarningStatResponse.fromJson(Map<String, dynamic> json) {
    return EarningStatResponse(
      success: json['success'] ?? false,
      data: EarningStatData.fromJson(json['data'] ?? {}),
    );
  }
}

class EarningStatData {
  final EarningStatToday today;
  final EarningStatWeekly weekly;
  final EarningStatTotal total;

  EarningStatData({
    required this.today,
    required this.weekly,
    required this.total,
  });

  factory EarningStatData.fromJson(Map<String, dynamic> json) {
    return EarningStatData(
      today: EarningStatToday.fromJson(json['today'] ?? {}),
      weekly: EarningStatWeekly.fromJson(json['weekly'] ?? {}),
      total: EarningStatTotal.fromJson(json['total'] ?? {}),
    );
  }
}

class EarningStatToday {
  final int orders;
  final double earning;

  EarningStatToday({required this.orders, required this.earning});

  factory EarningStatToday.fromJson(Map<String, dynamic> json) {
    return EarningStatToday(
      orders: json['orders'] ?? 0,
      earning: (json['earning'] ?? 0).toDouble(),
    );
  }
}

class EarningStatWeekly {
  final int orders;
  final double earning;
  final WeekRange weekRange;

  EarningStatWeekly({
    required this.orders,
    required this.earning,
    required this.weekRange,
  });

  factory EarningStatWeekly.fromJson(Map<String, dynamic> json) {
    return EarningStatWeekly(
      orders: json['orders'] ?? 0,
      earning: (json['earning'] ?? 0).toDouble(),
      weekRange: WeekRange.fromJson(json['weekRange'] ?? {}),
    );
  }
}

class WeekRange {
  final String startDate;
  final String endDate;

  WeekRange({required this.startDate, required this.endDate});

  factory WeekRange.fromJson(Map<String, dynamic> json) {
    return WeekRange(
      startDate: json['startDate'] ?? '',
      endDate: json['endDate'] ?? '',
    );
  }
}

class EarningStatTotal {
  final int deliveries;
  final double earning;

  EarningStatTotal({required this.deliveries, required this.earning});

  factory EarningStatTotal.fromJson(Map<String, dynamic> json) {
    return EarningStatTotal(
      deliveries: json['deliveries'] ?? 0,
      earning: (json['earning'] ?? 0).toDouble(),
    );
  }
}
