import 'package:flutter/cupertino.dart';

import '../../../../core/constante/app_color.dart';

class SectionText extends StatelessWidget {
  final String text;

  const SectionText({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: TextAlign.justify,
      style: const TextStyle(
        fontSize: 16,
        height: 1.5,
        color: AppColors.greyColor,
      ),
    );
  }
}