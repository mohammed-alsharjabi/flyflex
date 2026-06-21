import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:fly_flex/core/di/injection.dart';
import 'package:fly_flex/core/theme/app_colors.dart';
import 'package:fly_flex/core/widgets/gradient_background.dart';
import 'package:fly_flex/core/utils/l10n_extension.dart';
import 'package:fly_flex/core/widgets/shimmer_loading.dart';
import 'package:fly_flex/features/cities/logic/cubit/cities_cubit.dart';
import 'package:fly_flex/features/cities/logic/state/cities_state.dart';
import 'package:fly_flex/features/cities/ui/sections/cities_grid_section.dart';

class CitiesScreen extends StatelessWidget {
  const CitiesScreen({super.key, required this.flightType});

  final String flightType;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CitiesCubit>(
      create: (_) => sl<CitiesCubit>()..loadCities(type: flightType),
      child: _CitiesView(flightType: flightType),
    );
  }
}

class _CitiesView extends StatelessWidget {
  const _CitiesView({required this.flightType});

  final String flightType;

  bool get _isInternational => flightType == 'international';

  @override
  Widget build(BuildContext context) {
    final topPadding = MediaQuery.of(context).padding.top;

    return NavyScaffold(
      child: BlocBuilder<CitiesCubit, CitiesState>(
        builder: (context, state) {
          return CustomScrollView(
            physics: const BouncingScrollPhysics(),
            slivers: [
              SliverToBoxAdapter(
                child: _CitiesHeader(
                  topPadding: topPadding,
                  isInternational: _isInternational,
                  onBack: () => context.pop(),
                ),
              ),
              if (state is CitiesLoaded)
                CitiesGridSection(cities: state.cities)
              else if (state is CitiesLoading || state is CitiesInitial)
                const SliverToBoxAdapter(child: _CitiesShimmer())
              else if (state is CitiesError)
                SliverToBoxAdapter(
                  child: _CitiesError(
                    message: state.message,
                    onRetry: () =>
                        context.read<CitiesCubit>().loadCities(type: flightType),
                  ),
                ),
              const SliverToBoxAdapter(child: SizedBox(height: 32)),
            ],
          );
        },
      ),
    );
  }
}

class _CitiesHeader extends StatelessWidget {
  const _CitiesHeader({
    required this.topPadding,
    required this.isInternational,
    required this.onBack,
  });

  final double topPadding;
  final bool isInternational;
  final VoidCallback onBack;

  @override
  Widget build(BuildContext context) {
    final l = context.l10n;
    return Padding(
      padding: EdgeInsets.only(
        top: topPadding + 12,
        left: 20,
        right: 20,
        bottom: 20,
      ),
      child: Row(
        children: [
          _GlassBackButton(onTap: onBack),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  isInternational ? l.citiesInternational : l.citiesDomestic,
                  style: GoogleFonts.inter(
                    color: AppColors.textMuted,
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    letterSpacing: 0.5,
                  ),
                ),
                Text(
                  isInternational
                      ? l.flightsInternational
                      : l.flightsDomestic,
                  style: GoogleFonts.inter(
                    color: AppColors.textPrimary,
                    fontSize: 22,
                    fontWeight: FontWeight.w700,
                    letterSpacing: -0.5,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ).animate().fadeIn(duration: 400.ms).slideY(begin: -0.1, end: 0);
  }
}

class _GlassBackButton extends StatelessWidget {
  const _GlassBackButton({required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
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
    );
  }
}

class _CitiesShimmer extends StatelessWidget {
  const _CitiesShimmer();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: List.generate(
          4,
          (_) => Padding(
            padding: const EdgeInsets.only(bottom: 14),
            child: ShimmerBox(
              width: double.infinity,
              height: 200,
              borderRadius: BorderRadius.circular(20),
            ),
          ),
        ),
      ),
    );
  }
}

class _CitiesError extends StatelessWidget {
  const _CitiesError({required this.message, required this.onRetry});

  final String message;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    final l = context.l10n;
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(40),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.error_outline_rounded,
              color: AppColors.error,
              size: 48,
            ),
            const SizedBox(height: 16),
            Text(
              l.citiesFailedToLoad,
              style: GoogleFonts.inter(
                color: AppColors.textPrimary,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              message,
              textAlign: TextAlign.center,
              style: GoogleFonts.inter(
                color: AppColors.textMuted,
                fontSize: 13,
              ),
            ),
            const SizedBox(height: 24),
            GestureDetector(
              onTap: onRetry,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 12,
                ),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [AppColors.goldDim, AppColors.goldPure],
                  ),
                  borderRadius: BorderRadius.circular(50),
                ),
                child: Text(
                  l.buttonRetry,
                  style: GoogleFonts.inter(
                    color: AppColors.navyDeep,
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
