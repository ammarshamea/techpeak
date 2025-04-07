import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:techpeak/core/app_size/app_size.dart';
import 'package:techpeak/core/constante/app_color.dart';
import 'package:techpeak/dependency_injection.dart';
import 'package:techpeak/features/auth/presention/bloc/auth_cubit.dart';
import 'package:techpeak/features/internet/presentation/cubit/internet_details_cubit.dart';
import 'package:techpeak/features/internet/presentation/widgets/internet_header.dart';
import 'package:techpeak/features/package/domain/usecase/package_use_case.dart';
import 'package:techpeak/features/package/presentation/cubit/package_cubit.dart';
import 'package:techpeak/features/package/presentation/widgets/package_card.dart';
import 'package:techpeak/features/internet/presentation/widgets/progress_indicator_widget.dart';

class PackageScreen extends StatelessWidget {
  const PackageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => PackageCubit(
            packageUseCase: sl<PackageUseCase>(),
          ),
        ),
        BlocProvider(create: (context) => InternetDetailsCubit()),
        BlocProvider(create: (context) => sl<AuthCubit>()),
      ],
      child: Scaffold(
        backgroundColor: AppColors.whiteColor,
        body: SafeArea(
          child: Center(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: response(context, 16),
                vertical: response(context, 16),
              ),
              child: Center(
                child: Column(
                  children: [
                    const InternetHeader(),
                    SizedBox(height: response(context, 24)),
                    Expanded(
                      child: BlocBuilder<PackageCubit, PackageState>(
                        builder: (context, state) {
                          if (state.error != null) {
                            return Center(child: Text(state.error!));
                          }
                          if (state.packages.isEmpty) {
                            return const Center(
                                child: CircularProgressIndicator());
                          }
                          final currentPackage =
                              state.currentPackage ?? state.packages[0];
                          return Column(
                            children: [
                              Expanded(
                                flex: 1,
                                child: PageView.builder(
                                  onPageChanged: (page) {
                                    context.read<PackageCubit>().updatePage(page);
                                  },
                                  itemCount: state.packages.length,
                                  itemBuilder: (context, index) {
                                    return PackageCards(
                                      package: state.packages[index],
                                      isActive: state.currentPage == index,
                                    );
                                  },
                                ),
                              ),
                              SizedBox(height: response(context, 24)),
                              ProgressIndicatorWidget(
                                percentage: state.progress,
                                used: '${currentPackage.usageGb} جيجابايت',
                                total: '${currentPackage.limitGb} جيجابايت',
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}