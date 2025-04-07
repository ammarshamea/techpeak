import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_multi_type/image_multi_type.dart';

import '../../../../core/app_size/app_size.dart';
import '../../../../core/constante/app_color.dart';
import '../../../../core/constante/app_image.dart';

class ComplainHeader extends StatelessWidget {
  const ComplainHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "الشكوى",
          style: TextStyle(
              color: AppColors.primaryColor,
              fontWeight: FontWeight.bold,
              fontSize: 30),
        ),
        SizedBox(
          height: response(context, 8),
        ),
        Divider(color: AppColors.greyColor.withOpacity(0.3)),
      ],
    );
  }
}
