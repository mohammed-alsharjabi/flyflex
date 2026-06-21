import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import '../widgets/stat_card.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/utils/l10n_extension.dart';

class HeroSection extends StatelessWidget {
  const HeroSection({super.key, required this.topPadding});

  final double topPadding;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 420 + topPadding,
      child: Stack(
        children: [
          const _HeroBackground(),
          Positioned.fill(
            child: Padding(
              padding: EdgeInsets.fromLTRB(24, topPadding + 24, 24, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const _HeroHeader(),
                  const Spacer(),
                  const _HeroTagline(),
                  const SizedBox(height: 32),
                  const _StatsRow(),
                  const SizedBox(height: 32),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _HeroBackground extends StatelessWidget {
  const _HeroBackground();

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: Stack(
        fit: StackFit.expand,
        children: [
          // Base gradient
          Container(
            decoration: const BoxDecoration(
              gradient: RadialGradient(
                center: Alignment(0.3, -0.6),
                radius: 1.4,
                colors: [
                  Color(0xFF1A2E52),
                  Color(0xFF050D1F),
                ],
              ),
            ),
          ),
          // Airplane silhouette
          Positioned(
            bottom: -20,
            right: -40,
            child: Opacity(
              opacity: 0.12,
              child: Image.asset(
                'assets/flights/airplane_front.png',
                width: 340,
                fit: BoxFit.contain,
              ),
            ),
          ),
          // Gold accent orb top-left
          Positioned(
            top: -60,
            left: -60,
            child: Container(
              width: 220,
              height: 220,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    AppColors.goldPure.withValues(alpha: 0.12),
                    AppColors.goldPure.withValues(alpha: 0),
                  ],
                ),
              ),
            ),
          ),
          // Bottom fade
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            height: 100,
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    AppColors.navyDeep.withValues(alpha: 0),
                    AppColors.navyDeep,
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _HeroHeader extends StatelessWidget {
  const _HeroHeader();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Image.asset(
          'assets/icons/flyflex_logo.png',
          height: 36,
          errorBuilder: (context, error, stack) => const SizedBox.shrink(),
        ),
        const Spacer(),
        _LiveBadge(),
      ],
    )
        .animate()
        .fadeIn(duration: 600.ms)
        .slideY(begin: -0.3, end: 0, curve: Curves.easeOutCubic);
  }
}

class _LiveBadge extends StatefulWidget {
  @override
  State<_LiveBadge> createState() => _LiveBadgeState();
}

class _LiveBadgeState extends State<_LiveBadge>
    with SingleTickerProviderStateMixin {
  late final AnimationController _pulse;

  @override
  void initState() {
    super.initState();
    _pulse = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _pulse.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _pulse,
      builder: (context, _) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: AppColors.success.withValues(alpha: 0.15),
          borderRadius: BorderRadius.circular(50),
          border: Border.all(
            color:
                AppColors.success.withValues(alpha: 0.3 + _pulse.value * 0.2),
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 6,
              height: 6,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.success.withValues(
                  alpha: 0.6 + _pulse.value * 0.4,
                ),
              ),
            ),
            const SizedBox(width: 6),
            Text(
              context.l10n.statusLive,
              style: GoogleFonts.inter(
                fontSize: 11,
                fontWeight: FontWeight.w700,
                color: AppColors.success,
                letterSpacing: 1,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _HeroTagline extends StatelessWidget {
  const _HeroTagline();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          context.l10n.homeHeroTagline,
          style: GoogleFonts.inter(
            fontSize: 38,
            fontWeight: FontWeight.w900,
            color: AppColors.textPrimary,
            letterSpacing: -1.5,
            height: 1.1,
          ),
        ),
        const SizedBox(height: 12),
        Text(
          context.l10n.homeHeroSubtitle,
          style: GoogleFonts.inter(
            fontSize: 15,
            color: AppColors.textSecondary,
            height: 1.6,
          ),
        ),
      ],
    )
        .animate()
        .fadeIn(delay: 200.ms, duration: 700.ms)
        .slideY(begin: 0.15, end: 0, delay: 200.ms, curve: Curves.easeOutCubic);
  }
}

class _StatsRow extends StatelessWidget {
  const _StatsRow();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        StatCard(
          target: 247,
          suffix: '',
          label: context.l10n.homeAvailableSeats,
          startDelay: const Duration(milliseconds: 600),
        ),
        const SizedBox(width: 10),
        StatCard(
          target: 58,
          suffix: '%',
          label: context.l10n.homeAverageSavings,
          startDelay: const Duration(milliseconds: 800),
        ),
        const SizedBox(width: 10),
        StatCard(
          target: 12,
          suffix: '',
          label: context.l10n.homePartnerAirlines,
          startDelay: const Duration(milliseconds: 1000),
        ),
      ],
    )
        .animate()
        .fadeIn(delay: 500.ms, duration: 600.ms)
        .slideY(begin: 0.2, end: 0, delay: 500.ms, curve: Curves.easeOutCubic);
  }
}
