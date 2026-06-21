import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:fly_flex/core/theme/app_colors.dart';

class SeatRowLabel extends StatelessWidget {
  const SeatRowLabel({
    super.key,
    required this.row,
    this.isHighlighted = false,
  });

  final int row;
  final bool isHighlighted;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 28,
      child: Text(
        '$row',
        style: GoogleFonts.inter(
          fontSize: 10,
          fontWeight: FontWeight.w500,
          color: isHighlighted ? AppColors.goldPure : AppColors.textMuted,
          letterSpacing: 0.2,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}
