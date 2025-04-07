import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import 'package:techpeak/core/api_helper/api_helper.dart';
import 'package:techpeak/core/constante/app_key.dart';
import 'package:techpeak/features/package/data_source/model/package_model.dart';
import 'package:techpeak/features/package/domain/entities/package.dart';

import '../../../../dependency_injection.dart';

abstract class RemoteDataSourcePackage {
  Future<List<PackagesModel>> getRemotePackage();
}

class RemoteDataSourcePackageImpl implements RemoteDataSourcePackage {
  final Dio dio;

  RemoteDataSourcePackageImpl({required this.dio});

  @override
  Future<List<PackagesModel>> getRemotePackage() async {
    try {
      final response =
          await sl<ApiHelper>().requestApi(DataKey.packages, ApiService.get);

      if (response["status"] == 200) {
        final List<dynamic> data = response["data"];
        return data
            .map<PackagesModel>((e) => PackagesModel.fromJson(e))
            .toList();
      } else {
        Logger().e("Error fetching packages: ${response["message"]}");
        return [];
      }
    } catch (e) {
      Logger().e("Exception in getRemotePackage: $e");
      return [];
    }
  }
}
