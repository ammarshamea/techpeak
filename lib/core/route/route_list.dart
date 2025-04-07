import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:techpeak/features/auth/presention/bloc/auth_cubit.dart';
import 'package:techpeak/features/auth/presention/pages/register_screen.dart';
import 'package:techpeak/features/internet/presentation/pages/internet_details_screen.dart';
import 'package:techpeak/features/internet/presentation/pages/internet_page.dart';
import 'package:techpeak/features/terms_and_conditions/presention/page/term_and_conditions_screen.dart';

import '../../dependency_injection.dart';
import '../../features/auth/presention/pages/Login_screen.dart';
import '../../features/complaints/presentation/pages/complaints_page.dart';
import '../../features/home_page/presention/presention/home_page_screen.dart';
import '../../features/notification/presentation/pages/notification_screen.dart';
import '../../features/splash/presentation/cubit/splash_cubit.dart';
import '../../features/splash/presentation/pages/splash_page.dart';
import '../../core/widgets/dialogs/loading_dialog_widget.dart';

abstract class AppRouter {
  static const String rootRoute = "/";
  static const String homePage = "/homePage";
  static const String login = "/login";
  static const String signup = "/signup";
  static const String terms = "/terms";
  static const String complaintsPage = "/complaintsPage";
  static const String internetPage = "/internetPage";
  static const String internetDetailsScreen = "/internetPageDetails";
  static const String notification = "/notification";

  static Route<dynamic>? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case rootRoute:
        return _buildRoute(const SplashPage());
      case login:
        return _buildRoute(LoginScreen());
      case signup:
        return _buildRoute(RegisterScreen());
      case terms:
        return _buildRoute(
          BlocProvider(
            create: (context) => sl<AuthCubit>(),
            child: const TermsAndConditionsScreen(),
          ),
        );
      case notification:
        return _buildRoute(NotificationScreen());
      case homePage:
        return _buildRoute(const HomePageScreen());
      case complaintsPage:
        return _buildRoute(const ComplaintsPage());
      case internetPage:
        return _buildRoute(const InternetPage());
      case internetDetailsScreen:
        final args = settings.arguments as int; // استخراج المعامل

        // return _buildRoute(InternetDetailsScreen(
        //   index: args,
        // ));
      default:
        return _buildRoute(const Scaffold(
          body: Center(child: Text('Route not found')),
        ));
    }
  }

  static final Map<String, WidgetBuilder> router = {};

  static void navigateTo(BuildContext context, String routeName, {args}) {
    if (args != null) {
      Navigator.pushNamed(context, routeName, arguments: args);
    } else {
      Navigator.pushNamed(context, routeName);
    }
  }

  static void goBack(BuildContext context) {
    Navigator.pop(context);
  }

  static PageRouteBuilder _buildRoute(Widget page) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(
          opacity: animation,
          child: SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(0, 0.2),
              end: Offset.zero,
            ).animate(CurvedAnimation(
              parent: animation,
              curve: Curves.easeOut,
            )),
            child: child,
          ),
        );
      },
      transitionDuration: const Duration(milliseconds: 300),
    );
  }

  static void navigateAndRemoveUntil(BuildContext context, String routeName) {
    Navigator.pushNamedAndRemoveUntil(
      context,
      routeName,
      (Route<dynamic> route) => false,
    );
  }

  static void navigateAndReplace(BuildContext context, String routeName) {
    Navigator.pushReplacementNamed(
      context,
      routeName,
    );
  }

  static void navigatePop(BuildContext context) {
    Navigator.pop(context);
  }
}
