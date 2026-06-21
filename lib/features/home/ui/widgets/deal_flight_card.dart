import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../flights/data/models/flight_model.dart';
import '../../../../core/router/app_router.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_radius.dart';
import '../../../../core/utils/l10n_extension.dart';
import '../../../../core/utils/model_localization.dart';

class DealFlightCard extends StatefulWidget {
  const DealFlightCard({
    super.key,
    required this.flight,
    this.index = 0,
  });

  final FlightModel flight;
  final int index;

  @override
  State<DealFlightCard> createState() => _DealFlightCardState();
}

class _DealFlightCardState extends State<DealFlightCard>
    with SingleTickerProviderStateMixin {
  late final AnimationController _press;

  @override
  void initState() {
    super.initState();
    _press = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 100),
      lowerBound: 0.96,
      upperBound: 1.0,
      value: 1.0,
    );
  }

  @override
  void dispose() {
    _press.dispose();
    super.dispose();
  }

  String _formatTime(DateTime dt) {
    final h = dt.hour.toString().padLeft(2, '0');
    final m = dt.minute.toString().padLeft(2, '0');
    return '$h:$m';
  }

  @override
  Widget build(BuildContext context) {
    final flight = widget.flight;
    final savings = flight.originalPrice - flight.price;
    final savingsPct = flight.discountPercent.toInt();

    return AnimatedBuilder(
      animation: _press,
      builder: (context, child) => Transform.scale(
        scale: _press.value,
        child: child,
      ),
      child: GestureDetector(
        onTapDown: (_) => _press.reverse(),
        onTapUp: (_) {
          _press.forward();
          context.push(AppRoutes.flightDetails, extra: flight);
        },
        onTapCancel: () => _press.forward(),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(AppRadius.xl),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
            child: Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: AppColors.glassSurface,
                borderRadius: BorderRadius.circular(AppRadius.xl),
                border: Border.all(
                  color: flight.isAlmostFull
                      ? AppColors.goldPure.withValues(alpha: 0.35)
                      : AppColors.glassBorder,
                ),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.navyDeep.withValues(alpha: 0.4),
                    blurRadius: 20,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _CardTop(flight: flight, savingsPct: savingsPct),
                  const SizedBox(height: 18),
                  _RouteRow(
                    flight: flight,
                    formatTime: _formatTime,
                  ),
                  const SizedBox(height: 18),
                  const _Divider(),
                  const SizedBox(height: 14),
                  _PriceRow(
                    flight: flight,
                    savings: savings,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    )
        .animate()
        .fadeIn(
          delay: Duration(milliseconds: 200 + widget.index * 100),
          duration: 500.ms,
        )
        .slideY(
          begin: 0.1,
          end: 0,
          delay: Duration(milliseconds: 200 + widget.index * 100),
          curve: Curves.easeOutCubic,
        );
  }
}

class _CardTop extends StatelessWidget {
  const _CardTop({required this.flight, required this.savingsPct});
  final FlightModel flight;
  final int savingsPct;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _AirlineBadge(airline: flight.airline, code: flight.airlineCode),
        const Spacer(),
        if (flight.isAlmostFull)
          _HotBadge(seats: flight.availableSeats),
        const SizedBox(width: 8),
        _SavingsBadge(savingsPct: savingsPct),
      ],
    );
  }
}

class _AirlineBadge extends StatelessWidget {
  const _AirlineBadge({required this.airline, required this.code});
  final String airline;
  final String code;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 38,
          height: 38,
          decoration: BoxDecoration(
            color: AppColors.navyMid,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: AppColors.glassBorder),
          ),
          child: Center(
            child: Text(
              code,
              style: GoogleFonts.inter(
                fontSize: 11,
                fontWeight: FontWeight.w800,
                color: AppColors.goldPure,
              ),
            ),
          ),
        ),
        const SizedBox(width: 10),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              airline,
              style: GoogleFonts.inter(
                fontSize: 14,
                fontWeight: FontWeight.w700,
                color: AppColors.textPrimary,
              ),
            ),
            Text(
              context.l10n.flightsAirlines,
              style: GoogleFonts.inter(
                fontSize: 11,
                color: AppColors.textMuted,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _HotBadge extends StatelessWidget {
  const _HotBadge({required this.seats});
  final int seats;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: AppColors.error.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(
          color: AppColors.error.withValues(alpha: 0.35),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.local_fire_department_rounded,
              color: AppColors.error, size: 13),
          const SizedBox(width: 3),
          Text(
            context.l10n.flightsSeatsLeft(seats),
            style: GoogleFonts.inter(
              fontSize: 11,
              fontWeight: FontWeight.w700,
              color: AppColors.error,
            ),
          ),
        ],
      ),
    );
  }
}

