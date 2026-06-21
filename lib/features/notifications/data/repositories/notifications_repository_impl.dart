import '../datasources/notifications_local_datasource.dart';
import '../models/notification_model.dart';
import 'notifications_repository.dart';

class NotificationsRepositoryImpl implements NotificationsRepository {
  const NotificationsRepositoryImpl(this._datasource);

  final NotificationsLocalDatasource _datasource;

  @override
  Future<List<NotificationModel>> getNotifications() =>
      _datasource.getNotifications();

  @override
  Future<void> markAsRead(String id) async {
    // No-op in mock — in production, would call API and update local cache
  }
}
