import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:techpeak/features/internet/presentation/widgets/info_row_widget.dart';

import '../../../../core/app_size/app_size.dart';

class DateInfoWidget extends StatelessWidget {
  final dynamic details;

  const DateInfoWidget({super.key, required this.details});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InfoRowWidget(
          label1: "تاريخ البدء: ",
          value1: _formatDate(details.startDate),
          label2: "تاريخ الانتهاء: ",
          value2: _formatDate(details.endDate),
        ),
        SizedBox(height: response(context, 12)),
        InfoRowWidget(
          label1: "تاريخ الحالي: ",
          value1: _formatDate(details.currentDate),
          label2: "المدة المتبقية: ",
          value2: details.remainingPeriod,
        ),
      ],
    );
  }

  String _formatDate(String? dateStr) {
    if (dateStr == null) return "تاريخ غير متاح";
    final date = DateTime.tryParse(dateStr);
    if (date == null) return "تاريخ غير متاح";
    return DateFormat("yyyy/MM/dd").format(date);
  }
} 