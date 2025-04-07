import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_multi_type/image_multi_type.dart';

import '../../../../core/app_size/app_size.dart';
import '../../../../core/constante/app_color.dart';
import '../../../../core/constante/app_image.dart';
import '../../../../core/route/route_list.dart';

class InternetDetailsHeader extends StatelessWidget {
  const InternetDetailsHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            InkWell(
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              onTap: () {
                AppRouter.navigatePop(context);
              },
              child: Container(
                width: response(context, 32),
                height: response(context, 32),
                padding: EdgeInsets.all(response(context, 8)),
                child: ImageMultiType(
                  url: AppImages.arrow,
                  color: AppColors.greyColor,
                  width: response(context, 16),
                  height: response(context, 16),
                ),
              ),
            ),
            SizedBox(
              width: response(context, 20),
            ),
            Text(
              "تفاصيل الباقة",
              style: TextStyle(
                  color: AppColors.primaryColor,
                  fontWeight: FontWeight.bold,
                  fontSize:  response(context, 30)),
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
