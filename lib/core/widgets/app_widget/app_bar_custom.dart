import 'package:flutter/material.dart';

import '../../constante/app_color.dart';
import '../../route/route_list.dart';

class AppBarCustom extends StatelessWidget implements PreferredSizeWidget {
  final Widget title;
  final void Function()? onPressed;

  const AppBarCustom({super.key, required this.title, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      toolbarHeight: 100,
      centerTitle: true,
      backgroundColor: AppColors.primaryColor,
      leading: IconButton(
        icon: Icon(
          Icons.arrow_back_ios_new,
          size: 24,
          color: AppColors.whiteColor,
        ),
        onPressed: onPressed ?? () {
          AppRouter.goBack(context);
        },
      ),
      title: title,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(100);
}
