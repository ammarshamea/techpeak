import 'package:techpeak/core/constante/app_key.dart';

import '../../../../core/sharedprefrence/shared_prefrence.dart';
import '../../domain/repositories/splash_repository.dart';

class SplashRepositoryImpl implements SplashRepository {
  @override
  Future<bool> isUserLoggedIn() async {
    final myService=MyServices();

    final token=await     myService.sharedGet<String>( key: DataKey.token)!=null?true:false;
    await Future.delayed(const Duration(seconds: 2));
    return token;
  }

  @override
  Future<void> initializeApp() async {
    await Future.delayed(const Duration(seconds: 1));
  }
} 