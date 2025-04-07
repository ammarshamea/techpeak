import 'package:flutter/material.dart';
import 'package:image_multi_type/image_multi_type.dart';
import 'package:techpeak/core/app_size/app_size.dart';
import 'package:techpeak/core/constante/app_color.dart';
import 'package:techpeak/core/constante/app_image.dart';

class UserInfoWidget extends StatelessWidget {
  final dynamic user;

  const UserInfoWidget({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ImageMultiType(
          url: AppImages.person,
          height: response(context, 24),
          width:  response(context, 24),
        ),
        const SizedBox(width: 8),
        Text(
          user.user,
          style: TextStyle(
            color: AppColors.blackColor,
            fontSize:  response(context, 16),
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
} 