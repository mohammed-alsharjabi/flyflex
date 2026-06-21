import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:fly_flex/core/theme/app_colors.dart';
import 'package:fly_flex/core/utils/l10n_extension.dart';

class BoardingPassHeader extends StatelessWidget {
  const BoardingPassHeader({
    super.key,
    required this.airline,
    required this.flightNumber,
    required this.status,
  });

  final String airline;
  final String flightNumber;
  final String status;

  @override
  Widget build(BuildContext context) {
    final l = context.l10n;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              l.ticketBoardingPass,
              style: GoogleFonts.inter(
                fontSize: 10,
                fontWeight: FontWeight.w800,
                color: AppColors.goldPure,
                letterSpacing: 3.5,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              '$airline · $flightNumber',
              style: GoogleFonts.inter(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: AppColors.textSecondary,
              ),
            ),
          ],
        ),
        _StatusBadge(status: status),
      ],
    );
  }
}

class _StatusBadge extends StatelessWidget {
  const _StatusBadge({required this.status});

  final String status;

  Color get _color => switch (status) {
        'checked_in' => const Color(0xFF3498DB),
        'boarded' => AppColors.goldPure,
        _ => AppColors.success,
      };

  String _label(BuildContext context) => switch (status) {
        'checked_in' => context.l10n.ticketStatusCheckedIn,
        'boarded' => context.l10n.ticketStatusBoarded,
        _ => context.l10n.ticketStatusConfirmed,
      };

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: _color.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(50),
        border: Border.all(color: _color.withValues(alpha: 0.4)),
      ),
      child: Text(
        _label(context),
        style: GoogleFonts.inter(
          fontSize: 10,
          fontWeight: FontWeight.w800,
          color: _color,
          letterSpacing: 0.5,
        ),
      ),
    );
  }
}
