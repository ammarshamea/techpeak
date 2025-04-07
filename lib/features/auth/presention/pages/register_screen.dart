import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:techpeak/features/auth/presention/widget/login/login_bottom.dart';

import '../../../../core/app_size/app_size.dart';
import '../../../../core/constante/app_color.dart';
import '../../../../dependency_injection.dart';
import '../bloc/auth_cubit.dart';
import '../widget/login/login_body.dart';
import '../widget/auth_header.dart';
import '../widget/register/register_body.dart';
import '../widget/register/register_bottom.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({super.key});

  final GlobalKey<FormState> form = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<AuthCubit>(),
      child: Builder(
        builder: (context) {
          return Scaffold(
            backgroundColor: AppColors.whiteColor,
            body: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(response(context, 16)),
                child: Form(
                  key: form,
                  child: Column(
                    children: [
                      const AuthHeader(),
                      SizedBox(height: response(context, 50)),
                      RegisterBody(form: form),
                      SizedBox(height: response(context, 85)),
                      RegisterBottom(),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
