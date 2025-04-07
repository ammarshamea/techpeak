import 'package:flutter/material.dart';
import 'package:image_multi_type/image_multi_type.dart';
import 'package:techpeak/features/package/domain/entities/package.dart';
import '../../../../core/app_size/app_size.dart';
import '../../../../core/constante/app_color.dart';
import '../../../../core/constante/app_image.dart';

class PackageCards extends StatelessWidget {
  final Package package;
  final bool isActive;

  const PackageCards({
    super.key,
    required this.package,
    this.isActive = false,
  });

  void _showPackageDetails(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          'تفاصيل الباقة',
          textAlign: TextAlign.right,
          style: TextStyle(
            fontSize: response(context, 20),
            fontWeight: FontWeight.bold,
          ),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildDetailRow('اسم الباقة', package.name),
            _buildDetailRow('الحد الأقصى', '${package.limitGb} جيجابايت'),
            _buildDetailRow('المستخدم', '${package.usageGb} جيجابايت'),
            _buildDetailRow('المتبقي', '${package.remainingGb} جيجابايت'),
            _buildDetailRow('نسبة الاستخدام', '${package.usagePercentage}%'),
            _buildDetailRow('تاريخ البداية', package.startDate),
            _buildDetailRow('تاريخ النهاية', package.endDate),
            _buildDetailRow('الحالة', package.status),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('إغلاق'),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [

          Text(label),
          Text(
            value,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: response(context, 8),
        vertical: response(context, 4),
      ),
      decoration: BoxDecoration(
        color: isActive ? AppColors.primaryColor : AppColors.cardColor,
        borderRadius: BorderRadius.circular(response(context, 16)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ImageMultiType(
            url: AppImages.package,
            height: response(context, 32),
            width: response(context, 32),
            color: isActive ? Colors.white : AppColors.primaryColor,
          ),
          SizedBox(height: response(context, 16)),
          Text(
            package.name,
            style: TextStyle(
              color: isActive ? Colors.white : AppColors.blackColor,
              fontSize: response(context, 16),
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: response(context, 8)),
          Text(
            '${package.limitGb} جيجابايت',
            style: TextStyle(
              color: isActive ? Colors.white70 : AppColors.greyColor,
              fontSize: response(context, 16),
            ),
          ),
          SizedBox(height: response(context, 8)),
          Text(
            'المتبقي: ${package.remainingGb} جيجابايت',
            style: TextStyle(
              color: isActive ? Colors.white70 : AppColors.greyColor,
              fontSize: response(context, 14),
            ),
          ),
          SizedBox(height: response(context, 16)),
          GestureDetector(
            onTap: () => _showPackageDetails(context),
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: response(context, 24),
                vertical: response(context, 8),
              ),
              decoration: BoxDecoration(
                color: isActive
                    ? Colors.white.withOpacity(0.2)
                    : AppColors.primaryColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(response(context, 30)),
              ),
              child: Text(
                'تفاصيل الباقة',
                style: TextStyle(
                  color: isActive ? Colors.white : AppColors.primaryColor,
                  fontSize: response(context, 16),
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
