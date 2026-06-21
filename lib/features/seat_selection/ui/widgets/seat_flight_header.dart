import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:fly_flex/core/theme/app_colors.dart';
import 'package:fly_flex/core/utils/model_localization.dart';
import 'package:fly_flex/core/theme/app_radius.dart';
import 'package:fly_flex/features/flights/data/models/flight_model.dart';

class SeatFlightHeader extends StatelessWidget {
  const SeatFlightHeader({super.key, required this.flight});

  final FlightModel flight;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppRadius.lg),
        border: Border.all(color: AppColors.glassBorder),
        color: AppColors.navyLight.withValues(alpha: 0.25),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _RouteDisplay(
            fromCode: flight.fromCode,
            fromCity: flight.fromCity,
            toCode: flight.toCode,
            toCity: flight.toCity,
          ),
          _InfoPill(icon: Icons.airline_seat_recline_extra_rounded, label: flight.cabinClass.localizedName(context)),
          _InfoPill(icon: Icons.access_time_rounded, label: flight.durationFormatted),
        ],
      ),
    );
  }
}

class _RouteDisplay extends StatelessWidget {
  const _RouteDisplay({
    required this.fromCode,
    required this.fromCity,
    required this.toCode,
    required this.toCity,
  });

  final String fromCode, fromCity, toCode, toCity;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        _CodeCity(code: fromCode, city: fromCity),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 8),
          child: Icon(Icons.arrow_forward_rounded, color: AppColors.goldPure, size: 16),
        ),
        _CodeCity(code: toCode, city: toCity),
      ],
    );
  }
}

class _CodeCity extends StatelessWidget {
  const _CodeCity({required this.code, required this.city});

  final String code, city;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          code,
          style: GoogleFonts.inter(
            fontSize: 18,
            fontWeight: FontWeight.w800,
            color: AppColors.textPrimary,
            letterSpacing: -0.3,
          ),
        ),
        Text(
          city,
          style: GoogleFonts.inter(fontSize: 10, color: AppColors.textMuted),
        ),
      ],
    );
  }
}

class _InfoPill extends StatelessWidget {
  const _InfoPill({required this.icon, required this.label});

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
      decoration: BoxDecoration(
        color: AppColors.glassSurface,
        borderRadius: BorderRadius.circular(AppRadius.chip),
        border: Border.all(color: AppColors.glassBorder),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: AppColors.textMuted, size: 12),
          const SizedBox(width: 4),
          Text(
            label,
            style: GoogleFonts.inter(
              fontSize: 11,
              fontWeight: FontWeight.w500,
              color: AppColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }
}
