import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:techpeak/core/api_helper/api_helper.dart';
import 'package:techpeak/core/function/network_connection.dart';
import 'package:techpeak/core/sharedprefrence/shared_prefrence.dart';
import 'package:techpeak/features/auth/data/datasource/remote_data_source_auth.dart';
import 'package:techpeak/features/auth/data/repositories/auth_repositories_imp.dart';
import 'package:techpeak/features/auth/domain/repositories/auth_repositories.dart';
import 'package:techpeak/features/auth/domain/usecase/auth_use_case.dart';
import 'package:techpeak/features/auth/presention/bloc/auth_cubit.dart';
import 'package:techpeak/features/splash/data/repositories/splash_repository_impl.dart';
import 'package:techpeak/features/splash/domain/repositories/splash_repository.dart';
import 'package:techpeak/features/splash/presentation/cubit/splash_cubit.dart';
import 'package:techpeak/features/terms_and_conditions/data/datasources/local_terms_data_source.dart';
import 'package:techpeak/features/terms_and_conditions/data/datasources/remote_terms_data_source.dart';
import 'package:techpeak/features/terms_and_conditions/domain/usecase/terms_use_case.dart';

import 'features/complaints/data_source/repositories/complaints_repositories_imp.dart';
import 'features/terms_and_conditions/data/repositories/terms_repositories_impl.dart';
import 'features/terms_and_conditions/domain/repositories/terms_repositories.dart';
import 'features/terms_and_conditions/presention/cubit/terms_cubit.dart';
import 'package:techpeak/features/complaints/data_source/data/remote_data_source_complaints.dart';
import 'package:techpeak/features/complaints/domain/repositories/complaints_repositories.dart';
import 'package:techpeak/features/complaints/domain/use_case/complaints_use_case.dart';
import 'package:techpeak/features/complaints/presentation/cubit/complaints_cubit.dart';
import 'package:techpeak/features/package/data_source/data/remote_data_source_package.dart';
import 'package:techpeak/features/package/data_source/repositories/package_repositories_imp.dart';
import 'package:techpeak/features/package/domain/repositories/package_repositories.dart';
import 'package:techpeak/features/package/domain/usecase/package_use_case.dart';
import 'package:techpeak/features/package/presentation/cubit/package_cubit.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // Core
  sl.registerLazySingleton<Dio>(() => Dio());
  sl.registerLazySingleton<InternetConnectionChecker>(
    () => InternetConnectionChecker.createInstance(),
  );
  sl.registerLazySingleton<MyServices>(() => MyServices());
  sl.registerSingleton<ApiHelper>(ApiHelper());
  sl.registerLazySingleton<NetworkConnection>(
    () => NetworkConnectionImp(internetConnectionChecker: sl()),
  );

  // Data Sources
  sl.registerLazySingleton<RemoteDataSourceAuth>(
    () => RemoteDataSourceAuthImp(dio: sl()),
  );
  sl.registerLazySingleton<LocalTermsDataSource>(
    () => LocalTermsDataSource(sl()),
  );
  sl.registerLazySingleton<RemoteTermsDataSource>(
    () => RemoteTermsDataSource(sl()),
  );
  sl.registerLazySingleton<RemoteDataSourceComplaints>(
    () => RemoteDataSourceComplaintsImp(dio: sl()),
  );
  sl.registerLazySingleton<RemoteDataSourcePackage>(
    () => RemoteDataSourcePackageImpl(dio: sl()),
  );

  // Repositories
  sl.registerLazySingleton<AuthRepositories>(() => AuthRepositoriesImp(
        networkConnection: sl(),
        remoteDataSourceAuth: sl(),
      ));
  sl.registerLazySingleton<SplashRepository>(() => SplashRepositoryImpl());
  sl.registerLazySingleton<TermsRepositories>(
    () => TermsRepositoriesImpl(
      localDataSource: sl(),
      remoteDataSource: sl(),
      networkConnection: sl(),
    ),
  );
  sl.registerLazySingleton<ComplaintsRepositories>(
    () => ComplaintsRepositoriesImp(
      remoteDataSource: sl(),
      networkConnection: sl(),
    ),
  );
  sl.registerLazySingleton<PackageRepositories>(
    () => PackageRepositoriesImp(
      packageRemoteDataSource: sl(),
      networkConnection: sl(),
    ),
  );

  // Use Cases
  sl.registerLazySingleton<AuthUseCase>(() => AuthUseCase(sl()));
  sl.registerLazySingleton<TermsUseCase>(
    () => TermsUseCase(sl()),
  );
  sl.registerLazySingleton<ComplaintsUseCase>(
    () => ComplaintsUseCase(complaintsRepositories: sl()),
  );
  sl.registerLazySingleton<PackageUseCase>(
    () => PackageUseCase(packageRepositories: sl()),
  );

  // Blocs/Cubits
  sl.registerFactory<AuthCubit>(() => AuthCubit(authUseCase: sl()));
  sl.registerFactory<SplashCubit>(() => SplashCubit(splashRepository: sl()));
  sl.registerFactory<TermsCubit>(
    () => TermsCubit(termsUseCase: sl()),
  );
  sl.registerFactory<ComplaintsCubit>(
    () => ComplaintsCubit(complaintsUseCase: sl()),
  );
  sl.registerFactory<PackageCubit>(
    () => PackageCubit(packageUseCase: sl()),
  );

  // Initialize SharedPreferences
  await MyServices.init();
}
