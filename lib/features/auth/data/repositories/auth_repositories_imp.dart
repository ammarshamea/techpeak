import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import 'package:techpeak/core/function/network_connection.dart';

import 'package:techpeak/features/auth/domain/repositories/auth_repositories.dart';

import '../../../../core/constante/failure.dart';
import '../../../../core/sharedprefrence/shared_prefrence.dart';
import '../../domain/entities/login.dart';
import '../datasource/remote_data_source_auth.dart';
import '../model/login_model.dart';
import '../model/register_model.dart';
import '../../domain/entities/register.dart';

class AuthRepositoriesImp implements AuthRepositories {
  final RemoteDataSourceAuth remoteDataSourceAuth;
  final NetworkConnection networkConnection;
  final Logger logger = Logger();

  AuthRepositoriesImp(
      {required this.remoteDataSourceAuth,
      required this.networkConnection}); // ✅ Logger كمتغير عام

  @override
  Future<Either<Failure, Map<String, dynamic>>> postLogin(Login login) async {
    final LoginModel loginModel =
        LoginModel(username: login.username, password: login.password);
    return _postData(
        () => remoteDataSourceAuth.loginRemoteDataSource(loginModel));
  }

  Future<Either<Failure, Map<String, dynamic>>> _postData(
      Future<Map<String, dynamic>> Function() post) async {
    try {
      logger.w("🔄 بدء تنفيذ العملية");

      // التحقق من الاتصال بالإنترنت
      final isConnected = await networkConnection.isConnected;
      logger.d("🔍 حالة الشبكة: $isConnected");

      if (!isConnected) {
        logger.w("⚠️ لا يوجد اتصال بالإنترنت");
        return Left(OfflineFailure(message: OFFLINE_FAILURE_MESSAGE));
      }

      final result = await post();
      logger.i("✅ تم استلام الاستجابة: $result");
      return Right(result);
    } catch (e, stackTrace) {
      if (e is DioException) {
        logger.e("❌ خطأ في الشبكة", error: e, stackTrace: stackTrace);
        return Left(ServerFailure(message: "خطأ في الشبكة: ${e.message}"));
      }
      logger.e("❌ استثناء غير معروف", error: e, stackTrace: stackTrace);
      return Left(ServerFailure(message: "حدث خطأ: ${e.toString()}"));
    }
  }

  @override
  Future<Either<Failure, Map<String, dynamic>>> postRegister(
      Register register) {
    final RegisterModel registerModel = RegisterModel(
      username: register.username,
      macAddress: register.macAddress,
      terms: register.terms,
    );
    return _postData(
        () => remoteDataSourceAuth.registerRemoteDataSource(registerModel));
  }

  @override
  Future<Either<Failure, Map<String, dynamic>>> postLogout() async {
    return _postData(() => remoteDataSourceAuth.logoutRemoteDataSource());
  }
}
