import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import 'package:techpeak/features/complaints/data_source/model/complaints_model.dart';
import '../../../../core/constante/failure.dart';
import '../../../../core/function/network_connection.dart';
import '../../data_source/data/remote_data_source_complaints.dart';
import '../../domain/entities/complaints.dart';
import '../../domain/repositories/complaints_repositories.dart';

class ComplaintsRepositoriesImp implements ComplaintsRepositories {
  final RemoteDataSourceComplaints remoteDataSource;
  final NetworkConnection networkConnection;
  final logger = Logger();

  ComplaintsRepositoriesImp({
    required this.remoteDataSource,
    required this.networkConnection,
  });

  @override
  Future<Either<Failure, Map<String, dynamic>>> postComplaints(
      Complaints complaints) async {
    ComplaintsModel complaintsModel = ComplaintsModel(
        title: complaints.title, description: complaints.description);
    try {
      final isConnected = await networkConnection.isConnected;
      if (!isConnected) {
        return Left(OfflineFailure(message: OFFLINE_FAILURE_MESSAGE));
      }

      final response = await remoteDataSource.postComplaints(complaintsModel);
      return Right(response);
    } catch (e) {
      logger.e('Complaints Repository Error: $e');
      if (e is DioException) {
        return Left(ServerFailure(message: e.message ?? 'Server Error'));
      }
      return Left(ServerFailure(message: e.toString()));
    }
  }
}
