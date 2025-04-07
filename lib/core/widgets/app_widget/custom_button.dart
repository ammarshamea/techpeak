import 'package:flutter/material.dart';
import 'package:techpeak/core/app_size/app_size.dart';

import '../../constante/app_color.dart';

class CustomLoadingButton extends StatefulWidget {
  final String title;
  final void Function()? onPressed;
  final bool isLoading,isElevation;
  final double height,width,borderRadius;
  final double? vertical,fontSize; // Control loading state from outside
  final Color colorButton, colorText, colorLoader;

  const CustomLoadingButton({
    super.key,
    required this.title,
    required this.onPressed,
    this.isLoading = false,
    this.height = 120,
    this.width = 120,
    this.borderRadius = 8.0,
    this.colorButton = AppColors.primaryColor,
    this.colorText = Colors.white,
    this.colorLoader = Colors.white,
    this.vertical, required this.isElevation, this.fontSize=18, // Allow custom vertical padding
  });

  @override
  _CustomLoadingButtonState createState() => _CustomLoadingButtonState();
}

class _CustomLoadingButtonState extends State<CustomLoadingButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration:widget.isElevation? BoxDecoration(
          borderRadius: BorderRadiusDirectional.circular(response(context, 16)),
          boxShadow: [
            BoxShadow(
              color: AppColors.primaryColor.withOpacity(0.5),
              offset: Offset(0, 4),
              blurRadius: 8,
            )
          ]):null,
      child: ElevatedButton(
        onPressed: widget.isLoading ? null : widget.onPressed,
        style: ElevatedButton.styleFrom(
          shadowColor: AppColors.primaryColor.withOpacity(0.4),
          fixedSize: Size(widget.width, widget.height),
          backgroundColor: widget.colorButton,
          shape: RoundedRectangleBorder(
            borderRadius:
                BorderRadius.circular(widget.borderRadius), // Border radius
          ),
          padding: EdgeInsets.symmetric(
              vertical: widget.vertical ?? 15.0), // Padding for the button
        ),
        child: widget.isLoading
            ? SizedBox(
                width: 20.0,
                height: 20.0,
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(widget.colorLoader),
                  strokeWidth: 5.0,
                ),
              )
            : Text(
                widget.title,
                style: TextStyle(
                    fontSize: widget.fontSize,
                    color: widget.colorText,
                    fontWeight: FontWeight.bold),
              ),
      ),
    );
  }
}
