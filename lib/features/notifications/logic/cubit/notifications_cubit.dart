import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/models/notification_model.dart';
import '../../data/repositories/notifications_repository.dart';
import '../state/notifications_state.dart';

class NotificationsCubit extends Cubit<NotificationsState> {
  NotificationsCubit(this._repository) : super(const NotificationsInitial());

  final NotificationsRepository _repository;
  List<NotificationModel> _notifications = [];

  Future<void> loadNotifications() async {
    emit(const NotificationsLoading());
    try {
      _notifications = await _repository.getNotifications();
      emit(NotificationsLoaded(List.from(_notifications)));
    } catch (e) {
      emit(NotificationsError(e.toString()));
    }
  }

  Future<void> markAsRead(String id) async {
    _notifications = _notifications.map((n) {
      return n.id == id ? n.copyWith(isRead: true) : n;
    }).toList();
    emit(NotificationsLoaded(List.from(_notifications)));
    await _repository.markAsRead(id);
  }

  Future<void> markAllAsRead() async {
    _notifications = _notifications.map((n) => n.copyWith(isRead: true)).toList();
    emit(NotificationsLoaded(List.from(_notifications)));
  }
}
