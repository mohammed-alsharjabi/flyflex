import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/theme/app_radius.dart';
import '../../../../../core/theme/app_typography.dart';
import '../../../flights/data/models/flight_model.dart';

class FlightHeroAppBar extends StatelessWidget {
  const FlightHeroAppBar({super.key, required this.flight});

  final FlightModel flight;

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 200,
      pinned: true,
      backgroundColor: AppColors.navyDeep,
      leading: Padding(
        padding: const EdgeInsets.all(8),
        child: _GlassIconButton(
          icon: Icons.arrow_back_ios_new_rounded,
          onTap: () => context.pop(),
        ),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.all(8),
          child: _GlassIconButton(icon: Icons.share_rounded, onTap: () {}),
        ),
        const SizedBox(width: 4),
      ],
      flexibleSpace: FlexibleSpaceBar(
        collapseMode: CollapseMode.parallax,
        background: Stack(
          fit: StackFit.expand,
          children: [
            Image.asset(
              'assets/flights/airplane_side.png',
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      AppColors.navyAccent,
                      AppColors.navyMid,
                      AppColors.navyDeep,
                    ],
                  ),
                ),
                child: Center(
                  child: Icon(
                    Icons.flight,
                    size: 80,
                    color: AppColors.goldPure.withValues(alpha: 0.25),
                  ),
                ),
              ),
            ),
            Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  stops: [0.0, 0.5, 1.0],
                  colors: [
                    Color(0x44050D1F),
                    Color(0x66050D1F),
                    AppColors.navyDeep,
                  ],
                ),
              ),
            ),
            Positioned(
              bottom: 20,
              left: 24,
              right: 24,
              child: _RouteOverlay(flight: flight),
            ),
          ],
        ),
      ),
    );
  }
}

class _RouteOverlay extends StatelessWidget {
  const _RouteOverlay({required this.flight});

  final FlightModel flight;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _AirportBadge(code: flight.fromCode, city: flight.fromCity),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    height: 1,
                    color: AppColors.goldPure.withValues(alpha: 0.4),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 6),
                  child:
                      Icon(Icons.flight, color: AppColors.goldPure, size: 22),
                ),
                Expanded(
                  child: Container(
                    height: 1,
                    color: AppColors.goldPure.withValues(alpha: 0.4),
                  ),
                ),
              ],
            ),
          ),
        ),
        _AirportBadge(code: flight.toCode, city: flight.toCity),
      ],
    );
  }
}

class _AirportBadge extends StatelessWidget {
  const _AirportBadge({required this.code, required this.city});

  final String code;
  final String city;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(AppRadius.lg),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
        child: Container(
          padding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          decoration: BoxDecoration(
            color: AppColors.glassSurface,
            borderRadius: BorderRadius.circular(AppRadius.lg),
            border: Border.all(color: AppColors.glassBorderBright),
          ),
          child: Column(
            children: [
              Text(
                code,
                style: GoogleFonts.inter(
                  fontSize: 22,
                  fontWeight: FontWeight.w900,
                  color: AppColors.goldPure,
                  letterSpacing: -0.5,
                ),
              ),
              Text(city, style: AppTypography.caption),
            ],
          ),
        ),
      ),
    );
  }
}

class _GlassIconButton extends StatelessWidget {
  const _GlassIconButton({required this.icon, required this.onTap});

  final IconData icon;
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
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: AppColors.glassSurface,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: AppColors.glassBorderBright),
            ),
            child: Icon(icon, color: AppColors.textPrimary, size: 18),
          ),
        ),
      ),
    );
  }
}
