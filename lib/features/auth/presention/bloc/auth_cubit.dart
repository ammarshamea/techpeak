import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';
import 'package:techpeak/core/sharedprefrence/shared_prefrence.dart';
import 'package:techpeak/features/auth/domain/entities/register.dart';
import 'package:techpeak/features/auth/domain/repositories/auth_repositories.dart';
import 'package:techpeak/features/auth/domain/usecase/auth_use_case.dart';
import 'package:logger/logger.dart';

import '../../domain/entities/login.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthUseCase authUseCase;
  final logger = Logger();

  // Controllers
  TextEditingController phoneNumber = TextEditingController();
  TextEditingController password = TextEditingController();

  // Registration data storage
  String? _storedPhoneNumber;
  String? _storedMacAddress;

  AuthCubit({required this.authUseCase}) : super(AuthInitial());

  void setRegistrationData({
    required String phoneNumber,
    required String macAddress,
  }) {
    logger.d('Storing registration data:');
    logger.d('Phone: $phoneNumber');
    logger.d('MAC: $macAddress');

    _storedPhoneNumber = phoneNumber;
    _storedMacAddress = macAddress;
  }

  Future<void> completeRegistration({required bool acceptTerms}) async {
    logger.d('Completing registration with:');
    logger.d('Phone: $_storedPhoneNumber');
    logger.d('MAC: $_storedMacAddress');
    logger.d('Terms: $acceptTerms');

    if (_storedPhoneNumber == null || _storedMacAddress == null) {
      emit(AuthError(message: 'بيانات التسجيل غير مكتملة'));
      return;
    }

    emit(AuthLoading());

    final register = Register(
      username: _storedPhoneNumber!,
      macAddress: _storedMacAddress!,
      terms: acceptTerms,
    );

    final result = await authUseCase.callRegister(register);

    result.fold(
      (failure) => emit(AuthError(message: failure.toString())),
      (success) {
        if (success["status"] >= 200 && success["status"] < 300) {
          final message = success["message"];
          emit(AuthSuccess(message: message));
        } else {
          final message = success["message"];
          emit(AuthError(message: message));
        }
      },
    );
  }

  @override
  Future<void> close() {
    phoneNumber.dispose();
    return super.close();
  }

  Future<void> login(Login login) async {
    emit(AuthLoading());
    final fields = await authUseCase.callLogin(login);
    fields.fold(
          (failure) => emit(AuthError(message: failure.toString())),
          (success) {
            print(success["status"]);
        if (success["status"] >= 200 && success["status"] < 300) {
          final message = success["message"];
          final token = success["data"]["token"];
MyServices.setToken(tokenValue: token);
          emit(AuthSuccess(message: message));
        } else {
          emit(AuthError(
              message: success["message"] ?? 'حدث خطأ أثناء تسجيل الخروج'));
        }
      },
    );
  }

  Future<void> logout() async {
    emit(AuthLoading());

    final result = await authUseCase.callLogout();

    result.fold(
      (failure) => emit(AuthError(message: failure.toString())),
      (success) {
        if (success["status"] >= 200 && success["status"] < 300) {
          final message = success["message"];
MyServices.removeToken();
          emit(AuthSuccess(message: message));
        } else {
          emit(AuthError(
              message: success["message"] ?? 'حدث خطأ أثناء تسجيل الخروج'));
        }
      },
    );
  }
}
