import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:fly_flex/core/di/injection.dart';
import 'package:fly_flex/core/router/app_router.dart';
import 'package:fly_flex/core/theme/app_colors.dart';
import 'package:fly_flex/features/auth/logic/cubit/auth_cubit.dart';
import 'package:fly_flex/features/auth/logic/state/auth_state.dart';
import 'package:fly_flex/features/onboarding/data/repositories/onboarding_repository.dart';
import 'package:fly_flex/core/utils/l10n_extension.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late final AuthCubit _authCubit;

  @override
  void initState() {
    super.initState();
    _authCubit = sl<AuthCubit>();
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
    ));
    Future.delayed(const Duration(milliseconds: 2000), () {
      if (mounted) _authCubit.checkAuth();
    });
  }

  @override
  void dispose() {
    _authCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _authCubit,
      child: BlocListener<AuthCubit, AuthState>(
        listener: _handleAuthState,
        child: Scaffold(
          backgroundColor: AppColors.navyDeep,
          body: _buildBody(),
        ),
      ),
    );
  }

  void _handleAuthState(BuildContext context, AuthState state) async {
    if (state is AuthAuthenticated) {
      context.go(AppRoutes.home);
    } else if (state is AuthInitial) {
      final hasSeenOnboarding =
          await sl<OnboardingRepository>().hasCompleted();
      if (context.mounted) {
        context.go(
          hasSeenOnboarding ? AppRoutes.login : AppRoutes.onboarding,
        );
      }
    }
  }

  Widget _buildBody() {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: const BoxDecoration(
        gradient: RadialGradient(
          center: Alignment.center,
          radius: 1.2,
          colors: [AppColors.navyMid, AppColors.navyDeep],
        ),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          _buildGlow(),
          _buildContent(),
          _buildLoadingIndicator(),
        ],
      ),
    );
  }

  Widget _buildGlow() {
    return Container(
      width: 260,
      height: 260,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: RadialGradient(
          colors: [
            AppColors.goldPure.withValues(alpha: 0.08),
            Colors.transparent,
          ],
        ),
      ),
    );
  }

  Widget _buildContent() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildLogo(),
        const SizedBox(height: 28),
        _buildTitle(),
        const SizedBox(height: 10),
        _buildTagline(),
      ],
    );
  }

  Widget _buildLogo() {
    return Container(
      width: 100,
      height: 100,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: AppColors.goldPure.withValues(alpha: 0.35),
            blurRadius: 48,
            spreadRadius: 8,
          ),
          BoxShadow(
            color: AppColors.goldPure.withValues(alpha: 0.15),
            blurRadius: 96,
            spreadRadius: 16,
          ),
        ],
      ),
      child: Image.asset(
        'assets/icons/flyflex_logo.png',
        width: 100,
        height: 100,
        fit: BoxFit.contain,
        errorBuilder: (_, __, ___) => Container(
          width: 100,
          height: 100,
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
            size: 48,
          ),
        ),
      ),
    )
        .animate()
        .fadeIn(duration: 700.ms, curve: Curves.easeOut)
        .scale(
          begin: const Offset(0.6, 0.6),
          end: const Offset(1.0, 1.0),
          duration: 900.ms,
          curve: Curves.easeOutBack,
        );
  }

  Widget _buildTitle() {
    return Builder(builder: (context) => ShaderMask(
      shaderCallback: (bounds) => const LinearGradient(
        colors: [AppColors.goldLight, AppColors.goldPure, AppColors.goldLight],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ).createShader(bounds),
      child: Text(
        context.l10n.appName,
        style: GoogleFonts.inter(
          fontSize: 46,
          fontWeight: FontWeight.w800,
          color: Colors.white,
          letterSpacing: -1.5,
          height: 1.0,
        ),
      ),
    ))
        .animate()
        .fadeIn(delay: 400.ms, duration: 700.ms)
        .slideY(
          begin: 0.3,
          end: 0,
          delay: 400.ms,
          duration: 700.ms,
          curve: Curves.easeOutCubic,
        );
  }

  Widget _buildTagline() {
    return Builder(builder: (context) => Text(
      context.l10n.splashTagline.toUpperCase(),
      style: GoogleFonts.inter(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: AppColors.textMuted,
        letterSpacing: 3.0,
      ),
    ))
        .animate()
        .fadeIn(delay: 700.ms, duration: 600.ms)
        .slideY(
          begin: 0.4,
          end: 0,
          delay: 700.ms,
          duration: 600.ms,
          curve: Curves.easeOutCubic,
        );
  }

  Widget _buildLoadingIndicator() {
    return Positioned(
      bottom: 60,
      child: SizedBox(
        width: 24,
        height: 24,
        child: CircularProgressIndicator(
          strokeWidth: 1.5,
          valueColor: AlwaysStoppedAnimation<Color>(
            AppColors.goldPure.withValues(alpha: 0.5),
          ),
        ),
      ),
    ).animate().fadeIn(delay: 1200.ms, duration: 500.ms);
  }
}
