import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constante/app_color.dart';
import '../cubit/terms_cubit.dart';

class AcceptTerms extends StatelessWidget {
  const AcceptTerms({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.transparent,
      onTap: () {
        bool value = context.read<TermsCubit>().isAccepted;
        context.read<TermsCubit>().isTermsAccepted(!value);
      },
      child: Row(
        children: [
          Checkbox(
            activeColor: AppColors.primaryColor,
            value: context.read<TermsCubit>().isAccepted,
            onChanged: (value) {
              print(value);
              if (value != null) {
                context.read<TermsCubit>().isTermsAccepted(value);
              }
            },
            fillColor: MaterialStateProperty.all(
              context.read<TermsCubit>().isAccepted
                  ? AppColors.primaryColor
                  : AppColors.whiteColor,
            ),
            side: BorderSide(color: AppColors.primaryColor),
          ),
          Text(
            "اوافق على الشروط والاحكام",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppColors.primaryColor,
            ),
          ),
        ],
      ),
    );
  }
}
