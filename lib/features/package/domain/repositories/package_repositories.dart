import 'package:dartz/dartz.dart';
import 'package:techpeak/core/constante/failure.dart';
import 'package:techpeak/features/package/domain/entities/package.dart';

abstract class PackageRepositories {
  Future<Either<Failure, List<Package>>>getPackages();
}