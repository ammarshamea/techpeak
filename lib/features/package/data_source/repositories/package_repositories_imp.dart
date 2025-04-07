import 'package:dartz/dartz.dart';
import 'package:techpeak/core/constante/failure.dart';
import 'package:techpeak/core/function/network_connection.dart';
import 'package:techpeak/features/package/data_source/data/remote_data_source_package.dart';
import 'package:techpeak/features/package/domain/entities/package.dart';
import 'package:techpeak/features/package/domain/repositories/package_repositories.dart';

class PackageRepositoriesImp extends PackageRepositories {
  final RemoteDataSourcePackage packageRemoteDataSource;
  final NetworkConnection networkConnection;

  PackageRepositoriesImp(
      {required this.packageRemoteDataSource, required this.networkConnection});

  @override
  Future<Either<Failure, List<Package>>> getPackages() async {
    if (await networkConnection.isConnected) {
      try {
        final res = await packageRemoteDataSource.getRemotePackage();
        return Right(res);
      } catch (e) {
        return Left(OfflineFailure(message: OFFLINE_FAILURE_MESSAGE));
      }
    } else {
      return Left(ServerFailure(message: SERVER_FAILURE_MESSAGE));
    }
  }
}
