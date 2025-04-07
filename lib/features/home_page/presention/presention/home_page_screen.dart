import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_multi_type/image_multi_type.dart';
import 'package:techpeak/features/home_page/presention/cubit/home_page_cubit.dart';
import 'package:techpeak/features/complaints/presentation/pages/complaints_page.dart';
import 'package:techpeak/features/internet/presentation/pages/internet_page.dart';
import 'package:techpeak/features/packages/presentation/pages/packages_page.dart';

import '../../../../core/app_size/app_size.dart';
import '../../../../core/constante/app_color.dart';
import '../../../../core/constante/app_image.dart';
import '../../../package/presentation/pages/package_screen.dart';

class HomePageScreen extends StatelessWidget {
  const HomePageScreen({super.key});

  // Updated pages list
  final List<Widget> _pages = const [
    PackageScreen(),
    // PackagesPage(), // New page
    ComplaintsPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomePageCubit(),
      child: WillPopScope(
        onWillPop: () async {
          return await _showExitDialog(context);
        },
        child: Builder(builder: (context) {
          return Scaffold(
            backgroundColor: Colors.white,
            body: BlocBuilder<HomePageCubit, int>(
              builder: (context, currentIndex) {
                return _pages[currentIndex];
              },
            ),
            bottomNavigationBar: _buildNavigationBar(true),
          );
        }),
      ),
    );
  }

  Future<bool> _showExitDialog(BuildContext context) async {
    return await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text("تأكيد الخروج"),
            content: const Text("هل أنت متأكد أنك تريد الخروج من التطبيق؟"),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                // إغلاق التنبيه بدون خروج
                child: const Text("إلغاء"),
              ),
              TextButton(
                onPressed: () {
                  SystemNavigator.pop(); // إغلاق التطبيق
                },
                child: const Text("خروج"),
              ),
            ],
          ),
        ) ??
        false;
  }

  Widget _buildNavigationBar(bool isLoggedIn) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(23),
        boxShadow: [
          BoxShadow(
            blurRadius: 50,
            color: AppColors.primaryColor.withOpacity(0.5),
            offset: const Offset(0, 30),
          ),
        ],
      ),
      child: BlocBuilder<HomePageCubit, int>(
        builder: (context, currentIndex) {
          return Directionality(
            textDirection: TextDirection.ltr,
            child: CurvedNavigationBar(
              color: Colors.white,
              backgroundColor: Colors.transparent,
              height: response(context, 60),
              index: currentIndex,
              items: _buildNavItems(isLoggedIn, currentIndex, context),
              onTap: (value) => context.read<HomePageCubit>().changePage(value, context),
            ),
          );
        },
      ),
    );
  }

  List<Widget> _buildNavItems(
      bool isLoggedIn, int currentIndex, BuildContext context) {
    final icons = [
      AppImages.internet,
      // AppImages.package, // Add new icon
      AppImages.complaint,
    ];

    final labels = [
      ' الانترنت',
      // 'الباقات',
      'الشكاوى',
    ];

    return icons
        .asMap()
        .entries
        .map((entry) => _buildNavItem(
              entry.value,
              labels[entry.key],
              entry.key == currentIndex,
              context))
        .toList();
  }

  Widget _buildNavItem(String iconPath, String label, bool isActive, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ImageMultiType(
            url: iconPath,
            width: width(context) * 0.06,
            height: height(context) * 0.025,
            color: isActive ? AppColors.primaryColor : AppColors.greyColor,
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: isActive ? AppColors.primaryColor : AppColors.greyColor,
              fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
}
