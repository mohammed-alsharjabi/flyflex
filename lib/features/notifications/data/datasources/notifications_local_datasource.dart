import '../models/notification_model.dart';

class NotificationsLocalDatasource {
  Future<List<NotificationModel>> getNotifications() async {
    await Future.delayed(const Duration(milliseconds: 400));
    return NotificationModel.mock;
  }
}
