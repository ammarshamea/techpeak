part of 'auth_cubit.dart';

@immutable
sealed class AuthState {}

final class AuthInitial extends AuthState {}
final class AuthSuccess extends AuthState {
  final String message;

  AuthSuccess({required this.message});
}
final class AuthLoading extends AuthState {}
final class AuthError extends AuthState {
  final String message;

  AuthError({required this.message});
}
