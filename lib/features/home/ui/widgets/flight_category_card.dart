import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../data/models/flight_category_model.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_radius.dart';
import '../../../../core/utils/l10n_extension.dart';

class FlightCategoryCard extends StatefulWidget {
  const FlightCategoryCard({
    super.key,
    required this.category,
    required this.imagePath,
    this.index = 0,
  });

  final FlightCategoryModel category;
  final String imagePath;
  final int index;

  @override
  State<FlightCategoryCard> createState() => _FlightCategoryCardState();
}

class _FlightCategoryCardState extends State<FlightCategoryCard>
    with SingleTickerProviderStateMixin {
  late final AnimationController _press;
  bool _isPressed = false;

  @override
  void initState() {
    super.initState();
    _press = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 120),
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

  void _onTapDown(_) {
    _press.reverse();
    setState(() => _isPressed = true);
  }

  void _onTapUp(_) {
    _press.forward();
    setState(() => _isPressed = false);
    context.push(widget.category.route);
  }

  void _onTapCancel() {
    _press.forward();
    setState(() => _isPressed = false);
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
        onTapDown: _onTapDown,
        onTapUp: _onTapUp,
        onTapCancel: _onTapCancel,
        child: _CardBody(
          category: widget.category,
          imagePath: widget.imagePath,
          isPressed: _isPressed,
        ),
      ),
    ).animate().fadeIn(
          delay: Duration(milliseconds: 400 + widget.index * 150),
          duration: 600.ms,
        ).slideX(
          begin: 0.08,
          end: 0,
          delay: Duration(milliseconds: 400 + widget.index * 150),
          curve: Curves.easeOutCubic,
        );
  }
}

class _CardBody extends StatelessWidget {
  const _CardBody({
    required this.category,
    required this.imagePath,
    required this.isPressed,
  });

  final FlightCategoryModel category;
  final String imagePath;
  final bool isPressed;

  bool get isDomestic => category.id == 'domestic';

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 160,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppRadius.xxl),
        boxShadow: [
          BoxShadow(
            color: (isDomestic ? AppColors.goldPure : AppColors.navyAccent)
                .withValues(alpha: isPressed ? 0.1 : 0.25),
            blurRadius: 24,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(AppRadius.xxl),
        child: Stack(
          fit: StackFit.expand,
          children: [
            // City image background
            Image.asset(
              imagePath,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stack) => Container(
                color: AppColors.navyMid,
              ),
            ),
            // Dark gradient overlay
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.centerRight,
                  end: Alignment.centerLeft,
                  colors: [
                    Colors.black.withValues(alpha: 0.15),
                    Colors.black.withValues(alpha: 0.72),
                  ],
                ),
              ),
            ),
            // Gold shimmer top edge
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              height: 1.5,
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      AppColors.goldPure.withValues(alpha: 0),
                      AppColors.goldPure.withValues(alpha: 0.6),
                      AppColors.goldPure.withValues(alpha: 0),
                    ],
                  ),
                ),
              ),
            ),
            // Content
            Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _IconBadge(isDomestic: isDomestic),
                      _RoutesChip(count: isDomestic ? 24 : 48),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        isDomestic
                            ? context.l10n.homeDomesticFlights
                            : context.l10n.homeInternationalFlights,
                        style: GoogleFonts.inter(
                          fontSize: 22,
                          fontWeight: FontWeight.w800,
                          color: AppColors.textPrimary,
                          letterSpacing: -0.5,
                          height: 1.1,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          Text(
                            isDomestic
                                ? context.l10n.homeDomesticSubtitle
                                : context.l10n.homeInternationalSubtitle,
                            style: GoogleFonts.inter(
                              fontSize: 13,
                              color: AppColors.textSecondary,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          const SizedBox(width: 8),
                          const Icon(
                            Icons.arrow_forward_rounded,
                            color: AppColors.goldPure,
                            size: 15,
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _IconBadge extends StatelessWidget {
  const _IconBadge({required this.isDomestic});
  final bool isDomestic;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: AppColors.glassSurface,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColors.glassBorderBright),
          ),
          child: Icon(
            isDomestic ? Icons.flight_takeoff_rounded : Icons.language_rounded,
            color: AppColors.goldPure,
            size: 20,
          ),
        ),
      ),
    );
  }
}

class _RoutesChip extends StatelessWidget {
  const _RoutesChip({required this.count});
  final int count;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(50),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: AppColors.glassSurface,
            borderRadius: BorderRadius.circular(50),
            border: Border.all(color: AppColors.glassBorderBright),
          ),
          child: Text(
            context.l10n.homeRoutes(count),
            style: GoogleFonts.inter(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color: AppColors.textPrimary,
            ),
          ),
        ),
      ),
    );
  }
}
