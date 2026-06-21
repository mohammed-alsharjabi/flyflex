import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:fly_flex/core/di/injection.dart';
import 'package:fly_flex/core/router/app_router.dart';
import 'package:fly_flex/core/theme/app_colors.dart';
import 'package:fly_flex/core/utils/l10n_extension.dart';
import 'package:fly_flex/core/widgets/gradient_background.dart';
import 'package:fly_flex/features/home/ui/widgets/home_bottom_nav.dart';
import '../../data/models/booking_model.dart';
import '../../logic/cubit/bookings_cubit.dart';
import '../../logic/state/bookings_state.dart';
import '../sections/bookings_list_section.dart';

class MyBookingsScreen extends StatelessWidget {
  const MyBookingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<BookingsCubit>()..loadBookings(),
      child: const _MyBookingsView(),
    );
  }
}

class _MyBookingsView extends StatelessWidget {
  const _MyBookingsView();

  @override
  Widget build(BuildContext context) {
    return NavyScaffold(
      bottomNavigationBar: HomeBottomNav(
        currentIndex: 1,
        onTap: (index) {
          switch (index) {
            case 0:
              context.go(AppRoutes.home);
            case 2:
              context.go(AppRoutes.notifications);
            case 3:
              context.go(AppRoutes.profile);
          }
        },
      ),
      child: BlocBuilder<BookingsCubit, BookingsState>(
        builder: (context, state) {
          final l = context.l10n;
          return CustomScrollView(
            slivers: [
              SliverAppBar(
                backgroundColor: Colors.transparent,
                elevation: 0,
                floating: true,
                automaticallyImplyLeading: false,
                flexibleSpace: FlexibleSpaceBar(
                  title: Text(
                    l.bookingsTitle,
                    style: GoogleFonts.inter(
                      fontSize: 22,
                      fontWeight: FontWeight.w700,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  centerTitle: false,
                  titlePadding: const EdgeInsets.only(left: 24, bottom: 16),
                ),
                expandedHeight: 80,
              ),
              SliverPadding(
                padding: const EdgeInsets.fromLTRB(24, 8, 24, 24),
                sliver: SliverToBoxAdapter(
                  child: switch (state) {
                    BookingsInitial() || BookingsLoading() => _LoadingState(),
                    BookingsLoaded(
                      :final upcoming,
                      :final past,
                      :final selectedTab,
                    ) =>
                      _LoadedContent(
                        upcoming: upcoming,
                        past: past,
                        selectedTab: selectedTab,
                        onTabChanged: (tab) =>
                            context.read<BookingsCubit>().selectTab(tab),
                      ),
                    BookingsError(:final message) =>
                      _ErrorState(message: message),
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class _LoadingState extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.6,
      child: const Center(
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(AppColors.goldPure),
          strokeWidth: 2,
        ),
      ),
    );
  }
}

class _LoadedContent extends StatelessWidget {
  const _LoadedContent({
    required this.upcoming,
    required this.past,
    required this.selectedTab,
    required this.onTabChanged,
  });

  final List<BookingModel> upcoming;
  final List<BookingModel> past;
  final int selectedTab;
  final ValueChanged<int> onTabChanged;

  @override
  Widget build(BuildContext context) {
    final hasBookings = upcoming.isNotEmpty || past.isNotEmpty;

    if (!hasBookings) {
      return _FullEmptyState();
    }

    return BookingsListSection(
      upcoming: upcoming,
      past: past,
      selectedTab: selectedTab,
      onTabChanged: onTabChanged,
    );
  }
}

class _FullEmptyState extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final l = context.l10n;
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.65,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.navyLight,
              border: Border.all(color: AppColors.glassBorder),
            ),
            child: const Icon(
              Icons.flight_rounded,
              size: 48,
              color: AppColors.textMuted,
            ),
          )
              .animate()
              .scale(
                begin: const Offset(0.8, 0.8),
                end: const Offset(1, 1),
                duration: 400.ms,
                curve: Curves.easeOutBack,
              ),
          const SizedBox(height: 20),
          Text(
            l.bookingsNoBookingsYet,
            style: GoogleFonts.inter(
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: AppColors.textPrimary,
            ),
          ).animate().fadeIn(duration: 300.ms, delay: 150.ms),
          const SizedBox(height: 8),
          Text(
            l.bookingsEmptySubtitle,
            style: GoogleFonts.inter(
              fontSize: 14,
              color: AppColors.textMuted,
              height: 1.5,
            ),
            textAlign: TextAlign.center,
          ).animate().fadeIn(duration: 300.ms, delay: 250.ms),
          const SizedBox(height: 28),
          GestureDetector(
            onTap: () => context.go(AppRoutes.home),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 14),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [AppColors.goldDim, AppColors.goldPure],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(14),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.goldPure.withValues(alpha: 0.3),
                    blurRadius: 16,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Text(
                l.bookingsFindFlights,
                style: GoogleFonts.inter(
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  color: AppColors.navyDeep,
                ),
              ),
            ),
          )
              .animate()
              .fadeIn(duration: 300.ms, delay: 350.ms)
              .slideY(begin: 0.1, end: 0, duration: 300.ms, delay: 350.ms),
        ],
      ),
    );
  }
}

class _ErrorState extends StatelessWidget {
  const _ErrorState({required this.message});
  final String message;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.5,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline_rounded,
                color: AppColors.error, size: 48),
            const SizedBox(height: 12),
            Text(
              message,
              style: GoogleFonts.inter(color: AppColors.textSecondary),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
