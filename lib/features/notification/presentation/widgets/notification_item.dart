import 'package:flutter/material.dart';
import '../../../../core/constante/app_color.dart';
import '../../data/models/notification_model.dart';

class NotificationItem extends StatelessWidget {
  final NotificationModel notification;
  final VoidCallback onDismissed;

  const NotificationItem({
    super.key,
    required this.notification,
    required this.onDismissed,
  });

  Color _getTypeColor() {
    switch (notification.type) {
      case 'success':
        return Colors.green;
      case 'warning':
        return Colors.orange;
      case 'info':
        return AppColors.primaryColor;
      default:
        return AppColors.primaryColor;
    }
  }

  IconData _getTypeIcon() {
    switch (notification.type) {
      case 'success':
        return Icons.check_circle_outline;
      case 'warning':
        return Icons.warning_amber_outlined;
      case 'info':
        return Icons.info_outline;
      default:
        return Icons.notifications_outlined;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: notification.isRead
            ? Colors.white
            : _getTypeColor().withOpacity(0.05),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: notification.isRead
              ? Colors.grey.shade200
              : _getTypeColor().withOpacity(0.3),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: _getTypeColor().withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(
              _getTypeIcon(),
              color: _getTypeColor(),
              size: 24,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        notification.title,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: notification.isRead
                              ? FontWeight.normal
                              : FontWeight.bold,
                          color: AppColors.blackColor,
                        ),
                      ),
                    ),
                    Text(
                      notification.time,
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  notification.message,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[700],
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
} 