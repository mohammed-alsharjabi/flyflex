import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../data/models/booking_model.dart';
import '../widgets/booking_card.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/utils/l10n_extension.dart';

class BookingsListSection extends StatelessWidget {
  const BookingsListSection({
    super.key,
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
    final l = context.l10n;
    final bookings = selectedTab == 0 ? upcoming : past;
    final emptyMsg = selectedTab == 0 ? l.bookingsNoUpcoming : l.bookingsNoPast;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _TabBar(selectedTab: selectedTab, onTabChanged: onTabChanged, upcoming: upcoming, past: past),
        const SizedBox(height: 20),
        AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          switchInCurve: Curves.easeOutCubic,
          switchOutCurve: Curves.easeInCubic,
          transitionBuilder: (child, animation) => FadeTransition(
            opacity: animation,
            child: SlideTransition(
              position: Tween<Offset>(begin: const Offset(0.05, 0), end: Offset.zero).animate(animation),
              child: child,
            ),
          ),
          child: bookings.isEmpty
              ? _EmptyState(key: ValueKey('empty_$selectedTab'), message: emptyMsg)
              : _BookingList(key: ValueKey('list_$selectedTab'), bookings: bookings),
        ),
      ],
    );
  }
}

class _TabBar extends StatelessWidget {
  const _TabBar({
    required this.selectedTab,
    required this.onTabChanged,
    required this.upcoming,
    required this.past,
  });

  final int selectedTab;
  final ValueChanged<int> onTabChanged;
  final List<BookingModel> upcoming;
  final List<BookingModel> past;

  @override
  Widget build(BuildContext context) {
    final l = context.l10n;
    return Row(
      children: [
        _TabChip(
          label: l.bookingsUpcoming(upcoming.length),
          selected: selectedTab == 0,
          onTap: () => onTabChanged(0),
        ),
        const SizedBox(width: 12),
        _TabChip(
          label: l.bookingsPast(past.length),
          selected: selectedTab == 1,
          onTap: () => onTabChanged(1),
        ),
      ],
    );
  }
}

class _TabChip extends StatelessWidget {
  const _TabChip({required this.label, required this.selected, required this.onTap});

  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
        decoration: BoxDecoration(
          color: selected ? AppColors.goldPure.withValues(alpha: 0.12) : Colors.transparent,
          borderRadius: BorderRadius.circular(50),
          border: Border.all(
            color: selected ? AppColors.goldPure.withValues(alpha: 0.6) : AppColors.glassBorder,
          ),
        ),
        child: Text(
          label,
          style: GoogleFonts.inter(
            fontSize: 13,
            fontWeight: selected ? FontWeight.w700 : FontWeight.w400,
            color: selected ? AppColors.goldPure : AppColors.textMuted,
          ),
        ),
      ),
    );
  }
}

class _BookingList extends StatelessWidget {
  const _BookingList({super.key, required this.bookings});

  final List<BookingModel> bookings;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: bookings.length,
      itemBuilder: (_, i) => BookingCard(
        booking: bookings[i],
        animationDelay: Duration(milliseconds: i * 80),
      ),
    );
  }
}

class _EmptyState extends StatelessWidget {
  const _EmptyState({super.key, required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.flight_outlined, size: 48, color: AppColors.textHint),
            const SizedBox(height: 12),
            Text(
              message,
              style: GoogleFonts.inter(fontSize: 15, color: AppColors.textMuted),
            ),
          ],
        ),
      ),
    );
  }
}
