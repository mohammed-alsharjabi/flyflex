import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_radius.dart';

class AmenityChip extends StatelessWidget {
  const AmenityChip({super.key, required this.label});

  final String label;

  IconData _iconFor(String label) {
    final l = label.toLowerCase();
    if (l.contains('wi-fi') || l.contains('wifi')) return Icons.wifi_rounded;
    if (l.contains('meal') || l.contains('dining') || l.contains('carte')) {
      return Icons.restaurant_rounded;
    }
    if (l.contains('lounge')) return Icons.local_bar_rounded;
    if (l.contains('bed') || l.contains('flat')) return Icons.bed_rounded;
    if (l.contains('entertainment')) return Icons.movie_rounded;
    if (l.contains('chauffeur')) return Icons.directions_car_rounded;
    if (l.contains('spa')) return Icons.spa_rounded;
    if (l.contains('legroom') ||
        l.contains('seat') ||
        l.contains('recline')) {
      return Icons.airline_seat_recline_extra_rounded;
    }
    if (l.contains('bag') || l.contains('carry')) return Icons.luggage_rounded;
    if (l.contains('kit') || l.contains('luxury')) {
      return Icons.card_giftcard_rounded;
    }
    if (l.contains('usb') || l.contains('charging')) return Icons.usb_rounded;
    if (l.contains('boarding') || l.contains('priority')) {
      return Icons.airplane_ticket_rounded;
    }
    return Icons.check_circle_outline_rounded;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: AppColors.goldPure.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(AppRadius.chip),
        border: Border.all(color: AppColors.goldPure.withValues(alpha: 0.25)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(_iconFor(label), color: AppColors.goldPure, size: 14),
          const SizedBox(width: 6),
          Text(
            label,
            style: GoogleFonts.inter(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: AppColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }
}
