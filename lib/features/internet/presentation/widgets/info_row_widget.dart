import 'package:flutter/material.dart';
import 'package:techpeak/core/app_size/app_size.dart';
import 'package:techpeak/core/constante/app_color.dart';

class InfoRowWidget extends StatelessWidget {
  final String label1;
  final String value1;
  final String label2;
  final String value2;

  const InfoRowWidget({
    super.key,
    required this.label1,
    required this.value1,
    required this.label2,
    required this.value2,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: _buildRichText(label1, value1,context),
        ),
         SizedBox(width:response(context, 16) ),
        Expanded(
          child: _buildRichText(label2, value2,context),
        ),
      ],
    );

  }

  Widget _buildRichText(String label, String value,BuildContext context) {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: label,
            style:  TextStyle(
              fontWeight: FontWeight.bold,
              color: AppColors.primaryColor,
              fontSize: response(context, 12),
            ),
          ),
          TextSpan(
            text: value,
            style:  TextStyle(
              color: AppColors.blackColor,
              fontSize: response(context, 12),
            ),
          ),
        ],
      ),
    );
  }
} 