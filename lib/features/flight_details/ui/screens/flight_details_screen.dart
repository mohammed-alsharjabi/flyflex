import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:fly_flex/core/di/injection.dart';
import 'package:fly_flex/core/router/app_router.dart';
import 'package:fly_flex/core/theme/app_colors.dart';
import 'package:fly_flex/core/theme/app_radius.dart';
import 'package:fly_flex/core/theme/app_typography.dart';
import 'package:fly_flex/core/utils/l10n_extension.dart';
import 'package:fly_flex/core/utils/model_localization.dart';
import 'package:fly_flex/core/widgets/app_button.dart';
import '../../data/models/flight_details_model.dart';
import '../../../flights/data/models/flight_model.dart';
import '../../logic/cubit/flight_details_cubit.dart';
import '../../logic/state/flight_details_state.dart';
import '../sections/flight_info_section.dart';
import '../sections/price_breakdown_section.dart';
import '../widgets/amenity_chip.dart';
import '../widgets/flight_hero_appbar.dart';
import '../widgets/flight_timeline_widget.dart';

class FlightDetailsScreen extends StatelessWidget {
  const FlightDetailsScreen({super.key, required this.flight});

  final FlightModel flight;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<FlightDetailsCubit>()..loadDetails(flight),
      child: _FlightDetailsBody(flight: flight),
    );
  }
}

class _FlightDetailsBody extends StatelessWidget {
  const _FlightDetailsBody({required this.flight});

  final FlightModel flight;

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Scaffold(
        backgroundColor: AppColors.navyDeep,
        extendBodyBehindAppBar: true,
        body: BlocBuilder<FlightDetailsCubit, FlightDetailsState>(
          builder: (context, state) => switch (state) {
            FlightDetailsInitial() ||
            FlightDetailsLoading() =>
              _LoadingBody(flight: flight),
            FlightDetailsLoaded(:final details) =>
              _LoadedBody(details: details),
            FlightDetailsError(:final message) =>
              _ErrorBody(flight: flight, message: message),
          },
        ),
        bottomNavigationBar: BlocBuilder<FlightDetailsCubit, FlightDetailsState>(
          builder: (context, state) {
            if (state is! FlightDetailsLoaded) return const SizedBox.shrink();
            final total =
                flight.price + (flight.price * 0.15).roundToDouble() + 25.0;
            return _StickyBottomBar(flight: flight, total: total);
          },
        ),
      ),
    );
  }
}

// ─── Loaded ────────────────────────────────────────────────────────────────

class _LoadedBody extends StatelessWidget {
  const _LoadedBody({required this.details});

  final FlightDetailsModel details;

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      physics: const BouncingScrollPhysics(),
      slivers: [
        FlightHeroAppBar(flight: details.flight),
        SliverPadding(
          padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
          sliver: SliverList(
            delegate: SliverChildListDelegate([
              FlightTimelineWidget(
                flight: details.flight,
                boardingTime: details.boardingTime,
              )
                  .animate()
                  .fadeIn(duration: 400.ms, delay: 80.ms)
                  .slideY(begin: 0.12, end: 0, duration: 400.ms, delay: 80.ms),
              const SizedBox(height: 14),
              _AmenitiesSection(amenities: details.amenities)
                  .animate()
                  .fadeIn(duration: 400.ms, delay: 160.ms)
                  .slideY(
                      begin: 0.12, end: 0, duration: 400.ms, delay: 160.ms),
              const SizedBox(height: 14),
              FlightInfoSection(details: details)
                  .animate()
                  .fadeIn(duration: 400.ms, delay: 240.ms)
                  .slideY(
                      begin: 0.12, end: 0, duration: 400.ms, delay: 240.ms),
              const SizedBox(height: 14),
              PriceBreakdownSection(flight: details.flight)
                  .animate()
                  .fadeIn(duration: 400.ms, delay: 320.ms)
                  .slideY(
                      begin: 0.12, end: 0, duration: 400.ms, delay: 320.ms),
              if (details.flight.isAlmostFull) ...[
                const SizedBox(height: 14),
                _UrgencyBanner(seats: details.flight.availableSeats)
                    .animate()
                    .fadeIn(duration: 400.ms, delay: 380.ms)
                    .shake(duration: 600.ms, delay: 800.ms, hz: 2),
              ],
              const SizedBox(height: 120),
            ]),
          ),
        ),
      ],
    );
  }
}

// ─── Amenities section ─────────────────────────────────────────────────────

class _AmenitiesSection extends StatelessWidget {
  const _AmenitiesSection({required this.amenities});

  final List<String> amenities;

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
              Row(children: [
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
                  l.flightDetailsAmenities,
                  style: GoogleFonts.inter(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: AppColors.textPrimary,
                  ),
                ),
              ]),
              const SizedBox(height: 14),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: amenities
                    .map((a) => AmenityChip(label: localizedAmenity(context, a)))
                    .toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ─── Urgency banner ────────────────────────────────────────────────────────

class _UrgencyBanner extends StatelessWidget {
  const _UrgencyBanner({required this.seats});

  final int seats;

