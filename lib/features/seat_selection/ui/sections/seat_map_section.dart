import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:fly_flex/core/theme/app_colors.dart';
import 'package:fly_flex/core/utils/l10n_extension.dart';
import 'package:fly_flex/core/theme/app_radius.dart';
import 'package:fly_flex/core/widgets/shimmer_loading.dart';
import 'package:fly_flex/features/seat_selection/data/models/seat_model.dart';
import 'package:fly_flex/features/seat_selection/logic/cubit/seat_cubit.dart';
import 'package:fly_flex/features/seat_selection/logic/state/seat_state.dart';
import 'package:fly_flex/features/seat_selection/ui/widgets/seat_row_label.dart';
import 'package:fly_flex/features/seat_selection/ui/widgets/seat_widget.dart';

class SeatMapSection extends StatelessWidget {
  const SeatMapSection({super.key});

  static const _cols = ['A', 'B', 'C', 'D', 'E', 'F'];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SeatCubit, SeatState>(
      builder: (context, state) => switch (state) {
        SeatLoading() => Column(
            children: List.generate(8, (_) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: ShimmerBox(width: double.infinity, height: 40),
            )),
          ),
        SeatError(:final message) => Center(
            child: Column(mainAxisSize: MainAxisSize.min, children: [
              const Icon(Icons.error_outline, color: AppColors.error, size: 44),
              const SizedBox(height: 10),
              Text(message, style: GoogleFonts.inter(fontSize: 13, color: AppColors.textSecondary), textAlign: TextAlign.center),
            ]),
          ),
        SeatLoaded(:final seats) => _buildMap(context, seats),
        _ => const SizedBox.shrink(),
      },
    );
  }

  Widget _buildMap(BuildContext context, List<SeatModel> seats) {
    final l = context.l10n;
    final byRow = <int, List<SeatModel>>{};
    for (final s in seats) {
      byRow.putIfAbsent(s.row, () => []).add(s);
    }
    final rows = byRow.keys.toList()..sort();

    return Column(children: [
      _AircraftNose(),
      const SizedBox(height: 10),
      _ColHeaders(cols: _cols),
      const SizedBox(height: 6),
      ...rows.map((row) {
        final rowSeats = byRow[row]!..sort((a, b) => a.column.compareTo(b.column));
        return Column(children: [
          if (row == 1) _SectionHeader(label: l.seatFirstClass.toUpperCase(), icon: Icons.star_rounded),
          if (row == 5) _SectionHeader(label: l.seatBusiness.toUpperCase(), icon: Icons.business_center_rounded),
          if (row == 16) _SectionHeader(label: l.seatEconomy.toUpperCase(), icon: Icons.airline_seat_recline_normal_rounded),
          _SeatRow(row: row, seats: rowSeats, context: context),
        ]);
      }),
      const SizedBox(height: 16),
      _AircraftTail(),
    ]).animate().fadeIn(duration: 400.ms).slideY(begin: 0.05, end: 0);
  }
}

class _AircraftNose extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Container(
        width: 76, height: 76,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: const RadialGradient(colors: [AppColors.navyLight, AppColors.navyMid]),
          border: Border.all(color: AppColors.glassBorder, width: 1.5),
        ),
        child: const Icon(Icons.flight_rounded, color: AppColors.goldPure, size: 34),
      ),
      Container(width: 2, height: 14, decoration: const BoxDecoration(
        gradient: LinearGradient(begin: Alignment.topCenter, end: Alignment.bottomCenter,
          colors: [AppColors.glassBorder, Colors.transparent]),
      )),
    ]);
  }
}

class _AircraftTail extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Container(width: 2, height: 14, decoration: const BoxDecoration(
        gradient: LinearGradient(begin: Alignment.topCenter, end: Alignment.bottomCenter,
          colors: [Colors.transparent, AppColors.glassBorder]),
      )),
      Container(
        width: 54, height: 18,
        decoration: BoxDecoration(
          color: AppColors.navyMid,
          borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(27), bottomRight: Radius.circular(27)),
          border: Border.all(color: AppColors.glassBorder),
        ),
      ),
    ]);
  }
}

class _ColHeaders extends StatelessWidget {
  const _ColHeaders({required this.cols});

  final List<String> cols;

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      const SizedBox(width: 28),
      ...cols.asMap().entries.map((e) => Row(children: [
        SizedBox(width: 36, child: Center(
          child: Text(e.value, style: GoogleFonts.inter(
            fontSize: 11, fontWeight: FontWeight.w700,
            color: AppColors.textMuted, letterSpacing: 1.0)),
        )),
        if (e.key == 2) const SizedBox(width: 16) else if (e.key < 5) const SizedBox(width: 4),
      ])),
    ]);
  }
}

class _SectionHeader extends StatelessWidget {
  const _SectionHeader({required this.label, required this.icon});

  final String label;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(children: [
        Expanded(child: Container(height: 1, color: AppColors.glassBorder)),
        const SizedBox(width: 10),
        Icon(icon, color: AppColors.goldPure, size: 13),
        const SizedBox(width: 6),
        Text(label, style: GoogleFonts.inter(
          fontSize: 9, fontWeight: FontWeight.w700,
          color: AppColors.goldPure, letterSpacing: 1.3)),
        const SizedBox(width: 10),
        Expanded(child: Container(height: 1, color: AppColors.glassBorder)),
      ]),
    );
  }
}

class _SeatRow extends StatelessWidget {
  const _SeatRow({required this.row, required this.seats, required this.context});

  final int row;
  final List<SeatModel> seats;
  final BuildContext context;

  @override
  Widget build(BuildContext ctx) {
    final isFirst = row <= 4;
    final isBusiness = row >= 5 && row <= 15;
    Color? bg;
    if (isFirst) bg = AppColors.goldPure.withValues(alpha: 0.05);
    if (isBusiness) bg = AppColors.seatPremium.withValues(alpha: 0.04);

    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      margin: const EdgeInsets.only(bottom: 4),
      padding: EdgeInsets.symmetric(vertical: (isFirst || isBusiness) ? 5 : 3, horizontal: 4),
      decoration: bg != null ? BoxDecoration(color: bg, borderRadius: BorderRadius.circular(AppRadius.sm)) : null,
      child: Row(children: [
        SeatRowLabel(row: row, isHighlighted: isFirst || isBusiness),
        ...seats.asMap().entries.map((e) => Row(children: [
          SeatWidget(seat: e.value, onTap: (s) => context.read<SeatCubit>().selectSeat(s)),
          if (e.key == 2) const SizedBox(width: 16) else if (e.key < 5) const SizedBox(width: 4),
        ])),
      ]),
    );
  }
}
