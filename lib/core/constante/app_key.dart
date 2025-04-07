import '../sharedprefrence/shared_prefrence.dart';

class DataKey {
  // الأساسيات
  static const String baseUrl = "http://192.168.1.218:8080/";
  static const String api = "api";
  static const String register = "$api/radius/register";
  static const String login = "$api/radius/login";
  static const String logout = "$api/radius/logout";
  static const String complaints  = "$api/radius/complaints";
  static const String token = "token";
  static const String termsAndConditions = "$api/terms-and-conditions";
  static const String packages = "$api/radius/my-packages";
}
