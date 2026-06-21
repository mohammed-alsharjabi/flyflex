import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shimmer/shimmer.dart';
import '../../logic/cubit/tickets_cubit.dart';
import '../../logic/state/tickets_state.dart';
import '../sections/ticket_card_section.dart';
import '../../../../core/di/injection.dart';
import '../../../../core/router/app_router.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_radius.dart';
import '../../../../core/utils/l10n_extension.dart';
import '../../../../core/widgets/app_button.dart';
import '../../../../core/widgets/gradient_background.dart';

class TicketScreen extends StatelessWidget {
  const TicketScreen({super.key, required this.bookingId});

  final String bookingId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<TicketsCubit>()..loadTicket(bookingId),
      child: const _TicketView(),
    );
  }
}

class _TicketView extends StatelessWidget {
  const _TicketView();

  @override
  Widget build(BuildContext context) {
    final top = MediaQuery.paddingOf(context).top;
    final bottom = MediaQuery.paddingOf(context).bottom;

    return NavyScaffold(
      child: BlocBuilder<TicketsCubit, TicketsState>(
        builder: (context, state) => switch (state) {
          TicketsLoading() => _ShimmerPass(top: top),
          TicketsLoaded(:final ticket) => CustomScrollView(
              physics: const BouncingScrollPhysics(),
              slivers: [
                SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(24, top + 16, 24, 0),
                    child: _SuccessHeader()
                        .animate()
                        .fadeIn(duration: 600.ms)
                        .scale(
                          begin: const Offset(0.85, 0.85),
                          curve: Curves.elasticOut,
                          duration: 800.ms,
                        ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: const SizedBox(height: 28),
                ),
                SliverToBoxAdapter(
                  child: TicketCardSection(ticket: ticket)
                      .animate()
                      .fadeIn(delay: 300.ms, duration: 600.ms)
                      .slideY(
                        begin: 0.2,
                        end: 0,
                        delay: 300.ms,
                        curve: Curves.easeOutCubic,
                      ),
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(24, 32, 24, bottom + 24),
                    child: _ActionButtons()
                        .animate()
                        .fadeIn(delay: 500.ms, duration: 400.ms)
                        .slideY(begin: 0.1, end: 0, delay: 500.ms),
                  ),
                ),
              ],
            ),
          TicketsError(:final message) => Center(
              child: Text(message, style: const TextStyle(color: AppColors.error)),
            ),
          _ => const SizedBox.shrink(),
        },
      ),
    );
  }
}

class _SuccessHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final l = context.l10n;
    return Column(
      children: [
        Container(
          width: 80,
          height: 80,
          decoration: const BoxDecoration(
            gradient: LinearGradient(colors: [AppColors.goldDim, AppColors.goldPure]),
            shape: BoxShape.circle,
          ),
          child: const Icon(Icons.check_rounded, color: AppColors.navyDeep, size: 40),
        ),
        const SizedBox(height: 16),
        Text(
          l.ticketBookingConfirmed,
          style: GoogleFonts.inter(
            fontSize: 26,
            fontWeight: FontWeight.w800,
            color: AppColors.textPrimary,
            letterSpacing: -0.5,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          l.ticketBoardingPassReady,
          style: GoogleFonts.inter(fontSize: 14, color: AppColors.textMuted),
        ),
      ],
    );
  }
}

class _ActionButtons extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final l = context.l10n;
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: AppButton(
                label: l.ticketDownload,
                icon: const Icon(Icons.download_rounded, size: 18),
                onPressed: () => ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(l.ticketSavedToDevice),
                    backgroundColor: AppColors.success,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: AppOutlinedButton(
                label: l.ticketShare,
                icon: const Icon(Icons.ios_share_rounded, size: 18, color: AppColors.goldPure),
                onPressed: () => ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(l.ticketShareLinkCopied)),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        AppButton(
          label: l.ticketViewMyBookings,
          onPressed: () => context.go(AppRoutes.myBookings),
        ),
        const SizedBox(height: 12),
        TextButton(
          onPressed: () => context.go(AppRoutes.home),
          child: Text(
            l.ticketBackHome,
            style: GoogleFonts.inter(fontSize: 14, color: AppColors.textMuted),
          ),
        ),
      ],
    );
  }
}

class _ShimmerPass extends StatelessWidget {
  const _ShimmerPass({required this.top});

  final double top;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(24, top + 80, 24, 0),
      child: Shimmer.fromColors(
        baseColor: AppColors.navyLight,
        highlightColor: AppColors.navyAccent,
        child: Container(
          height: 480,
          decoration: BoxDecoration(
            color: AppColors.navyLight,
            borderRadius: AppRadius.cardBorderRadius,
          ),
        ),
      ),
    );
  }
}
