import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import 'package:techpeak/features/complaints/data_source/model/complaints_model.dart';
import '../../../../core/api_helper/api_helper.dart';
import '../../../../core/constante/app_key.dart';
import '../../../../dependency_injection.dart';
import '../../domain/entities/complaints.dart';

abstract class RemoteDataSourceComplaints {
  Future<Map<String, dynamic>> postComplaints(ComplaintsModel complaints);
}

class RemoteDataSourceComplaintsImp implements RemoteDataSourceComplaints {
  final Dio dio;
  final logger = Logger();

  RemoteDataSourceComplaintsImp({required this.dio});

  @override
  Future<Map<String, dynamic>> postComplaints(ComplaintsModel complaints) async {
    try {
      final complaintsModel = ComplaintsModel(
        title: complaints.title,
        description: complaints.description,
      );

      final body = complaintsModel.toJson();
      logger.d('Complaints Request Body: $body');

      final response = await sl<ApiHelper>().requestApi(
        DataKey.complaints,
        ApiService.post,
        body: body,
      );

      logger.i('Complaints Response: $response');
      return response;
    } catch (e) {
      logger.e('Complaints Error: $e');
      rethrow;
    }
  }
}
