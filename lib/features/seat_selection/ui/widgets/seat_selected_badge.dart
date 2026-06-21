import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:fly_flex/core/theme/app_colors.dart';
import 'package:fly_flex/core/utils/l10n_extension.dart';
import 'package:fly_flex/core/utils/model_localization.dart';
import 'package:fly_flex/core/theme/app_radius.dart';
import 'package:fly_flex/features/seat_selection/data/models/seat_model.dart';

class SeatSelectedBadge extends StatelessWidget {
  const SeatSelectedBadge({
    super.key,
    required this.seat,
    required this.totalPrice,
  });

  final SeatModel seat;
  final double totalPrice;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        color: AppColors.goldPure.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(AppRadius.md),
        border: Border.all(color: AppColors.goldPure.withValues(alpha: 0.35)),
      ),
      child: Row(
        children: [
          _SeatChip(seat: seat),
          const SizedBox(width: 12),
          Expanded(child: _SeatInfo(seat: seat)),
          _PriceDisplay(totalPrice: totalPrice),
        ],
      ),
    );
  }
}

class _SeatChip extends StatelessWidget {
  const _SeatChip({required this.seat});

  final SeatModel seat;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 38,
      height: 34,
      decoration: BoxDecoration(
        color: AppColors.seatSelected,
        borderRadius: BorderRadius.circular(6),
        boxShadow: [
          BoxShadow(
            color: AppColors.goldPure.withValues(alpha: 0.45),
            blurRadius: 8,
            spreadRadius: 1,
          ),
        ],
      ),
      child: Center(
        child: Text(
          seat.label,
          style: GoogleFonts.inter(
            fontSize: 10,
            fontWeight: FontWeight.w800,
            color: AppColors.navyDeep,
          ),
        ),
      ),
    );
  }
}

class _SeatInfo extends StatelessWidget {
  const _SeatInfo({required this.seat});

  final SeatModel seat;

  @override
  Widget build(BuildContext context) {
    final l = context.l10n;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          l.seatSelectedLabel(seat.label),
          style: GoogleFonts.inter(
            fontSize: 14,
            fontWeight: FontWeight.w700,
            color: AppColors.textPrimary,
          ),
        ),
        Text(
          seat.extraCharge > 0
              ? '${seat.localizedCabinName(context)} · ${l.seatExtraCharge(seat.extraCharge.toStringAsFixed(0))}'
              : seat.localizedCabinName(context),
          style: GoogleFonts.inter(fontSize: 11, color: AppColors.textMuted),
        ),
      ],
    );
  }
}

class _PriceDisplay extends StatelessWidget {
  const _PriceDisplay({required this.totalPrice});

  final double totalPrice;

  @override
  Widget build(BuildContext context) {
    final l = context.l10n;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          localizedCurrency(context, totalPrice),
          style: GoogleFonts.inter(
            fontSize: 18,
            fontWeight: FontWeight.w800,
            color: AppColors.goldPure,
            letterSpacing: -0.3,
          ),
        ),
        Text(
          l.seatTotal,
          style: GoogleFonts.inter(fontSize: 10, color: AppColors.textMuted),
        ),
      ],
    );
  }
}
