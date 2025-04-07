import 'package:flutter/material.dart';
import 'package:techpeak/core/app_size/app_size.dart';

import '../../constante/app_color.dart';

class TextFieldCustom extends StatefulWidget {
  final TextEditingController? controller;
  final bool obscureText;
  final String hintText;
  final Widget? prefixIcon;
  final Widget? suffix;
  final TextStyle hintStyle;
  final TextInputType? type;
  final int? maxLength;
  final int? maxLines;

  final void Function(String)? onChanged;
  final String? Function(String?)? validator;

  const TextFieldCustom({
    super.key,
    required this.controller,
    this.obscureText = false,
    required this.hintText,
    this.prefixIcon,
    required this.hintStyle,
    this.type,
    this.suffix,
    this.validator,
    this.maxLines = 1,
    this.maxLength,
    this.onChanged,
  });

  @override
  State<TextFieldCustom> createState() => _TextFieldCustomState();
}

class _TextFieldCustomState extends State<TextFieldCustom> {
  final GlobalKey<FormFieldState> _textFieldKey = GlobalKey<FormFieldState>();

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      key: _textFieldKey,
      style: const TextStyle(
        color: AppColors.blackColor,
        fontWeight: FontWeight.w500,
        fontSize: 16,
      ),

      validator: widget.validator,
      maxLength: widget.maxLength,
      controller: widget.controller,
      keyboardType: widget.type,
      obscureText: widget.obscureText,
      cursorColor: AppColors.primaryColor,
      cursorErrorColor: AppColors.redColor,
      maxLines: widget.maxLines,
      onChanged: widget.onChanged,
      textAlign: TextAlign.right,
      textDirection: TextDirection.rtl,
      decoration: InputDecoration(
        fillColor: AppColors.cardColor,
        filled: true,
        suffixIcon: widget.suffix,
        contentPadding: EdgeInsets.symmetric(
          horizontal: response(context, 16),
          vertical: response(context, 12),
        ),
        hintText: widget.hintText,
        prefixIcon: widget.prefixIcon,
        border: buildOutlineInputBorder(),
        focusedBorder: buildFocusOutlineInputBorder(),
        enabledBorder: buildOutlineInputBorder(),
        errorBorder: buildErrorOutlineInputBorder(),
        focusedErrorBorder: buildErrorOutlineInputBorder(),
        errorStyle: const TextStyle(
          color: AppColors.redColor,
          fontSize: 12,
          fontWeight: FontWeight.bold,
        ),
        hintStyle: widget.hintStyle,
      ),
    );
  }

  OutlineInputBorder buildOutlineInputBorder() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(20),
      borderSide: BorderSide(
        color: AppColors.greyBorderColor.withOpacity(0.2),
        width: 1.5,
      ),
    );
  } OutlineInputBorder buildFocusOutlineInputBorder() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(20),
      borderSide: BorderSide(
        color: AppColors.primaryColor,
        width: 1.5,
      ),
    );
  }

  OutlineInputBorder buildErrorOutlineInputBorder() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(20),
      borderSide: const BorderSide(
        width: 1.5,
        color: AppColors.redColor,
      ),
    );
  }
}
