import 'package:flutter/material.dart';
import 'package:techpeak/core/app_size/app_size.dart';
import 'package:techpeak/core/constante/app_color.dart';
import 'package:techpeak/core/route/route_list.dart';

class EmptyNotification extends StatelessWidget {
  const EmptyNotification({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          Icons.notifications_off_outlined,
          size: 80,
          color: AppColors.primaryColor.withOpacity(0.75),
        ),
         SizedBox(height: response(context, 16)),
        Text(
          'لا يوجد اشعارات حاليا',
          style: TextStyle(
            fontSize: 18,
            color: AppColors.greyColor,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
} 