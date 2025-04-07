import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:techpeak/core/constante/app_image.dart';
import '../../../../core/constante/app_color.dart';
import '../../../../core/route/route_list.dart';
import '../../../../core/widgets/app_widget/logo.dart';
import '../../../../dependency_injection.dart';
import '../cubit/splash_cubit.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<SplashCubit>()..initSplash(),
      child: BlocListener<SplashCubit, SplashState>(
        listener: (context, state) {
          if (state is SplashCompleted) {
            AppRouter.navigateAndRemoveUntil(
              context,
              state.isLoggedIn ? AppRouter.homePage : AppRouter.login,
            );
          }
        },
        child: Scaffold(
          backgroundColor: AppColors.whiteColor,
          body: TweenAnimationBuilder<double>(
            tween: Tween(begin: 0.0, end: 1.0),
            duration: const Duration(seconds: 2),
            builder: (context, value, child) {
              return Opacity(
                opacity: value,
                child: Transform.scale(
                  scale: 0.5 + (value * 0.5),
                  child: Center(
                    child: Logo(Image: AppImages.logo1,),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
