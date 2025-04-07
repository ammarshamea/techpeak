import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';
import 'package:network_info_plus/network_info_plus.dart';
import 'package:techpeak/features/terms_and_conditions/presention/page/term_and_conditions_screen.dart';
import '../../../../../core/function/validator.dart';
import '../../../../../core/widgets/dialogs/loading_dialog_widget.dart';
import '../../../domain/entities/register.dart';

import '../../../../../core/app_size/app_size.dart';
import '../../../../../core/constante/app_color.dart';
import '../../../../../core/route/route_list.dart';
import '../../../../../core/widgets/app_widget/custom_button.dart';
import '../../../../../core/widgets/app_widget/text_field_custom.dart';
import '../../../domain/entities/login.dart';
import '../../bloc/auth_cubit.dart';

class RegisterBody extends StatelessWidget {
  final GlobalKey<FormState> form;
  final logger = Logger();

  RegisterBody({
    super.key,
    required this.form,
  });

  Future<String> getMacAddress() async {
    try {
      final info = NetworkInfo();
      final wifiBSSID = await info.getWifiBSSID();
      logger.d('MAC Address: $wifiBSSID');
      return wifiBSSID ?? 'unknown';
    } catch (e) {
      logger.e('Error getting MAC address: $e');
      return 'unknown';
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthLoading) {
          LoadingDialogWidget.show(context);
        } else {
          LoadingDialogWidget.hide(context);

          if (state is AuthSuccess) {
            Navigator.pushNamedAndRemoveUntil(
                context, AppRouter.terms, (route) => false);
          } else if (state is AuthError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: AppColors.redColor,
              ),
            );
          }
        }
      },
      builder: (context, state) {
        final bloc = BlocProvider.of<AuthCubit>(context);
        final isLoading = state is AuthLoading;

        return Column(
          children: [
            // حقل رقم الهاتف
            TextFieldCustom(
              validator: (value) => validateNotHaveValue(value, context),
              controller: bloc.phoneNumber,
              hintText: "رقم الموبايل",
              type: TextInputType.number,
              hintStyle: TextStyle(
                  color: AppColors.primaryColor,
                  fontWeight: FontWeight.w500,
                  fontSize: 16),
              obscureText: false,
            ),
            SizedBox(height: response(context, 85)),

            CustomLoadingButton(
              title: "انشاء حساب",
              isElevation: true,
              height: response(context, 47),
              width: width(context),
              onPressed: isLoading
                  ? null
                  : () async {
                      if (form.currentState!.validate()) {
                        final macAddress = await getMacAddress();
                        final phoneNum = bloc.phoneNumber.text;

                        logger.d('Phone Number: $phoneNum');
                        logger.d('MAC Address: $macAddress');

                        // Store the data in cubit
                        bloc.setRegistrationData(
                          phoneNumber: phoneNum,
                          macAddress: macAddress,
                        );

                        // Pass the current AuthCubit instance to the next screen
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => BlocProvider.value(
                              value: bloc,
                              child: const TermsAndConditionsScreen(),
                            ),
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
