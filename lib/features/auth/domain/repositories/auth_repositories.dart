import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../../../core/constante/failure.dart';
import '../entities/login.dart';
import '../entities/register.dart';

abstract class AuthRepositories {
  Future<Either<Failure, Map<String, dynamic>>> postLogin(Login login);
  Future<Either<Failure, Map<String, dynamic>>> postRegister(Register register);
  Future<Either<Failure, Map<String, dynamic>>> postLogout();
}
