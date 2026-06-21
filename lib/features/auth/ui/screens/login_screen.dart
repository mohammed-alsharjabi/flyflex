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
import 'package:fly_flex/core/theme/app_spacing.dart';
import 'package:fly_flex/core/theme/app_typography.dart';
import 'package:fly_flex/features/auth/logic/cubit/auth_cubit.dart';
import 'package:fly_flex/features/auth/logic/state/auth_state.dart';
import 'package:fly_flex/features/auth/ui/widgets/login_form.dart';
import 'package:fly_flex/core/utils/l10n_extension.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<AuthCubit>(),
      child: AnnotatedRegion<SystemUiOverlayStyle>(
        value: const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.light,
        ),
        child: Scaffold(
          backgroundColor: AppColors.navyDeep,
          extendBodyBehindAppBar: true,
          body: BlocConsumer<AuthCubit, AuthState>(
            listener: _handleState,
            builder: _buildBody,
          ),
        ),
      ),
    );
  }

  void _handleState(BuildContext context, AuthState state) {
    if (state is AuthAuthenticated) {
      context.go(AppRoutes.home);
    } else if (state is AuthError) {
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(
          SnackBar(
            content: Text(
              state.message,
              style: GoogleFonts.inter(color: Colors.white, fontSize: 14),
            ),
            backgroundColor: AppColors.error,
            behavior: SnackBarBehavior.floating,
            margin: const EdgeInsets.all(16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppRadius.md),
            ),
          ),
        );
    }
  }

  Widget _buildBody(BuildContext context, AuthState state) {
    final isLoading = state is AuthLoading;
    return Stack(
      children: [
        _buildBackground(),
        SafeArea(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.screenHorizontal,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 40),
                _buildLogo()
                    .animate()
                    .fadeIn(duration: 500.ms)
                    .scale(
                      begin: const Offset(0.8, 0.8),
                      duration: 500.ms,
                      curve: Curves.easeOutBack,
                    ),
                const SizedBox(height: 12),
                _buildTagline()
                    .animate()
                    .fadeIn(delay: 100.ms, duration: 500.ms),
                const SizedBox(height: 8),
                _buildHeadline()
                    .animate()
                    .fadeIn(delay: 180.ms, duration: 500.ms)
                    .slideY(
                      begin: 0.2,
                      end: 0,
                      delay: 180.ms,
                      duration: 500.ms,
                      curve: Curves.easeOutCubic,
                    ),
                const SizedBox(height: 40),
                _buildGlassCard(context, isLoading)
                    .animate()
                    .fadeIn(delay: 280.ms, duration: 600.ms)
                    .slideY(
                      begin: 0.15,
                      end: 0,
                      delay: 280.ms,
                      duration: 600.ms,
                      curve: Curves.easeOutCubic,
                    ),
                const SizedBox(height: 28),
                _buildGuestButton(context)
                    .animate()
                    .fadeIn(delay: 480.ms, duration: 500.ms),
                const SizedBox(height: 40),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildBackground() {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [AppColors.navyDeep, AppColors.navyDark, AppColors.navyMid],
          stops: [0.0, 0.5, 1.0],
        ),
      ),
    );
  }

  Widget _buildLogo() {
    return Image.asset(
      'assets/icons/flyflex_logo.png',
      width: 56,
      height: 56,
      fit: BoxFit.contain,
      errorBuilder: (_, __, ___) => Container(
        width: 56,
        height: 56,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          gradient: LinearGradient(
            colors: AppColors.goldGradient,
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: const Icon(
          Icons.flight_takeoff_rounded,
          color: AppColors.navyDeep,
          size: 28,
        ),
      ),
    );
  }

  Widget _buildTagline() {
    return Builder(builder: (context) => Text(
      context.l10n.splashTagline.toUpperCase(),
      style: GoogleFonts.inter(
        fontSize: 10,
        fontWeight: FontWeight.w600,
        color: AppColors.goldPure,
        letterSpacing: 2.5,
      ),
    ));
  }

  Widget _buildHeadline() {
    return Builder(builder: (context) => Column(
      children: [
        Text(context.l10n.loginWelcome, style: AppTypography.displayMedium),
        const SizedBox(height: 6),
        Text(context.l10n.loginTagline, style: AppTypography.bodyMedium),
      ],
    ));
  }

  Widget _buildGlassCard(BuildContext context, bool isLoading) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(AppRadius.xxl),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          padding: const EdgeInsets.all(AppSpacing.cardPadding + 4),
          decoration: BoxDecoration(
            color: AppColors.glassSurface,
            borderRadius: BorderRadius.circular(AppRadius.xxl),
            border: Border.all(color: AppColors.glassBorder),
          ),
          child: LoginForm(
            isLoading: isLoading,
            onSubmit: (email, password) =>
                context.read<AuthCubit>().login(email, password),
          ),
        ),
      ),
    );
  }

  Widget _buildGuestButton(BuildContext context) {
    return GestureDetector(
      onTap: () => context.go(AppRoutes.home),
      child: Text(
        context.l10n.loginContinueGuest,
        style: GoogleFonts.inter(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: AppColors.textMuted,
          decoration: TextDecoration.underline,
          decorationColor: AppColors.textMuted,
        ),
      ),
    );
  }
}
