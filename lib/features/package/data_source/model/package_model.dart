import '../../domain/entities/package.dart';

class PackagesModel extends Package {
  const PackagesModel(
      {required super.id,
      required super.name,
      required super.limitGb,
      required super.usageGb,
      required super.remainingGb,
      required super.usagePercentage,
      required super.startDate,
      required super.endDate,
      required super.status,
      required super.hasExceededLimit});

  factory PackagesModel.fromJson(Map<String, dynamic> json) {
    return PackagesModel(
        id: json['id'],
        name: json['name'],
        limitGb: (json['limit_gb'] as num).toDouble(),
        usageGb: (json['usage_gb'] as num).toDouble(),
        remainingGb: (json['remaining_gb'] as num).toDouble(),
        usagePercentage: json['usage_percentage'],
        startDate: json['start_date'],
        endDate: json['end_date'],
        status: json['status'],
        hasExceededLimit: json['has_exceeded_limit']);
  }

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "limit_gb": limitGb,
      "usage_gb": usageGb,
      "remaining_gb": remainingGb,
      "usage_percentage": usagePercentage,
      "start_date": startDate,
      "end_date": endDate,
      "status": status,
      "has_exceeded_limit": hasExceededLimit
    };
  }
}
