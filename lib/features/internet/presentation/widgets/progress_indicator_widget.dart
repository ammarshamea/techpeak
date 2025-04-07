import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:techpeak/core/app_size/app_size.dart';
import 'package:techpeak/core/constante/app_color.dart';
import 'package:techpeak/features/package/presentation/cubit/package_cubit.dart';
import 'circle_progress_painter.dart';

class ProgressIndicatorWidget extends StatelessWidget {
  final double percentage;
  final String used;
  final String total;

  const ProgressIndicatorWidget({
    super.key,
    required this.percentage,
    required this.used,
    required this.total,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          BlocBuilder<PackageCubit, PackageState>(
            builder: (context, state) {
              return Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    width: response(context, 270),
                    height: response(context, 270),
                    padding: EdgeInsets.all(response(context, 10)),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.primaryColor.withOpacity(0.4),
                          blurRadius: response(context, 10),
                          spreadRadius: response(context, 4),
                        ),
                      ],
                    ),
                    child: CustomPaint(
                      painter: CircleProgressPainter(
                        progress: state.progress,
                        backgroundColor:
                            AppColors.primaryColor.withOpacity(0.1),
                        progressColor: AppColors.primaryColor,
                        strokeWidth: response(context, 10),
                      ),
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "${(state.progress * 100).toStringAsFixed(0)}%",
                        style: TextStyle(
                          fontSize: response(context, 32),
                          fontWeight: FontWeight.bold,
                          color: AppColors.primaryColor,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        "$used / $total",
                        style: TextStyle(
                          fontSize: response(context, 14),
                          color: AppColors.primaryColor.withOpacity(0.8),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
