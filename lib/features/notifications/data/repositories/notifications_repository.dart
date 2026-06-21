import '../models/notification_model.dart';

abstract interface class NotificationsRepository {
  Future<List<NotificationModel>> getNotifications();
  Future<void> markAsRead(String id);
}
