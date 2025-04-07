import 'package:flutter/material.dart';
import 'package:techpeak/core/constante/app_image.dart';

import '../../../../core/app_size/app_size.dart';
import '../../../../core/widgets/app_widget/logo.dart';

class AuthHeader extends StatelessWidget {
  const AuthHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Logo(Image: AppImages.logo2,);
  }
}