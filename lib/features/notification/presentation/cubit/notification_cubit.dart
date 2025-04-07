import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/models/notification_model.dart';

class NotificationCubit extends Cubit<List<NotificationModel>> {
  NotificationCubit() : super([]);

  void loadNotifications() {
    final notifications = [
      NotificationModel(
        title: "تفعيل باقة انترنت",
        message: "تم تفعيل باقة 100 جيجابايت بنجاح",
        date: "2024-03-20",
        time: "3:10",
        isRead: false,
        type: 'success',
      ),
      NotificationModel(
        title: "تنبيه استهلاك",
        message: "لقد استهلكت 80% من باقة الإنترنت الخاصة بك",
        date: "2024-03-20",
        time: "12:10",
        isRead: true,
        type: 'warning',
      ),
      NotificationModel(
        title: "تجديد الباقة",
        message: "سيتم تجديد باقتك تلقائياً خلال 3 أيام",
        date: "2024-03-19",
        time: "12:10",
        isRead: false,
        type: 'info',
      ),
    ];
    emit(notifications);
  }

  void clearNotifications() {
    emit([]);
  }

  void markAsRead(int index) {
    final notifications = List<NotificationModel>.from(state);
    if (index >= 0 && index < notifications.length) {
      notifications[index] = NotificationModel(
        title: notifications[index].title,
        message: notifications[index].message,
        date: notifications[index].date,
        time: notifications[index].time,
        type: notifications[index].type,
        isRead: true,
      );
      emit(notifications);
    }
  }
}
