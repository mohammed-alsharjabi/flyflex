import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:fly_flex/core/di/injection.dart';
import 'package:fly_flex/core/router/app_router.dart';
import 'package:fly_flex/core/theme/app_colors.dart';
import 'package:fly_flex/core/utils/l10n_extension.dart';
import 'package:fly_flex/core/utils/model_localization.dart';
import 'package:fly_flex/core/widgets/gradient_background.dart';
import 'package:fly_flex/features/flights/data/models/flight_model.dart';
import 'package:fly_flex/features/tickets/data/datasources/tickets_local_datasource.dart';
import '../../data/models/payment_model.dart';
import '../../logic/cubit/payment_cubit.dart';
import '../../logic/state/payment_state.dart';
import '../sections/payment_summary_section.dart';
import '../sections/payment_methods_section.dart';

class PaymentScreen extends StatelessWidget {
  const PaymentScreen({super.key, required this.flight});
  final FlightModel flight;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<PaymentCubit>(),
      child: _PaymentView(flight: flight),
    );
  }
}

class _PaymentView extends StatelessWidget {
  const _PaymentView({required this.flight});
  final FlightModel flight;

  double get _flyFlexFee => flight.price * 0.05;
  double get _total => flight.price + _flyFlexFee;

  @override
  Widget build(BuildContext context) {
    return BlocListener<PaymentCubit, PaymentState>(
      listener: (context, state) async {
        if (state.status == PaymentStatus.completed && state.payment != null) {
          final payment = state.payment!;
          final ds = TicketsLocalDatasource();
          final ticket = ds.generateTicket(payment.id, flight, '14C');
          await ds.saveTicket(ticket);
          if (context.mounted) {
            context
                .go('${AppRoutes.ticket}?bookingId=${payment.id}');
          }
        } else if (state.status == PaymentStatus.failed) {
          if (context.mounted) {
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                SnackBar(
                  content: Text(
                    state.errorMessage ?? context.l10n.paymentFailed,
                    style: GoogleFonts.inter(color: Colors.white),
                  ),
                  backgroundColor: AppColors.error,
                  behavior: SnackBarBehavior.floating,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              );
            context.read<PaymentCubit>().clearError();
          }
        }
      },
      child: BlocBuilder<PaymentCubit, PaymentState>(
        builder: (context, state) {
          final l = context.l10n;
          return NavyScaffold(
            resizeToAvoidBottomInset: true,
            child: Stack(
              children: [
                CustomScrollView(
                  slivers: [
                    SliverAppBar(
                      backgroundColor: Colors.transparent,
                      elevation: 0,
                      floating: true,
                      leading: GestureDetector(
                        onTap: () => context.pop(),
                        child: Container(
                          margin: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: AppColors.glassSurface,
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: AppColors.glassBorder,
                            ),
                          ),
                          child: const Icon(
                            Icons.arrow_back_ios_new_rounded,
                            color: AppColors.textPrimary,
                            size: 18,
                          ),
                        ),
                      ),
                      title: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(
                            Icons.lock_rounded,
                            color: AppColors.goldPure,
                            size: 18,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            l.paymentSecureTitle,
                            style: GoogleFonts.inter(
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                              color: AppColors.textPrimary,
                            ),
                          ),
                        ],
                      ),
                      centerTitle: true,
                    ),
                    SliverPadding(
                      padding: const EdgeInsets.fromLTRB(24, 8, 24, 120),
                      sliver: SliverList(
                        delegate: SliverChildListDelegate([
                          PaymentSummarySection(
                            flight: flight,
                            passengerName: 'Mohammed Al-Sharjabi',
                            seatNumber: '14C',
                          ).animate().fadeIn(duration: 400.ms).slideY(
                                begin: 0.05,
                                end: 0,
                                duration: 400.ms,
                                curve: Curves.easeOutCubic,
                              ),
                          const SizedBox(height: 24),
                          PaymentMethodsSection(
                            selectedMethod: state.selectedMethod,
                            onMethodSelected: (method) {
                              context
                                  .read<PaymentCubit>()
                                  .selectMethod(method);
                            },
                          )
                              .animate()
                              .fadeIn(
                                  duration: 400.ms, delay: 150.ms)
                              .slideY(
                                begin: 0.05,
                                end: 0,
                                duration: 400.ms,
                                delay: 150.ms,
                                curve: Curves.easeOutCubic,
                              ),
                        ]),
                      ),
                    ),
                  ],
                ),
                Positioned(
                  left: 0,
                  right: 0,
                  bottom: 0,
                  child: _StickyPayButton(
                    total: _total,
                    isProcessing:
                        state.status == PaymentStatus.pending,
                    onPay: () {
                      context
                          .read<PaymentCubit>()
                          .processPayment(_total);
                    },
                  ),
                ),
                if (state.status == PaymentStatus.pending)
                  _ProcessingOverlay(),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _StickyPayButton extends StatelessWidget {
  const _StickyPayButton({
    required this.total,
    required this.isProcessing,
    required this.onPay,
  });

  final double total;
  final bool isProcessing;
  final VoidCallback onPay;

  @override
  Widget build(BuildContext context) {
    final l = context.l10n;
    final bottomPadding = MediaQuery.of(context).padding.bottom;
    return ClipRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
        child: Container(
          padding: EdgeInsets.fromLTRB(24, 16, 24, 16 + bottomPadding),
          decoration: BoxDecoration(
            color: AppColors.navyDark.withValues(alpha: 0.9),
            border: const Border(
              top: BorderSide(color: AppColors.glassBorder, width: 1),
            ),
          ),
          child: Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    l.paymentTotalAmount,
                    style: GoogleFonts.inter(
                      fontSize: 11,
                      color: AppColors.textMuted,
                      letterSpacing: 0.5,
                    ),
                  ),
                  Text(
                    localizedCurrency(context, total),
                    style: GoogleFonts.inter(
                      fontSize: 22,
                      fontWeight: FontWeight.w800,
                      color: AppColors.goldPure,
                      letterSpacing: -0.5,
                    ),
                  ),
                ],
              ),
              const SizedBox(width: 20),
              Expanded(
                child: GestureDetector(
                  onTap: isProcessing ? null : onPay,
                  child: Container(
                    height: 52,
                    decoration: BoxDecoration(
                      gradient: isProcessing
                          ? null
                          : const LinearGradient(
                              colors: [
                                AppColors.goldDim,
                                AppColors.goldPure,
                                AppColors.goldLight,
                              ],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                      color: isProcessing ? AppColors.navyLight : null,
                      borderRadius: BorderRadius.circular(14),
                      boxShadow: isProcessing
                          ? null
                          : [
                              BoxShadow(
                                color: AppColors.goldPure.withValues(alpha: 0.3),
                                blurRadius: 16,
                                offset: const Offset(0, 4),
                              ),
                            ],
                    ),
                    child: Center(
                      child: isProcessing
                          ? SizedBox(
                              width: 24,
                              height: 24,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                valueColor: AlwaysStoppedAnimation<Color>(
                                  AppColors.goldPure,
                                ),
                              ),
                            )
                          : Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(
                                  Icons.lock_rounded,
                                  size: 16,
                                  color: AppColors.navyDeep,
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  l.paymentPayNow,
                                  style: GoogleFonts.inter(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700,
                                    color: AppColors.navyDeep,
                                  ),
                                ),
                              ],
                            ),
                    ),
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

class _ProcessingOverlay extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final l = context.l10n;
    return Positioned.fill(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 16, sigmaY: 16),
        child: Container(
          color: AppColors.navyDeep.withValues(alpha: 0.7),
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  width: 64,
                  height: 64,
                  child: CircularProgressIndicator(
                    strokeWidth: 3,
                    valueColor: AlwaysStoppedAnimation<Color>(
                      AppColors.goldPure,
                    ),
                  ),
                )
                    .animate(onPlay: (c) => c.repeat())
                    .rotate(duration: 1200.ms, curve: Curves.linear),
                const SizedBox(height: 24),
                Text(
                  l.paymentProcessing,
                  style: GoogleFonts.inter(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textPrimary,
                  ),
                ).animate().fadeIn(duration: 300.ms),
                const SizedBox(height: 8),
                Text(
                  l.paymentDoNotClose,
                  style: GoogleFonts.inter(
                    fontSize: 13,
                    color: AppColors.textMuted,
                  ),
                ).animate().fadeIn(duration: 300.ms, delay: 100.ms),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
