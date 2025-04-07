import '../../domain/entities/term_and_conditions.dart';

class TermAndConditionsModel extends TermAndConditions {
  TermAndConditionsModel({
    required String title,
    required String content,
    required String version,
    required DateTime lastUpdated,
  }) : super(
          title: title,
          content: content,
          version: version,
          lastUpdated: lastUpdated,
        );

  factory TermAndConditionsModel.fromJson(Map<String, dynamic> json) {
    return TermAndConditionsModel(
      title: json['title'] ?? '',
      content: json['content'] ?? '',
      version: json['version'] ?? '1.0',
      lastUpdated: DateTime.tryParse(json['lastUpdated'] ?? '') ?? DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'content': content,
      'version': version,
      'lastUpdated': lastUpdated.toIso8601String(),
    };
  }
} 