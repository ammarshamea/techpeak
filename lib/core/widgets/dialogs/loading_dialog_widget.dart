import 'package:flutter/material.dart';

import '../../app_size/app_size.dart';
import '../../constante/app_color.dart';

class LoadingDialogWidget extends StatelessWidget {
  const LoadingDialogWidget({super.key});

  static Future<void> show(BuildContext context) {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const LoadingDialogWidget(),
    );
  }

  static void hide(BuildContext context) {
    if (Navigator.canPop(context)) {
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false, // Prevent back button dismissal
      child: Material(
        color: Colors.transparent,
        child: Center(
          child: Container(
            width: width(context) * 0.3,
            padding: EdgeInsets.all(response(context, 25)),
            margin: EdgeInsets.symmetric(horizontal: response(context, 24)),
            decoration: BoxDecoration(
              color: AppColors.whiteColor,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 10,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                const CircularProgressIndicator(
                  color: AppColors.primaryColor,
                  strokeWidth: 3,
                ),
                SizedBox(height: response(context, 16)),
                Text(
                  'جاري التحميل...',
                  style: TextStyle(
                    color: AppColors.primaryColor,
                    fontSize: response(context, 14),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
