import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../data/models/notification_model.dart';
import '../../logic/cubit/notifications_cubit.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_radius.dart';

class NotificationTile extends StatelessWidget {
  const NotificationTile({super.key, required this.notification});

  final NotificationModel notification;

  Color get _typeColor {
    switch (notification.type) {
      case NotificationType.priceAlert:
        return AppColors.goldPure;
      case NotificationType.booking:
        return AppColors.success;
      case NotificationType.checkin:
        return AppColors.info;
      case NotificationType.promotional:
        return const Color(0xFF9B59B6);
    }
  }

  IconData get _typeIcon {
    switch (notification.type) {
      case NotificationType.priceAlert:
        return Icons.trending_down_rounded;
      case NotificationType.booking:
        return Icons.check_circle_rounded;
      case NotificationType.checkin:
        return Icons.flight_takeoff_rounded;
      case NotificationType.promotional:
        return Icons.local_offer_rounded;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.read<NotificationsCubit>().markAsRead(notification.id);
        if (notification.actionRoute != null) {
          context.push(notification.actionRoute!);
        }
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        child: ClipRRect(
          borderRadius: AppRadius.cardBorderRadius,
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: notification.isRead
                    ? AppColors.glassSurface
                    : AppColors.glassSurface.withValues(alpha: 0.15),
                borderRadius: AppRadius.cardBorderRadius,
                border: Border.all(
                  color: notification.isRead
                      ? AppColors.glassBorder
                      : _typeColor.withValues(alpha: 0.3),
                ),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (!notification.isRead)
                    Container(
                      width: 6,
                      height: 6,
                      margin:
                          const EdgeInsets.only(top: 6, right: 10),
                      decoration: BoxDecoration(
                        color: AppColors.goldPure,
                        shape: BoxShape.circle,
                      ),
                    ),
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: _typeColor.withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(_typeIcon, color: _typeColor, size: 20),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(
                                notification.title,
                                style: GoogleFonts.inter(
                                  fontSize: 14,
                                  fontWeight: notification.isRead
                                      ? FontWeight.w400
                                      : FontWeight.w700,
                                  color: notification.isRead
                                      ? AppColors.textSecondary
                                      : AppColors.textPrimary,
                                ),
                              ),
                            ),
                            Text(
                              notification.timeAgo,
                              style: GoogleFonts.inter(
                                fontSize: 11,
                                color: AppColors.textHint,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 4),
                        Text(
                          notification.body,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.inter(
                            fontSize: 13,
                            color: AppColors.textMuted,
                            height: 1.4,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
