class NotificationModel {
  final String title;
  final String message;
  final String date;
  final String time;
  final bool isRead;
  final String type; // 'success', 'warning', 'info'

  NotificationModel({
    required this.title,
    required this.message,
    required this.date,
    required this.time,
    required this.isRead,
    required this.type,
  });
} 