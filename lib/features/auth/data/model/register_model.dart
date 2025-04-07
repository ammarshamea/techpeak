import '../../domain/entities/register.dart';

class RegisterModel extends Register {
  const RegisterModel({
    required super.username,
    required super.macAddress,
    required super.terms,
  });

  factory RegisterModel.fromJson(Map<String, dynamic> json) {
    return RegisterModel(
      username: json["username"],
      macAddress: json["mac_address"],
      terms: json["terms"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "username": username,
      "mac_address": macAddress,
      "terms": terms,
    };
  }
}
