import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:fly_flex/core/di/injection.dart';
import 'package:fly_flex/core/utils/l10n_extension.dart';
import 'package:fly_flex/core/theme/app_colors.dart';
import 'package:fly_flex/core/theme/app_radius.dart';
import 'package:fly_flex/core/theme/app_typography.dart';
import 'package:fly_flex/core/widgets/gradient_background.dart';
import '../sections/flights_filter_section.dart';
import '../sections/flights_list_section.dart';
import '../../logic/cubit/flights_cubit.dart';

class AvailableFlightsScreen extends StatelessWidget {
  const AvailableFlightsScreen({
    super.key,
    required this.fromCode,
    required this.toCode,
  });

  final String fromCode;
  final String toCode;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<FlightsCubit>(
      create: (_) =>
          sl<FlightsCubit>()..loadByRoute(fromCode: fromCode, toCode: toCode),
      child: _AvailableFlightsView(fromCode: fromCode, toCode: toCode),
    );
  }
}

class _AvailableFlightsView extends StatelessWidget {
  const _AvailableFlightsView({
    required this.fromCode,
    required this.toCode,
  });

  final String fromCode;
  final String toCode;

  @override
  Widget build(BuildContext context) {
    return NavyScaffold(
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _AvailableAppBar(fromCode: fromCode, toCode: toCode),
            const SizedBox(height: 12),
            _DatePassengerRow(),
            const SizedBox(height: 16),
            const FlightsFilterSection(),
            const SizedBox(height: 16),
            const Expanded(
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Column(
                  children: [FlightsListSection(), SizedBox(height: 24)],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _AvailableAppBar extends StatelessWidget {
  const _AvailableAppBar({
    required this.fromCode,
    required this.toCode,
  });

  final String fromCode;
  final String toCode;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 8, 20, 0),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => context.pop(),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                child: Container(
                  width: 42,
                  height: 42,
                  decoration: BoxDecoration(
                    color: AppColors.glassSurface,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: AppColors.glassBorder, width: 1),
                  ),
                  child: const Icon(
                    Icons.arrow_back_ios_new_rounded,
                    color: AppColors.textPrimary,
                    size: 18,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      fromCode,
                      style: GoogleFonts.inter(
                        fontSize: 22,
                        fontWeight: FontWeight.w800,
                        color: AppColors.goldPure,
                        letterSpacing: -0.5,
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Icon(
                        Icons.flight_rounded,
                        color: AppColors.goldLight,
                        size: 20,
                      ),
                    ),
                    Text(
                      toCode,
                      style: GoogleFonts.inter(
                        fontSize: 22,
                        fontWeight: FontWeight.w800,
                        color: AppColors.goldPure,
                        letterSpacing: -0.5,
                      ),
                    ),
                  ],
                ).animate().fadeIn(duration: 400.ms).slideX(begin: -0.2),
                Text(
                  context.l10n.flightsAvailable,
                  style: AppTypography.bodySmall,
                ).animate(delay: 100.ms).fadeIn(duration: 400.ms),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _DatePassengerRow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final today = DateFormat('EEE, d MMM').format(DateTime.now());
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          _SelectorChip(icon: Icons.calendar_today_rounded, label: today),
          const SizedBox(width: 10),
          _SelectorChip(
            icon: Icons.person_rounded,
            label: context.l10n.flightsOnePassenger,
          ),
        ],
      ).animate(delay: 150.ms).fadeIn(duration: 400.ms),
    );
  }
}

class _SelectorChip extends StatelessWidget {
  const _SelectorChip({required this.icon, required this.label});

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(AppRadius.chip),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 9),
          decoration: BoxDecoration(
            color: AppColors.glassSurface,
            borderRadius: BorderRadius.circular(AppRadius.chip),
            border: Border.all(color: AppColors.glassBorder),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, color: AppColors.goldPure, size: 14),
              const SizedBox(width: 7),
              Text(
                label,
                style: GoogleFonts.inter(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(width: 6),
              const Icon(
                Icons.keyboard_arrow_down_rounded,
                color: AppColors.textMuted,
                size: 16,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
