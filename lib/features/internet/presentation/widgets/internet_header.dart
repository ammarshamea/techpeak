import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_multi_type/image_multi_type.dart';
import 'package:techpeak/core/route/route_list.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:techpeak/core/widgets/dialogs/loading_dialog_widget.dart';
import '../../../../core/widgets/dialogs/logout_dialog.dart';
import '../../../auth/presention/bloc/auth_cubit.dart';

import '../../../../core/app_size/app_size.dart';
import '../../../../core/constante/app_color.dart';
import '../../../../core/constante/app_image.dart';

class InternetHeader extends StatelessWidget {
  const InternetHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Text(
              "باقات الانترنت",
              style: TextStyle(
                  color: AppColors.primaryColor,
                  fontWeight: FontWeight.bold,
                  fontSize: response(context, 30)),
            ),
            const Spacer(),
            BlocListener<AuthCubit, AuthState>(
              listener: (context, state) {
                if (state is AuthLoading) {
                  LoadingDialogWidget.show(context);
                } else {
                  LoadingDialogWidget.hide(context);
                  if (state is AuthSuccess) {
                    AppRouter.navigateTo(context, AppRouter.login);
                  } else if (state is AuthError) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(state.message)),
                    );
                  }
                }
              },
              child: InkWell(
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                onTap: () async {
                  final shouldLogout = await LogoutDialog.show(context);
                  if (shouldLogout == true && context.mounted) {
                    context.read<AuthCubit>().logout();
                  }
                },
                child: Container(
                  width: response(context, 32),
                  height: response(context, 32),
                  padding: EdgeInsets.all(response(context, 8)),
                  child: ImageMultiType(
                    url: AppImages.logout,
                    color: AppColors.greyColor,
                    width: response(context, 16),
                    height: response(context, 16),
                  ),
                ),
              ),
            ),
            SizedBox(
              width: response(context, 12),
            ),
            InkWell(
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              onTap: () =>
                  AppRouter.navigateTo(context, AppRouter.notification),
              child: Container(
                width: response(context, 32),
                height: response(context, 32),
                padding: EdgeInsets.all(response(context, 8)),
                child: ImageMultiType(
                  url: AppImages.notification,
                  color: AppColors.greyColor,
                  width: response(context, 16),
                  height: response(context, 16),
                ),
              ),
            ),
          ],
        ),
        SizedBox(
          height: response(context, 8),
        ),
        Divider(color: AppColors.greyColor.withOpacity(0.3)),
      ],
    );
  }
}
