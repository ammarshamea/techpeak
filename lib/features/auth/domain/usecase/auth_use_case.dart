
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../../../core/constante/failure.dart';
import '../entities/login.dart';
import '../entities/register.dart';
import '../repositories/auth_repositories.dart';

class AuthUseCase {
  final AuthRepositories authRepositories;

  AuthUseCase(this.authRepositories);

  Future<Either<Failure, Map<String, dynamic>>> callLogin(Login login) async {
    print("usecase Login");
    return await authRepositories.postLogin(login);
  }

  Future<Either<Failure, Map<String, dynamic>>> callRegister(
      Register register) async {
    return await authRepositories.postRegister(register);
  } Future<Either<Failure, Map<String, dynamic>>> callLogout(
      ) async {
    return await authRepositories.postLogout();
  }
}
