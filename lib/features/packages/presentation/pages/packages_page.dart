import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_multi_type/image_multi_type.dart';
import 'package:techpeak/features/packages/data/models/package_model.dart';
import '../../../../core/app_size/app_size.dart';
import '../../../../core/constante/app_color.dart';
import '../cubit/packages_cubit.dart';
import '../widgets/package_card.dart';

class PackagesPage extends StatelessWidget {
  const PackagesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PackagesCubit()..loadPackages(),
      child: Scaffold(
        backgroundColor:AppColors.whiteColor,

        body: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.all(response(context, 16)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,

                  children: [
                    Text(
                      "تفاصيل الباقة",
                      style: TextStyle(
                          color: AppColors.primaryColor,
                          fontWeight: FontWeight.bold,
                          fontSize: response(context, 30)),
                    ),
                    SizedBox(
                      height: response(context, 8),
                    ),
                    Divider(color: AppColors.greyColor.withOpacity(0.3)),

                  ],
                ),
              ),
              BlocBuilder<PackagesCubit, List<PackageModel>>(
                builder: (context, packages) {
                  return Expanded(
                    child: ListView.builder(
                      padding: const EdgeInsets.all(16),
                      itemCount: packages.length,
                      itemBuilder: (context, index) {
                        return PackageCard(package: packages[index]);
                      },
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
