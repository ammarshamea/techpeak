import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:techpeak/core/constante/app_color.dart';
import 'package:techpeak/core/route/route_list.dart';

class RegisterBottom extends StatelessWidget {
  const RegisterBottom({super.key});

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        children: [
          const TextSpan(
            text: "هل لديك حساب؟   ",
            style: TextStyle(
              color: AppColors.blackColor,
              fontSize: 16,
            ),
          ),
          TextSpan(
            text: "تسجيل الدخول",
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                AppRouter.navigateAndReplace(context, AppRouter.login);
              },
            style: const TextStyle(
              decoration: TextDecoration.underline,
              color: AppColors.primaryColor,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
