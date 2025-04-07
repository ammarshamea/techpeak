import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:techpeak/core/constante/app_color.dart';

import '../../../../../core/route/route_list.dart';

class LoginBottom extends StatelessWidget {
  const LoginBottom({super.key});

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
              text: "ليس لديك حساب؟   ",
              style: TextStyle(
                color: AppColors.blackColor,
                fontSize: 16,
              )),
          TextSpan(
              text: "انشاء حساب جديد",
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  AppRouter.navigateAndReplace(context,AppRouter.signup );
                },
              style: TextStyle(
                  decoration: TextDecoration.underline,
                  color: AppColors.primaryColor,
                  fontSize: 18,
                  fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}