  @override
  Widget build(BuildContext context) {
    final l = context.l10n;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppColors.error.withValues(alpha: 0.15),
            AppColors.warning.withValues(alpha: 0.10),
          ],
        ),
        borderRadius: BorderRadius.circular(AppRadius.lg),
        border: Border.all(color: AppColors.error.withValues(alpha: 0.4)),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: AppColors.errorLight,
              borderRadius: BorderRadius.circular(AppRadius.md),
            ),
            child: const Icon(Icons.local_fire_department_rounded,
                color: AppColors.error, size: 20),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(l.flightDetailsSellingFast,
                    style: AppTypography.labelLarge.copyWith(
                        color: AppColors.error, fontWeight: FontWeight.w800)),
                const SizedBox(height: 2),
                Text(
                  l.flightDetailsOnlySeatsLeft(seats),
                  style: AppTypography.bodySmall
                      .copyWith(color: AppColors.textSecondary),
                ),
              ],
            ),
          ),
          Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: BoxDecoration(
              color: AppColors.error,
              borderRadius: BorderRadius.circular(AppRadius.chip),
            ),
            child: Text(
              l.flightDetailsSeatsLeft(seats),
              style: AppTypography.labelSmall.copyWith(
                  color: Colors.white, fontWeight: FontWeight.w800),
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Loading ───────────────────────────────────────────────────────────────

class _LoadingBody extends StatelessWidget {
  const _LoadingBody({required this.flight});

  final FlightModel flight;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: const BoxDecoration(
            gradient: RadialGradient(
              center: Alignment(-0.3, -0.8),
              radius: 1.2,
              colors: [AppColors.navyLight, AppColors.navyDeep],
            ),
          ),
        ),
        Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                width: 48,
                height: 48,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor:
                      AlwaysStoppedAnimation(AppColors.goldPure),
                ),
              ),
              SizedBox(height: 16),
              _LoadingMessage(),
            ],
          ),
        ),
      ],
    );
  }
}

// ─── Error ─────────────────────────────────────────────────────────────────

class _ErrorBody extends StatelessWidget {
  const _ErrorBody({required this.flight, required this.message});

  final FlightModel flight;
  final String message;

  @override
  Widget build(BuildContext context) {
    final l = context.l10n;
    return Stack(
      children: [
        Container(
          decoration: const BoxDecoration(
            gradient: RadialGradient(
              center: Alignment(-0.3, -0.8),
              radius: 1.2,
              colors: [AppColors.navyLight, AppColors.navyDeep],
            ),
          ),
        ),
        Center(
          child: Padding(
            padding: const EdgeInsets.all(32),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    color: AppColors.errorLight,
                    shape: BoxShape.circle,
                    border: Border.all(
                        color: AppColors.error.withValues(alpha: 0.3)),
                  ),
                  child: const Icon(Icons.error_outline_rounded,
                      color: AppColors.error, size: 40),
                ),
                const SizedBox(height: 20),
                Text(l.flightDetailsFailedToLoad,
                    style: AppTypography.headlineSmall),
                const SizedBox(height: 8),
                Text(message,
                    style: AppTypography.bodyMedium,
                    textAlign: TextAlign.center),
                const SizedBox(height: 24),
                AppButton(
                  label: l.buttonRetry,
                  onPressed: () =>
                      context.read<FlightDetailsCubit>().loadDetails(flight),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

// ─── Sticky bottom bar ─────────────────────────────────────────────────────

class _StickyBottomBar extends StatelessWidget {
  const _StickyBottomBar({required this.flight, required this.total});

  final FlightModel flight;
  final double total;

  @override
  Widget build(BuildContext context) {
    final l = context.l10n;
    return ClipRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
        child: Container(
          decoration: BoxDecoration(
            color: AppColors.navyDark.withValues(alpha: 0.9),
            border: const Border(
                top: BorderSide(color: AppColors.glassBorder, width: 1)),
          ),
          padding: EdgeInsets.fromLTRB(
            20,
            12,
            20,
            MediaQuery.of(context).padding.bottom + 12,
          ),
          child: Row(
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    l.flightDetailsTotalPrice,
                    style: AppTypography.labelSmall
                        .copyWith(color: AppColors.textMuted),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    localizedCurrency(context, total),
                    style: GoogleFonts.inter(
                      fontSize: 24,
                      fontWeight: FontWeight.w900,
                      color: AppColors.goldPure,
                      letterSpacing: -0.5,
                    ),
                  ),
                  if (flight.isAlmostFull)
                    Text(
                      l.flightDetailsSeatsLeft(flight.availableSeats),
                      style: AppTypography.caption
                          .copyWith(color: AppColors.error),
                    )
                  else
                    Text(l.flightDetailsInclTaxes,
                        style: AppTypography.caption),
                ],
              ),
              const SizedBox(width: 20),
              Expanded(
                child: AppButton(
                  label: l.flightDetailsBookNow,
                  icon: const Icon(Icons.arrow_forward_rounded,
                      color: AppColors.navyDeep, size: 18),
                  onPressed: () => context.push(
                    AppRoutes.passengerDetails,
                    extra: flight,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _LoadingMessage extends StatelessWidget {
  const _LoadingMessage();

  @override
  Widget build(BuildContext context) {
    return Text(
      context.l10n.flightDetailsLoading,
      style: const TextStyle(color: AppColors.textSecondary),
    );
  }
}
