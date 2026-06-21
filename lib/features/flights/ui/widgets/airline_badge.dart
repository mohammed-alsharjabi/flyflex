import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:fly_flex/core/theme/app_colors.dart';
import 'package:fly_flex/core/theme/app_radius.dart';

class AirlineBadge extends StatelessWidget {
  const AirlineBadge({
    super.key,
    required this.code,
    this.airlineName,
    this.size = 13.0,
  });

  final String code;
  final String? airlineName;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          decoration: BoxDecoration(
            color: AppColors.navyMid,
            borderRadius: BorderRadius.circular(AppRadius.sm),
            border: Border.all(color: AppColors.glassBorder),
          ),
          child: Text(
            code,
            style: GoogleFonts.inter(
              fontSize: size,
              fontWeight: FontWeight.w800,
              color: AppColors.goldPure,
              letterSpacing: 1.5,
            ),
          ),
        ),
        if (airlineName != null) ...[
          const SizedBox(width: 8),
          Text(
            airlineName!,
            style: GoogleFonts.inter(
              fontSize: size,
              fontWeight: FontWeight.w500,
              color: AppColors.textSecondary,
            ),
          ),
        ],
      ],
    );
  }
}
