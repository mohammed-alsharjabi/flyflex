import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/utils/l10n_extension.dart';
import '../../data/models/flight_details_model.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_radius.dart';

class FlightInfoSection extends StatelessWidget {
  const FlightInfoSection({super.key, required this.details});

  final FlightDetailsModel details;

  @override
  Widget build(BuildContext context) {
    final l = context.l10n;
    return ClipRRect(
      borderRadius: AppRadius.cardBorderRadius,
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: AppColors.glassSurface,
            borderRadius: AppRadius.cardBorderRadius,
            border: Border.all(color: AppColors.glassBorder),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _SectionTitle(title: l.flightDetailsInfo),
              const SizedBox(height: 16),
              _InfoRow(
                icon: Icons.flight_rounded,
                label: l.flightDetailsAircraft,
                value: details.aircraftType,
              ),
              _InfoRow(
                icon: Icons.flight_takeoff_rounded,
                label: l.flightDetailsDepartureTerminal,
                value: details.departureTerminal,
              ),
              _InfoRow(
                icon: Icons.flight_land_rounded,
                label: l.flightDetailsArrivalTerminal,
                value: details.arrivalTerminal,
              ),
              _InfoRow(
                icon: Icons.luggage_rounded,
                label: l.flightDetailsBaggage,
                value: details.baggageInfo,
              ),
              _InfoRow(
                icon: Icons.schedule_rounded,
                label: l.flightDetailsOnTime,
                value: '${details.onTimeRate}%',
                valueColor: details.onTimeRate >= 90
                    ? AppColors.success
                    : AppColors.warning,
              ),
              _InfoRow(
                icon: Icons.policy_rounded,
                label: l.flightDetailsRefund,
                value: details.refundPolicy,
                valueColor: details.isRefundable
                    ? AppColors.success
                    : AppColors.error,
                isLast: true,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  const _SectionTitle({required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 3,
          height: 18,
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: AppColors.goldGradient,
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
            borderRadius: BorderRadius.circular(AppRadius.xs),
          ),
        ),
        const SizedBox(width: 10),
        Text(
          title,
          style: GoogleFonts.inter(
            fontSize: 15,
            fontWeight: FontWeight.w700,
            color: AppColors.textPrimary,
          ),
        ),
      ],
    );
  }
}

class _InfoRow extends StatelessWidget {
  const _InfoRow({
    required this.icon,
    required this.label,
    required this.value,
    this.valueColor,
    this.isLast = false,
  });

  final IconData icon;
  final String label;
  final String value;
  final Color? valueColor;
  final bool isLast;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Row(
            children: [
              Container(
                width: 34,
                height: 34,
                decoration: BoxDecoration(
                  color: AppColors.goldPure.withValues(alpha: 0.08),
                  borderRadius: BorderRadius.circular(AppRadius.sm),
                ),
                child: Icon(icon, color: AppColors.goldPure, size: 16),
              ),
              const SizedBox(width: 12),
              Text(
                label,
                style: GoogleFonts.inter(
                  fontSize: 13,
                  color: AppColors.textMuted,
                ),
              ),
              const Spacer(),
              Flexible(
                child: Text(
                  value,
                  textAlign: TextAlign.end,
                  style: GoogleFonts.inter(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: valueColor ?? AppColors.textSecondary,
                  ),
                ),
              ),
            ],
          ),
        ),
        if (!isLast) const Divider(color: AppColors.glassBorder, height: 1),
      ],
    );
  }
}
