import 'package:flutter/material.dart';
import 'package:techpeak/features/internet/presentation/widgets/info_row_widget.dart';

class PackageInfoWidget extends StatelessWidget {
  final dynamic details;

  const PackageInfoWidget({super.key, required this.details});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InfoRowWidget(
          label1: "الباقة المتبقية: ",
          value1: details.remainingPackage,
          label2: "الباقة المستخدمة: ",
          value2: details.usedPackage,
        ),
      ],
    );
  }
} 