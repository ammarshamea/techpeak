import 'dart:io';
import 'package:dio/dio.dart';

import '../constante/app_key.dart';
import '../sharedprefrence/shared_prefrence.dart';

enum ApiService { get, post, delete, put, patch }

class ApiHelper {
  final Map<String, dynamic>? queryParameters;
  final FormData? formData;

  ApiHelper({this.queryParameters, this.formData});

  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: DataKey.baseUrl,
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
      receiveDataWhenStatusError: true,
      validateStatus: (status) => status != null && status < 500,
    ),
  );

  Future<Map<String, String>> _getHeaders() async {
    final myService = MyServices();
    final token = await myService.sharedGet<String>(key: DataKey.token);
    return {
      'Accept': 'application/json',
      if (formData != null) 'Content-Type': 'multipart/form-data',
      if (token != null) 'Authorization': 'Bearer $token',
    };
  }

  Future<Map<String, dynamic>> requestApi(
      String endpoint, ApiService serviceType,
      {Map<String, dynamic>? body}) async {
    try {
      _dio.options.headers = await _getHeaders();
      Response response;

      switch (serviceType) {
        case ApiService.get:
          response = await _dio.get(endpoint, queryParameters: queryParameters);
          break;
        case ApiService.post:
          response = await _dio.post(endpoint, data: formData ?? body);
          break;
        case ApiService.put:
          response = await _dio.put(endpoint, data: formData ?? body);
          break;
        case ApiService.patch:
          response = await _dio.patch(endpoint, data: formData ?? body);
          break;
        case ApiService.delete:
          response = await _dio.delete(endpoint);
          break;
      }
      return _handleResponse(response);
    } catch (e) {
      print('❌ API Request Error: $e');
      return {'error': 'Request failed', 'message': e.toString()};
    }
  }

  static Future<Map<String, dynamic>> uploadFile({
    required String endpoint,
    required File file,
    String fieldName = 'image',
    Map<String, dynamic>? extraFields,
  }) async {
    try {
      final fileName = file.path.split('/').last;
      FormData formData = FormData.fromMap({
        fieldName: await MultipartFile.fromFile(file.path, filename: fileName),
        if (extraFields != null) ...extraFields,
      });
      final helper = ApiHelper(formData: formData);
      return await helper.requestApi(endpoint, ApiService.post);
    } catch (e) {
      print('❌ Error uploading file: $e');
      return {'error': 'File upload failed', 'message': e.toString()};
    }
  }

  Map<String, dynamic> _handleResponse(Response response) {
    final status = response.statusCode ?? 0;
    if (status >= 200 && status < 300) {
      print('✅ Success: ${response.data}');
      return response.data is Map<String, dynamic>
          ? response.data
          : {'data': response.data};
    } else {
      print('❌ Error $status: ${response.data}');
      return response.data is Map<String, dynamic>
          ? response.data
          : {'data': response.data};
      ;
    }
  }
}
