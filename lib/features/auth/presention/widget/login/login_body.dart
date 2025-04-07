import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:techpeak/core/function/validator.dart';
import 'package:techpeak/core/widgets/dialogs/loading_dialog_widget.dart';

import '../../../../../core/app_size/app_size.dart';
import '../../../../../core/constante/app_color.dart';
import '../../../../../core/route/route_list.dart';
import '../../../../../core/widgets/app_widget/custom_button.dart';
import '../../../../../core/widgets/app_widget/text_field_custom.dart';
import '../../../domain/entities/login.dart';
import '../../bloc/auth_cubit.dart';

class LoginBody extends StatelessWidget {
  final GlobalKey<FormState> form;

  const LoginBody({
    super.key,
    required this.form,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthSuccess) {
          Navigator.pushNamedAndRemoveUntil(
              context, AppRouter.homePage, (route) => false);
        } else if (state is AuthError) {
          LoadingDialogWidget();
        }
      },
      builder: (context, state) {
        final bloc = BlocProvider.of<AuthCubit>(context);
        final isLoading = state is AuthLoading;

        return Column(
          children: [
            // حقل رقم الهاتف
            TextFieldCustom(
              validator: (value) => validateEmail(value, context),
              controller: bloc.phoneNumber,
              hintText: "رقم الموبايل",
              type: TextInputType.emailAddress,
              hintStyle: TextStyle(
                  color: AppColors.primaryColor,
                  fontWeight: FontWeight.w500,
                  fontSize: 16),
              obscureText: false,
            ),
            SizedBox(height: response(context, 24)),

            // حقل كلمة المرور
            TextFieldCustom(
              // validator: (value) => validatePassword(value, context),
              controller: bloc.password,
              hintText: "كلمة المرور",
              hintStyle: TextStyle(
                  color: AppColors.primaryColor,
                  fontWeight: FontWeight.w500,
                  fontSize: 16),
              obscureText: true,
              type: TextInputType.text,
            ),
            SizedBox(height: response(context, 61)),

            CustomLoadingButton(
              isElevation: true,
              title: "تسجيل الدخول",
              height: response(context, 47),
              width: width(context),
              vertical: response(context, 10),
              onPressed: isLoading
                  ? null
                  : () {
                      if (form.currentState!.validate()) {
                        // تحويل الرقم إلى إنجليزي

                        final login = Login(
                          password: bloc.password.text,
                          username: bloc.phoneNumber.text,
                        );
                        context.read<AuthCubit>().login(login);
                        // Navigator.pushNamedAndRemoveUntil(
                        //     context, AppRouter.homePage, (route) => false);
                        // bloc.login(login);
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text("الرجاء اكمال الحقول"),
                            backgroundColor: AppColors.redColor,
                          ),
                        );
                      }
                    },
              borderRadius: response(context, 20),
              colorButton:
                  isLoading ? AppColors.greyColor : AppColors.primaryColor,
              colorText: AppColors.whiteColor,
              isLoading: isLoading,
              colorLoader: AppColors.primaryColor,
            ),
          ],
        );
      },
    );
  }
}
