import 'package:dio/dio.dart';
import 'package:logger/logger.dart';

import '../../../../core/api_helper/api_helper.dart';
import '../../../../core/constante/app_key.dart';
import '../../../../dependency_injection.dart';
import '../model/login_model.dart';
import '../model/register_model.dart';

abstract class RemoteDataSourceAuth {
  Future<Map<String, dynamic>> loginRemoteDataSource(LoginModel loginModel);
  Future<Map<String, dynamic>> registerRemoteDataSource(
      RegisterModel registerModel);
  Future<Map<String, dynamic>> logoutRemoteDataSource();
}

class RemoteDataSourceAuthImp implements RemoteDataSourceAuth {
  final Dio dio;
  final logger = Logger();

  RemoteDataSourceAuthImp({required this.dio});

  @override
  Future<Map<String, dynamic>> loginRemoteDataSource(
      LoginModel loginModel) async {
    try {
      final body = loginModel.toJson();
      logger.d('Login Request Body: $body');

      final response = await _postRequest(DataKey.login, body);
      logger.i('Login Response: $response');

      return response;
    } catch (e) {
      logger.e('Login Error: $e');
      rethrow;
    }
  }

  Future<Map<String, dynamic>> _postRequest(
      String endpoint, Map<String, dynamic> body) async {
    try {
      final response = await sl<ApiHelper>().requestApi(
        endpoint,
        ApiService.post,
        body: body,
      );



      return response;
    } catch (e) {
      logger.e('API Request Error: $e');
      rethrow;
    }
  }

  @override
  Future<Map<String, dynamic>> registerRemoteDataSource(
      RegisterModel registerModel) async {
    try {
      final body = registerModel.toJson();
      logger.d('Register Request Body: $body');

      final response = await _postRequest(DataKey.register, body);
      logger.i('Register Response: $response');

      return response;
    } catch (e) {
      logger.e('Register Error: $e');
      rethrow;
    }
  }

  @override
  Future<Map<String, dynamic>> logoutRemoteDataSource() async {
    try {
      logger.d('Logout Request');

      final response = await _postRequest(DataKey.logout, {});
      logger.i('Logout Response: $response');

      return response;
    } catch (e) {
      logger.e('Logout Error: $e');
      rethrow;
    }
  }
}