class _SavingsBadge extends StatelessWidget {
  const _SavingsBadge({required this.savingsPct});
  final int savingsPct;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [AppColors.goldPure, AppColors.goldDark],
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        '-$savingsPct%',
        style: GoogleFonts.inter(
          fontSize: 13,
          fontWeight: FontWeight.w800,
          color: AppColors.navyDeep,
        ),
      ),
    );
  }
}

class _RouteRow extends StatelessWidget {
  const _RouteRow({
    required this.flight,
    required this.formatTime,
  });
  final FlightModel flight;
  final String Function(DateTime) formatTime;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _RoutePoint(
          code: flight.fromCode,
          city: flight.fromCity,
          time: formatTime(flight.departureTime),
          align: CrossAxisAlignment.start,
        ),
        Expanded(child: _FlightPath(duration: flight.durationFormatted)),
        _RoutePoint(
          code: flight.toCode,
          city: flight.toCity,
          time: formatTime(flight.arrivalTime),
          align: CrossAxisAlignment.end,
        ),
      ],
    );
  }
}

class _RoutePoint extends StatelessWidget {
  const _RoutePoint({
    required this.code,
    required this.city,
    required this.time,
    required this.align,
  });
  final String code;
  final String city;
  final String time;
  final CrossAxisAlignment align;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: align,
      children: [
        Text(
          time,
          style: GoogleFonts.inter(
            fontSize: 22,
            fontWeight: FontWeight.w800,
            color: AppColors.textPrimary,
            letterSpacing: -0.5,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          code,
          style: GoogleFonts.inter(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: AppColors.goldPure,
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

class _FlightPath extends StatelessWidget {
  const _FlightPath({required this.duration});
  final String duration;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          duration,
          style: GoogleFonts.inter(
            fontSize: 11,
            color: AppColors.textSecondary,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 6),
        Row(
          children: [
            Expanded(
              child: Container(
                height: 1,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      AppColors.glassBorder,
                      AppColors.goldPure,
                    ],
                  ),
                ),
              ),
            ),
            const Icon(
              Icons.flight_rounded,
              color: AppColors.goldPure,
              size: 18,
            ),
            Expanded(
              child: Container(
                height: 1,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      AppColors.goldPure,
                      AppColors.glassBorder,
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 6),
        Text(
          context.l10n.flightDetailsNonStop,
          style: GoogleFonts.inter(
            fontSize: 10,
            color: AppColors.textMuted,
          ),
        ),
      ],
    );
  }
}

class _Divider extends StatelessWidget {
  const _Divider();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(
        40,
        (i) => Expanded(
          child: Container(
            height: 1,
            color: i.isEven ? AppColors.glassBorder : Colors.transparent,
          ),
        ),
      ),
    );
  }
}

class _PriceRow extends StatelessWidget {
  const _PriceRow({
    required this.flight,
    required this.savings,
  });
  final FlightModel flight;
  final double savings;

  @override
  Widget build(BuildContext context) {
    final l = context.l10n;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              l.homeYouSave(savings.toStringAsFixed(0)),
              style: GoogleFonts.inter(
                fontSize: 11,
                color: AppColors.success,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              localizedCurrency(context, flight.originalPrice),
              style: GoogleFonts.inter(
                fontSize: 13,
                color: AppColors.textMuted,
                decoration: TextDecoration.lineThrough,
                decorationColor: AppColors.textMuted,
              ),
            ),
          ],
        ),
        const Spacer(),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              localizedCurrency(context, flight.price),
              style: GoogleFonts.inter(
                fontSize: 26,
                fontWeight: FontWeight.w900,
                color: AppColors.goldPure,
                letterSpacing: -1,
              ),
            ),
            Text(
              flight.cabinClass.localizedName(context),
              style: GoogleFonts.inter(
                fontSize: 11,
                color: AppColors.textSecondary,
              ),
            ),
          ],
        ),
        const SizedBox(width: 12),
        Container(
          padding: const EdgeInsets.all(10),
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [AppColors.goldPure, AppColors.goldDark],
            ),
            shape: BoxShape.circle,
          ),
          child: const Icon(
            Icons.arrow_forward_rounded,
            color: AppColors.navyDeep,
            size: 18,
          ),
        ),
      ],
    );
  }
}
