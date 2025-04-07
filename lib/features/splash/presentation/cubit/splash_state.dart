part of 'splash_cubit.dart';

abstract class SplashState extends Equatable {
  const SplashState();

  @override
  List<Object> get props => [];
}

class SplashInitial extends SplashState {}

class SplashCompleted extends SplashState {
  final bool isLoggedIn;

  const SplashCompleted(this.isLoggedIn);

  @override
  List<Object> get props => [isLoggedIn];
}

class SplashError extends SplashState {
  final String message;

  const SplashError(this.message);

  @override
  List<Object> get props => [message];
} 