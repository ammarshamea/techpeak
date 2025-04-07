import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../domain/repositories/splash_repository.dart';

part 'splash_state.dart';

class SplashCubit extends Cubit<SplashState> {
  final SplashRepository splashRepository;

  SplashCubit({required this.splashRepository}) : super(SplashInitial());

  Future<void> initSplash() async {
    try {
      await splashRepository.initializeApp();
      final isLoggedIn = await splashRepository.isUserLoggedIn();
      emit(SplashCompleted(isLoggedIn));
    } catch (e) {
      emit(SplashError(e.toString()));
    }
  }
} 