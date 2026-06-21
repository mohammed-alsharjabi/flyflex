import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/utils/l10n_extension.dart';
import '../../../flights/data/models/flight_model.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_radius.dart';

class FlightTimelineWidget extends StatelessWidget {
  const FlightTimelineWidget({
    super.key,
    required this.flight,
    required this.boardingTime,
  });

  final FlightModel flight;
  final DateTime boardingTime;

  static String _fmt(DateTime dt) =>
      '${dt.hour.toString().padLeft(2, '0')}:${dt.minute.toString().padLeft(2, '0')}';

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: AppRadius.cardBorderRadius,
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: AppColors.glassSurface,
            borderRadius: AppRadius.cardBorderRadius,
            border: Border.all(color: AppColors.glassBorder),
          ),
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  _AirportColumn(
                    time: _fmt(flight.departureTime),
                    code: flight.fromCode,
                    city: flight.fromCity,
                    align: CrossAxisAlignment.start,
                  ),
                  Expanded(child: _TimelineCenter(flight: flight)),
                  _AirportColumn(
                    time: _fmt(flight.arrivalTime),
                    code: flight.toCode,
                    city: flight.toCity,
                    align: CrossAxisAlignment.end,
                  ),
                ],
              ),
              const SizedBox(height: 16),
              _BoardingPill(time: _fmt(boardingTime)),
            ],
          ),
        ),
      ),
    );
  }
}

class _AirportColumn extends StatelessWidget {
  const _AirportColumn({
    required this.time,
    required this.code,
    required this.city,
    required this.align,
  });

  final String time;
  final String code;
  final String city;
  final CrossAxisAlignment align;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: align,
      children: [
        Text(
          time,
          style: GoogleFonts.inter(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: AppColors.textMuted,
          ),
        ),
        Text(
          code,
          style: GoogleFonts.inter(
            fontSize: 30,
            fontWeight: FontWeight.w900,
            color: AppColors.textPrimary,
            letterSpacing: -1,
          ),
        ),
        Text(
          city,
          style: GoogleFonts.inter(fontSize: 11, color: AppColors.textMuted),
        ),
      ],
    );
  }
}

class _TimelineCenter extends StatelessWidget {
  const _TimelineCenter({required this.flight});

  final FlightModel flight;

  @override
  Widget build(BuildContext context) {
    final l = context.l10n;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: AppColors.glassOverlay,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: AppColors.glassBorder),
            ),
            child: Text(
              flight.durationFormatted,
              style: GoogleFonts.inter(
                fontSize: 11,
                fontWeight: FontWeight.w600,
                color: AppColors.goldLight,
              ),
            ),
          ),
          const SizedBox(height: 6),
          Row(
            children: [
              Expanded(
                child: Container(
                  height: 1.5,
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [AppColors.glassBorderBright, AppColors.goldPure],
                    ),
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 4),
                child: Icon(Icons.flight, color: AppColors.goldPure, size: 20),
              ),
              Expanded(
                child: Container(
                  height: 1.5,
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [AppColors.goldPure, AppColors.glassBorderBright],
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: flight.stops == 0
                  ? AppColors.successLight
                  : AppColors.warningLight,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              flight.stops == 0
                  ? l.flightsDirect
                  : l.flightsStop(flight.stops),
              style: GoogleFonts.inter(
                fontSize: 11,
                fontWeight: FontWeight.w600,
                color:
                    flight.stops == 0 ? AppColors.success : AppColors.warning,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _BoardingPill extends StatelessWidget {
  const _BoardingPill({required this.time});

  final String time;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        color: AppColors.goldPure.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(AppRadius.chip),
        border: Border.all(color: AppColors.goldPure.withValues(alpha: 0.25)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(
            Icons.airline_seat_recline_extra_rounded,
            color: AppColors.goldPure,
            size: 14,
          ),
          const SizedBox(width: 6),
          Text(
            context.l10n.flightDetailsBoardBy(time),
            style: GoogleFonts.inter(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: AppColors.goldLight,
            ),
          ),
        ],
      ),
    );
  }
}
