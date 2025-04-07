import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_multi_type/image_multi_type.dart';
import 'package:techpeak/core/app_size/app_size.dart';
import 'package:techpeak/core/constante/app_color.dart';
import 'package:techpeak/core/constante/app_image.dart';
import 'package:techpeak/core/route/route_list.dart';
import 'package:techpeak/core/widgets/app_widget/custom_button.dart';
import 'package:techpeak/features/auth/presention/bloc/auth_cubit.dart';
import 'package:techpeak/features/internet/presentation/widgets/internet_header.dart';
import 'package:techpeak/features/model_delete_after_api/model.dart';

import '../../../../dependency_injection.dart';

class InternetPage extends StatelessWidget {
  const InternetPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.whiteColor,
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.only(
                top: response(context, 16),
                left: response(context, 16),
                right: response(context, 16)),
            child: Column(
              children: [
                BlocProvider(
                  create: (context) => sl<AuthCubit>(),
                  child: InternetHeader(),
                ),
                SizedBox(
                  height: response(context, 16),
                ),
                Expanded(
                    child: ListView.separated(
                        itemBuilder: (context, index) {
                          return Container(
                            padding: EdgeInsets.all(4),
                            decoration: BoxDecoration(
                                color: AppColors.cardColor,
                                borderRadius: BorderRadius.circular(12),
                                boxShadow: [
                                  BoxShadow(
                                      color:
                                          AppColors.blackColor.withOpacity(0.1),
                                      blurRadius: 10,
                                      offset: Offset(0, 3))
                                ]),
                            child: ListTile(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              tileColor: Colors.white,
                              title: Row(
                                children: [
                                  ImageMultiType(
                                    url: AppImages.person,
                                    height: response(context, 24),
                                    width: response(context, 24),
                                  ),
                                  SizedBox(
                                    width: response(context, 8),
                                  ),
                                  Text(
                                    AppItems.internetUsers[index].user,
                                    style: TextStyle(
                                        color: AppColors.blackColor,
                                        fontSize: 16),
                                  )
                                ],
                              ),
                              trailing: CustomLoadingButton(
                                title: "التفاصيل",
                                isElevation: false,
                                fontSize: 14,
                                onPressed: () {
                                  AppRouter.navigateTo(
                                      context, AppRouter.internetDetailsScreen,
                                      args: index);
                                },
                                width: response(context, 73),
                                height: response(context, 40),
                                vertical: 0,
                              ),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(height: response(context, 8)),
                                  Row(
                                    children: [
                                      ImageMultiType(
                                        url: AppImages.internetGB,
                                        height: response(context, 24),
                                        width: response(context, 24),
                                      ),
                                      SizedBox(width: response(context, 8)),
                                      Text(
                                        "حجم الباقة:  ${AppItems.internetUsers[index].internet}",
                                        style: TextStyle(
                                            color: AppColors.blackColor,
                                            fontSize: 16),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                        separatorBuilder: (context, index) => SizedBox(
                              height: response(context, 16),
                            ),
                        itemCount: AppItems.internetUsers.length))
              ],
            ),
          ),
        ));
  }
}
