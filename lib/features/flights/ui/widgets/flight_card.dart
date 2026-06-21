import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:fly_flex/core/utils/l10n_extension.dart';
import 'package:fly_flex/core/utils/model_localization.dart';
import '../../data/models/flight_model.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_radius.dart';
import '../../../../core/router/app_router.dart';
import 'airline_badge.dart';

class FlightCard extends StatefulWidget {
  const FlightCard({super.key, required this.flight, this.index = 0});

  final FlightModel flight;
  final int index;

  @override
  State<FlightCard> createState() => _FlightCardState();
}

class _FlightCardState extends State<FlightCard>
    with SingleTickerProviderStateMixin {
  late final AnimationController _press;

  @override
  void initState() {
    super.initState();
    _press = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 100),
      lowerBound: 0.97,
      upperBound: 1.0,
      value: 1.0,
    );
  }

  @override
  void dispose() {
    _press.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Animate(
      effects: [
        FadeEffect(
          delay: Duration(milliseconds: widget.index * 80),
          duration: const Duration(milliseconds: 400),
        ),
        SlideEffect(
          delay: Duration(milliseconds: widget.index * 80),
          duration: const Duration(milliseconds: 400),
          begin: const Offset(0, 0.12),
          end: Offset.zero,
          curve: Curves.easeOutCubic,
        ),
      ],
      child: AnimatedBuilder(
        animation: _press,
        builder: (context, child) =>
            Transform.scale(scale: _press.value, child: child),
        child: GestureDetector(
          onTapDown: (_) => _press.reverse(),
          onTapUp: (_) {
            _press.forward();
            context.push(AppRoutes.flightDetails, extra: widget.flight);
          },
          onTapCancel: () => _press.forward(),
          child: Container(
            margin: const EdgeInsets.only(bottom: 16),
            child: ClipRRect(
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
                      _TopRow(flight: widget.flight),
                      const SizedBox(height: 16),
                      _RouteRow(flight: widget.flight),
                      const SizedBox(height: 16),
                      _BottomRow(flight: widget.flight),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _TopRow extends StatelessWidget {
  const _TopRow({required this.flight});
  final FlightModel flight;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        AirlineBadge(code: flight.airlineCode),
        const SizedBox(width: 8),
        Text(
          flight.airline,
          style: GoogleFonts.inter(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: AppColors.textSecondary,
          ),
        ),
        const Spacer(),
        _CabinChip(cabin: flight.cabinClass),
        const SizedBox(width: 8),
        _SavingsBadge(percent: flight.discountPercent),
      ],
    );
  }
}

class _CabinChip extends StatelessWidget {
  const _CabinChip({required this.cabin});
  final CabinClass cabin;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: AppColors.glassOverlay,
        borderRadius: BorderRadius.circular(50),
        border: Border.all(color: AppColors.glassBorder),
      ),
      child: Text(
        cabin.localizedName(context),
        style: GoogleFonts.inter(
          fontSize: 11,
          fontWeight: FontWeight.w500,
          color: AppColors.textSecondary,
        ),
      ),
    );
  }
}

class _SavingsBadge extends StatelessWidget {
  const _SavingsBadge({required this.percent});
  final double percent;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [AppColors.goldDark, AppColors.goldPure],
        ),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        '-${percent.toInt()}%',
        style: GoogleFonts.inter(
          fontSize: 11,
          fontWeight: FontWeight.w700,
          color: AppColors.navyDeep,
        ),
      ),
    );
  }
}

class _RouteRow extends StatelessWidget {
  const _RouteRow({required this.flight});
  final FlightModel flight;

  String _fmt(DateTime dt) {
    final h = dt.hour.toString().padLeft(2, '0');
    final m = dt.minute.toString().padLeft(2, '0');
    return '$h:$m';
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _CityCode(
          code: flight.fromCode,
          city: flight.fromCity,
          time: _fmt(flight.departureTime),
          alignLeft: true,
        ),
        Expanded(child: _FlightLine(flight: flight)),
        _CityCode(
          code: flight.toCode,
          city: flight.toCity,
          time: _fmt(flight.arrivalTime),
          alignLeft: false,
        ),
      ],
    );
  }
}

