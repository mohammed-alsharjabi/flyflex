import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:fly_flex/core/di/injection.dart';
import 'package:fly_flex/core/router/app_router.dart';
import 'package:fly_flex/core/theme/app_colors.dart';
import 'package:fly_flex/core/theme/app_radius.dart';
import 'package:fly_flex/core/theme/app_spacing.dart';
import 'package:fly_flex/core/theme/app_typography.dart';
import 'package:fly_flex/core/utils/l10n_extension.dart';
import 'package:fly_flex/core/utils/model_localization.dart';
import 'package:fly_flex/core/widgets/app_back_button.dart';
import 'package:fly_flex/core/widgets/app_button.dart';
import 'package:fly_flex/core/widgets/gradient_background.dart';
import 'package:fly_flex/features/flights/data/models/flight_model.dart';
import 'package:fly_flex/features/passengers/data/models/passenger_model.dart';
import 'package:fly_flex/features/passengers/logic/cubit/passengers_cubit.dart';
import 'package:fly_flex/features/passengers/logic/state/passengers_state.dart';
import 'package:fly_flex/features/passengers/ui/sections/passenger_form_section.dart';

class PassengerDetailsScreen extends StatelessWidget {
  const PassengerDetailsScreen({super.key, required this.flight});

  final FlightModel flight;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<PassengersCubit>()..loadExisting(),
      child: _PassengerDetailsBody(flight: flight),
    );
  }
}

class _PassengerDetailsBody extends StatefulWidget {
  const _PassengerDetailsBody({required this.flight});

  final FlightModel flight;

  @override
  State<_PassengerDetailsBody> createState() => _PassengerDetailsBodyState();
}

class _PassengerDetailsBodyState extends State<_PassengerDetailsBody> {
  final _sectionKey = GlobalKey<PassengerFormSectionState>();

  void _onContinue() {
    _sectionKey.currentState?.submit();
  }

  Future<void> _onPassengerReady(
    BuildContext context,
    PassengerModel passenger,
  ) async {
    final success =
        await context.read<PassengersCubit>().save(passenger);
    if (success && context.mounted) {
      context.push(AppRoutes.seatSelection, extra: widget.flight);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l = context.l10n;

    return BlocConsumer<PassengersCubit, PassengersState>(
      listener: (context, state) {
        if (state is PassengersEditing && state.errorMessage != null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                state.errorMessage!,
                style: GoogleFonts.inter(color: AppColors.textPrimary),
              ),
              backgroundColor: AppColors.error,
              behavior: SnackBarBehavior.floating,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppRadius.md),
              ),
            ),
          );
        }
      },
      builder: (context, state) {
        final existing =
            state is PassengersEditing ? state.existing : null;
        final isSaving =
            state is PassengersEditing && state.isSaving;

        return NavyScaffold(
          resizeToAvoidBottomInset: true,
          child: Stack(
            children: [
              CustomScrollView(
                physics: const BouncingScrollPhysics(),
                slivers: [
                  SliverAppBar(
                    backgroundColor: Colors.transparent,
                    elevation: 0,
                    pinned: false,
                    leading: Padding(
                      padding: const EdgeInsets.only(left: 16, top: 8),
                      child: AppBackButton(),
                    ),
                    title: Text(
                      l.passengerTitle,
                      style: AppTypography.headlineMedium,
                    ),
                    centerTitle: true,
                    toolbarHeight: 64,
                  ),
                  SliverPadding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: AppSpacing.screenHorizontal),
                    sliver: SliverList(
                      delegate: SliverChildListDelegate([
                        _FlightSummaryCard(flight: widget.flight)
                            .animate()
                            .fadeIn(duration: 400.ms)
                            .slideY(begin: -0.08, end: 0),
                        const SizedBox(height: 24),
                        PassengerFormSection(
                          key: _sectionKey,
                          initial: existing,
                          onSaved: (p) => _onPassengerReady(context, p),
                        )
                            .animate()
                            .fadeIn(duration: 500.ms, delay: 160.ms)
                            .slideY(begin: 0.05, end: 0),
                        const SizedBox(height: 120),
                      ]),
                    ),
                  ),
                ],
              ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: _StickyBottom(
                  onContinue: _onContinue,
                  isSaving: isSaving,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

// ─── Sticky bottom ─────────────────────────────────────────────────────────

class _StickyBottom extends StatelessWidget {
  const _StickyBottom({required this.onContinue, required this.isSaving});

  final VoidCallback onContinue;
  final bool isSaving;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(
        AppSpacing.screenHorizontal,
        20,
        AppSpacing.screenHorizontal,
        MediaQuery.of(context).padding.bottom + 16,
      ),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            AppColors.navyDeep.withValues(alpha: 0),
            AppColors.navyDeep.withValues(alpha: 0.95),
            AppColors.navyDeep,
          ],
          stops: const [0.0, 0.35, 1.0],
        ),
      ),
      child: AppButton(
        label: context.l10n.passengerContinue,
        isLoading: isSaving,
        icon: const Icon(
          Icons.airline_seat_recline_extra_rounded,
          color: AppColors.navyDeep,
          size: 20,
        ),
        onPressed: onContinue,
      ),
    );
  }
}

// ─── Flight summary card ───────────────────────────────────────────────────

class _FlightSummaryCard extends StatelessWidget {
  const _FlightSummaryCard({required this.flight});

  final FlightModel flight;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppRadius.lg),
        border: Border.all(color: AppColors.glassBorder),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppColors.navyLight.withValues(alpha: 0.35),
            AppColors.navyMid.withValues(alpha: 0.20),
          ],
        ),
      ),
      child: Row(
        children: [
          _CityCode(code: flight.fromCode, city: flight.fromCity),
          Expanded(
            child: Column(
              children: [
                const Icon(Icons.flight_takeoff_rounded,
                    color: AppColors.goldPure, size: 20),
                const SizedBox(height: 4),
                Text(
                  flight.durationFormatted,
                  style: GoogleFonts.inter(
                      fontSize: 11, color: AppColors.textMuted),
                ),
              ],
            ),
          ),
          _CityCode(
            code: flight.toCode,
            city: flight.toCity,
            align: CrossAxisAlignment.end,
          ),
          const SizedBox(width: 12),
          _CabinBadge(label: flight.cabinClass.localizedName(context)),
        ],
      ),
    );
  }
}

class _CityCode extends StatelessWidget {
  const _CityCode({
    required this.code,
    required this.city,
    this.align = CrossAxisAlignment.start,
  });

  final String code;
  final String city;
  final CrossAxisAlignment align;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: align,
      children: [
        Text(
          code,
          style: GoogleFonts.inter(
            fontSize: 22,
            fontWeight: FontWeight.w800,
            color: AppColors.textPrimary,
            letterSpacing: -0.5,
          ),
        ),
        Text(
          city,
          style:
              GoogleFonts.inter(fontSize: 11, color: AppColors.textMuted),
        ),
      ],
    );
  }
}

class _CabinBadge extends StatelessWidget {
  const _CabinBadge({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: AppColors.goldPure.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(AppRadius.chip),
        border: Border.all(
            color: AppColors.goldPure.withValues(alpha: 0.4)),
      ),
      child: Text(
        label,
        style: GoogleFonts.inter(
          fontSize: 11,
          fontWeight: FontWeight.w600,
          color: AppColors.goldLight,
          letterSpacing: 0.3,
        ),
      ),
    );
  }
}
