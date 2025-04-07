import 'package:dartz/dartz.dart';
import 'package:techpeak/features/package/domain/repositories/package_repositories.dart';

import '../../../../core/constante/failure.dart';
import '../entities/package.dart';

class PackageUseCase {
  final PackageRepositories packageRepositories;

  PackageUseCase({required this.packageRepositories});
  Future<Either<Failure, List<Package>>> getPackages() async {
    return await packageRepositories.getPackages();
  }


}