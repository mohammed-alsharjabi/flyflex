import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../cities/data/models/city_model.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_radius.dart';
import '../../../../core/utils/l10n_extension.dart';

class PopularCityCard extends StatefulWidget {
  const PopularCityCard({
    super.key,
    required this.city,
    this.index = 0,
  });

  final CityModel city;
  final int index;

  @override
  State<PopularCityCard> createState() => _PopularCityCardState();
}

class _PopularCityCardState extends State<PopularCityCard>
    with SingleTickerProviderStateMixin {
  late final AnimationController _press;

  @override
  void initState() {
    super.initState();
    _press = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 100),
      lowerBound: 0.95,
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
          context.push('/available-flights?from=RUH&to=${widget.city.code}');
        },
        onTapCancel: () => _press.forward(),
        child: _CityCardBody(city: widget.city),
      ),
    )
        .animate()
        .fadeIn(
          delay: Duration(milliseconds: 300 + widget.index * 80),
          duration: 500.ms,
        )
        .slideX(
          begin: 0.15,
          end: 0,
          delay: Duration(milliseconds: 300 + widget.index * 80),
          curve: Curves.easeOutCubic,
        );
  }
}

class _CityCardBody extends StatelessWidget {
  const _CityCardBody({required this.city});
  final CityModel city;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppRadius.xl),
        boxShadow: [
          BoxShadow(
            color: AppColors.navyDeep.withValues(alpha: 0.5),
            blurRadius: 16,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(AppRadius.xl),
        child: Stack(
          children: [
            // City image
            SizedBox(
              height: 190,
              width: double.infinity,
              child: Image.asset(
                city.imagePath,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stack) => Container(
                  color: AppColors.navyMid,
                  child: const Center(
                    child: Icon(
                      Icons.location_city_rounded,
                      color: AppColors.textMuted,
                      size: 40,
                    ),
                  ),
                ),
              ),
            ),
            // Gradient overlay
            Positioned.fill(
              child: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    stops: [0.3, 1.0],
                    colors: [
                      Colors.transparent,
                      Color(0xDD060F1E),
                    ],
                  ),
                ),
              ),
            ),
            // Popular star
            if (city.isPopular)
              Positioned(
                top: 12,
                right: 12,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: AppColors.goldPure.withValues(alpha: 0.2),
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: AppColors.goldPure.withValues(alpha: 0.5),
                        ),
                      ),
                      child: const Icon(
                        Icons.star_rounded,
                        color: AppColors.goldPure,
                        size: 12,
                      ),
                    ),
                  ),
                ),
              ),
            // Content bottom
            Positioned(
              left: 12,
              right: 12,
              bottom: 14,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    city.name,
                    style: GoogleFonts.inter(
                      fontSize: 17,
                      fontWeight: FontWeight.w800,
                      color: AppColors.textPrimary,
                      letterSpacing: -0.3,
                    ),
                  ),
                  const SizedBox(height: 4),
                  _FlightsChip(count: city.availableFlights),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _FlightsChip extends StatelessWidget {
  const _FlightsChip({required this.count});
  final int count;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(6),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: AppColors.glassSurface,
            borderRadius: BorderRadius.circular(6),
            border: Border.all(color: AppColors.glassBorderBright),
          ),
          child: Text(
            context.l10n.citiesFlights(count),
            style: GoogleFonts.inter(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color: AppColors.goldPure,
            ),
          ),
        ),
      ),
    );
  }
}
