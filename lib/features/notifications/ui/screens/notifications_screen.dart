import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../logic/cubit/notifications_cubit.dart';
import '../../logic/state/notifications_state.dart';
import '../widgets/notification_tile.dart';
import '../../../home/ui/widgets/home_bottom_nav.dart';
import '../../../../core/di/injection.dart';
import '../../../../core/router/app_router.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/gradient_background.dart';
import '../../../../core/utils/l10n_extension.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<NotificationsCubit>()..loadNotifications(),
      child: const _NotificationsView(),
    );
  }
}

class _NotificationsView extends StatelessWidget {
  const _NotificationsView();

  @override
  Widget build(BuildContext context) {
    final topPad = MediaQuery.paddingOf(context).top;

    return NavyScaffold(
      bottomNavigationBar: HomeBottomNav(
        currentIndex: 2,
        onTap: (i) {
          switch (i) {
            case 0:
              context.go(AppRoutes.home);
            case 1:
              context.go(AppRoutes.myBookings);
            case 3:
              context.go(AppRoutes.profile);
          }
        },
      ),
      child: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.fromLTRB(24, topPad + 20, 24, 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    context.l10n.notificationsTitle,
                    style: GoogleFonts.inter(
                      fontSize: 28,
                      fontWeight: FontWeight.w800,
                      color: AppColors.textPrimary,
                      letterSpacing: -0.5,
                    ),
                  ),
                  BlocBuilder<NotificationsCubit, NotificationsState>(
                    builder: (context, state) {
                      if (state is! NotificationsLoaded) {
                        return const SizedBox.shrink();
                      }
                      return GestureDetector(
                        onTap: () =>
                            context.read<NotificationsCubit>().markAllAsRead(),
                        child: Text(
                          context.l10n.notificationsMarkAll,
                          style: GoogleFonts.inter(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: AppColors.goldPure,
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            sliver: BlocBuilder<NotificationsCubit, NotificationsState>(
              builder: (context, state) {
                return switch (state) {
                  NotificationsLoading() => const SliverToBoxAdapter(
                      child: Center(
                        child: CircularProgressIndicator(
                            color: AppColors.goldPure),
                      ),
                    ),
                  NotificationsLoaded(:final notifications) =>
                    notifications.isEmpty
                        ? const SliverToBoxAdapter(child: _EmptyState())
                        : SliverList(
                            delegate: SliverChildBuilderDelegate(
                              (context, i) => NotificationTile(
                                notification: notifications[i],
                              ),
                              childCount: notifications.length,
                            ),
                          ),
                  NotificationsError(:final message) => SliverToBoxAdapter(
                      child: Center(
                        child: Text(
                          message,
                          style: const TextStyle(color: AppColors.error),
                        ),
                      ),
                    ),
                  _ => const SliverToBoxAdapter(child: SizedBox.shrink()),
                };
              },
            ),
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 32)),
        ],
      ),
    );
  }
}

class _EmptyState extends StatelessWidget {
  const _EmptyState();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(48),
        child: Column(
          children: [
            const Icon(
              Icons.notifications_off_outlined,
              size: 64,
              color: AppColors.textHint,
            ),
            const SizedBox(height: 16),
            Text(
              context.l10n.notificationsEmpty,
              style: GoogleFonts.inter(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: AppColors.textSecondary,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              context.l10n.notificationsEmptySubtitle,
              textAlign: TextAlign.center,
              style: GoogleFonts.inter(
                fontSize: 14,
                color: AppColors.textMuted,
                height: 1.5,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
