import 'package:equatable/equatable.dart';

class NotificationModel extends Equatable {
  const NotificationModel({
    required this.id,
    required this.title,
    required this.body,
    required this.timestamp,
    required this.type,
    this.isRead = false,
    this.actionRoute,
  });

  final String id;
  final String title;
  final String body;
  final DateTime timestamp;
  final NotificationType type;
  final bool isRead;
  final String? actionRoute;

  NotificationModel copyWith({bool? isRead}) => NotificationModel(
        id: id,
        title: title,
        body: body,
        timestamp: timestamp,
        type: type,
        isRead: isRead ?? this.isRead,
        actionRoute: actionRoute,
      );

  String get timeAgo {
    final diff = DateTime.now().difference(timestamp);
    if (diff.inMinutes < 60) return '${diff.inMinutes} min ago';
    if (diff.inHours < 24) return '${diff.inHours}h ago';
    if (diff.inDays == 1) return 'Yesterday';
    return '${diff.inDays} days ago';
  }

  static List<NotificationModel> get mock => [
        NotificationModel(
          id: 'n1',
          title: 'Flight Price Drop! ✈️',
          body: 'RUH → JED is now 280 SAR. Only 3 seats left!',
          timestamp: DateTime.now().subtract(const Duration(minutes: 15)),
          type: NotificationType.priceAlert,
          isRead: false,
        ),
        NotificationModel(
          id: 'n2',
          title: 'Booking Confirmed',
          body:
              'Your booking BK001 for Riyadh → Jeddah is confirmed. Have a great trip!',
          timestamp: DateTime.now().subtract(const Duration(hours: 2)),
          type: NotificationType.booking,
          isRead: false,
          actionRoute: '/bookings',
        ),
        NotificationModel(
          id: 'n3',
          title: 'Check-in Now Open',
          body: 'Online check-in for SV204 is now available. Check in early!',
          timestamp: DateTime.now().subtract(const Duration(hours: 24)),
          type: NotificationType.checkin,
          isRead: true,
        ),
        NotificationModel(
          id: 'n4',
          title: 'New Routes Added',
          body:
              'FlyFlex now covers AlUla → Riyadh with exclusive last-minute deals.',
          timestamp: DateTime.now().subtract(const Duration(days: 2)),
          type: NotificationType.promotional,
          isRead: true,
        ),
      ];

  @override
  List<Object?> get props => [id];
}

enum NotificationType {
  priceAlert,
  booking,
  checkin,
  promotional;

  String get label {
    switch (this) {
      case NotificationType.priceAlert:
        return 'Price Alert';
      case NotificationType.booking:
        return 'Booking';
      case NotificationType.checkin:
        return 'Check-in';
      case NotificationType.promotional:
        return 'Promotion';
    }
  }
}
