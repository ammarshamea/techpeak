import 'package:equatable/equatable.dart';

class Package extends Equatable {
  final int id;
  final String name;
  final double limitGb;
  final double usageGb;
  final double remainingGb;
  final String usagePercentage;
  final String startDate;
  final String endDate;
  final String status;
  final bool hasExceededLimit;

  const Package({
    required this.id,
    required this.name,
    required this.limitGb,
    required this.usageGb,
    required this.remainingGb,
    required this.usagePercentage,
    required this.startDate,
    required this.endDate,
    required this.status,
    required this.hasExceededLimit,
  });

  factory Package.fromJson(Map<String, dynamic> json) {
    return Package(
      id: json['id'],
      name: json['name'],
      limitGb: (json['limit_gb'] as num).toDouble(),
      usageGb: (json['usage_gb'] as num).toDouble(),
      remainingGb: (json['remaining_gb'] as num).toDouble(),
      usagePercentage: json['usage_percentage'],
      startDate: json['start_date'],
      endDate: json['end_date'],
      status: json['status'],
      hasExceededLimit: json['has_exceeded_limit'],
    );
  }

  @override
  List<Object?> get props => [
    id,
    name,
    limitGb,
    usageGb,
    remainingGb,
    usagePercentage,
    startDate,
    endDate,
    status,
    hasExceededLimit,
  ];
}
