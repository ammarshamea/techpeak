import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:image_multi_type/image_multi_type.dart';
import 'package:techpeak/core/app_size/app_size.dart';
import 'package:techpeak/features/internet/presentation/widgets/internet_details_header.dart';
import 'package:techpeak/features/notification/data/models/notification_model.dart';
import 'package:techpeak/features/notification/presentation/widgets/notification_header.dart';
import '../../../../core/constante/app_color.dart';
import '../../../../core/constante/app_image.dart';
import '../../../model_delete_after_api/model.dart';
import '../cubit/notification_cubit.dart';
import '../widgets/notification_item.dart';
import '../widgets/empty_notification.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  String _formatDate(String date) {
    final now = DateTime.now();
    final notificationDate = DateTime.parse(date);
    
    if (DateUtils.isSameDay(now, notificationDate)) {
      return "اليوم";
    } else if (DateUtils.isSameDay(
        now.subtract(const Duration(days: 1)), notificationDate)) {
      return "أمس";
    }
    return DateFormat('dd/MM/yyyy').format(notificationDate);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NotificationCubit()..loadNotifications(),
      child: Scaffold(
        backgroundColor:AppColors.whiteColor,
        body: SafeArea(
          child: Column(
            children: [
              const NotificationHeader(),
              Expanded(
                child: BlocBuilder<NotificationCubit, List<NotificationModel>>(
                  builder: (context, notifications) {
                    if (notifications.isEmpty) {
                      return const EmptyNotification();
                    }

                    // Group notifications by date
                    final groupedNotifications = <String, List<NotificationModel>>{};
                    for (var notification in notifications) {
                      final date = _formatDate(notification.date);
                      groupedNotifications.putIfAbsent(date, () => []);
                      groupedNotifications[date]!.add(notification);
                    }

                    return ListView.builder(
                      padding: const EdgeInsets.only(top: 8),
                      itemCount: groupedNotifications.length,
                      itemBuilder: (context, index) {
                        final date = groupedNotifications.keys.elementAt(index);
                        final dateNotifications = groupedNotifications[date]!;

                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 24,
                                vertical: 8,
                              ),
                              child: Text(
                                date,
                                style: const TextStyle(
                                  color: AppColors.primaryColor,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            ...dateNotifications.map((notification) {
                              final index = notifications.indexOf(notification);
                              return NotificationItem(
                                notification: notification,
                                onDismissed: () {
                                  context.read<NotificationCubit>().markAsRead(index);
                                },
                              );
                            }).toList(),
                          ],
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
} 