class _CityCode extends StatelessWidget {
  const _CityCode({
    required this.code,
    required this.city,
    required this.time,
    required this.alignLeft,
  });

  final String code, city, time;
  final bool alignLeft;

  @override
  Widget build(BuildContext context) {
    final align =
        alignLeft ? CrossAxisAlignment.start : CrossAxisAlignment.end;
    return Column(
      crossAxisAlignment: align,
      children: [
        Text(
          time,
          style: GoogleFonts.inter(
            fontSize: 24,
            fontWeight: FontWeight.w800,
            color: AppColors.textPrimary,
            letterSpacing: -0.5,
          ),
        ),
        Text(
          code,
          style: GoogleFonts.inter(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: AppColors.goldPure,
            letterSpacing: 1.2,
          ),
        ),
        Text(
          city,
          style: GoogleFonts.inter(
            fontSize: 11,
            color: AppColors.textMuted,
          ),
        ),
      ],
    );
  }
}

class _FlightLine extends StatelessWidget {
  const _FlightLine({required this.flight});
  final FlightModel flight;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          flight.durationFormatted,
          style: GoogleFonts.inter(
            fontSize: 11,
            fontWeight: FontWeight.w500,
            color: AppColors.textMuted,
          ),
        ),
        const SizedBox(height: 4),
        Row(
          children: [
            Expanded(
              child: Container(
                height: 1,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      AppColors.glassBorder,
                      AppColors.goldPure.withValues(alpha: 0.5),
                    ],
                  ),
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 6),
              child: Icon(Icons.flight, color: AppColors.goldPure, size: 18),
            ),
            Expanded(
              child: Container(
                height: 1,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      AppColors.goldPure.withValues(alpha: 0.5),
                      AppColors.glassBorder,
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 4),
        Text(
          flight.stops == 0
              ? context.l10n.flightsDirect
              : context.l10n.flightsStop(flight.stops),
          style: GoogleFonts.inter(
            fontSize: 10,
            color: flight.stops == 0 ? AppColors.success : AppColors.warning,
          ),
        ),
      ],
    );
  }
}

class _BottomRow extends StatelessWidget {
  const _BottomRow({required this.flight});
  final FlightModel flight;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        if (flight.isAlmostFull)
          _SeatsBadge(
            label:
                '🔥 ${context.l10n.flightsSeatsLeftFull(flight.availableSeats)}',
            color: AppColors.error,
            bg: AppColors.errorLight,
          )
        else
          _SeatsBadge(
            label: context.l10n.flightsSeatsLeftFull(flight.availableSeats),
            color: AppColors.info,
            bg: AppColors.infoLight,
          ),
        const Spacer(),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              '${context.l10n.flightsCurrency} ${flight.originalPrice.toInt()}',
              style: GoogleFonts.inter(
                fontSize: 11,
                color: AppColors.textMuted,
                decoration: TextDecoration.lineThrough,
              ),
            ),
            Text(
              '${context.l10n.flightsCurrency} ${flight.price.toInt()}',
              style: GoogleFonts.inter(
                fontSize: 22,
                fontWeight: FontWeight.w800,
                color: AppColors.goldPure,
                letterSpacing: -0.5,
              ),
            ),
          ],
        ),
        const SizedBox(width: 12),
        Container(
          width: 36,
          height: 36,
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [AppColors.goldDark, AppColors.goldPure],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(AppRadius.md),
          ),
          child: const Icon(
            Icons.arrow_forward_ios_rounded,
            color: AppColors.navyDeep,
            size: 14,
          ),
        ),
      ],
    );
  }
}

class _SeatsBadge extends StatelessWidget {
  const _SeatsBadge({
    required this.label,
    required this.color,
    required this.bg,
  });

  final String label;
  final Color color, bg;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(50),
      ),
      child: Text(
        label,
        style: GoogleFonts.inter(
          fontSize: 11,
          fontWeight: FontWeight.w600,
          color: color,
        ),
      ),
    );
  }
}
