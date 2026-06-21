import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:fly_flex/core/di/injection.dart';
import 'package:fly_flex/core/router/app_router.dart';
import 'package:fly_flex/core/theme/app_colors.dart';
import 'package:fly_flex/core/theme/app_spacing.dart';
import 'package:fly_flex/features/onboarding/logic/cubit/onboarding_cubit.dart';
import 'package:fly_flex/features/onboarding/logic/state/onboarding_state.dart';
import 'package:fly_flex/features/onboarding/ui/sections/onboarding_page_section.dart';
import 'package:fly_flex/features/onboarding/ui/widgets/onboarding_indicator.dart';
import 'package:fly_flex/features/onboarding/ui/widgets/onboarding_nav_button.dart';
import 'package:fly_flex/core/utils/l10n_extension.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final _pageController = PageController();

  @override
  void initState() {
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
    ));
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<OnboardingCubit>()..loadPages(),
      child: BlocConsumer<OnboardingCubit, OnboardingState>(
        listener: (context, state) {
          if (state is OnboardingCompleted) context.go(AppRoutes.login);
        },
        builder: (context, state) {
          if (state is! OnboardingReady) {
            return const Scaffold(backgroundColor: AppColors.navyDeep);
          }
          return _buildContent(context, state);
        },
      ),
    );
  }

  Widget _buildContent(BuildContext context, OnboardingReady state) {
    return Scaffold(
      backgroundColor: AppColors.navyDeep,
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          PageView.builder(
            controller: _pageController,
            itemCount: state.pages.length,
            onPageChanged: (page) =>
                context.read<OnboardingCubit>().nextPage(page),
            itemBuilder: (_, index) => OnboardingPageSection(
              page: state.pages[index],
              pageIndex: index,
            ),
          ),
          _buildSkipButton(context, state.isLastPage),
          _buildBottomNav(context, state),
        ],
      ),
    );
  }

  Widget _buildSkipButton(BuildContext context, bool isLastPage) {
    final topPadding = MediaQuery.of(context).padding.top + 16;
    return Positioned(
      top: topPadding,
      right: AppSpacing.screenHorizontal,
      child: AnimatedOpacity(
        opacity: isLastPage ? 0.0 : 1.0,
        duration: const Duration(milliseconds: 200),
        child: GestureDetector(
          onTap: () => context.go(AppRoutes.login),
          child: Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
            decoration: BoxDecoration(
              color: AppColors.glassSurface,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: AppColors.glassBorder),
            ),
            child: Text(
              context.l10n.buttonSkip,
              style: GoogleFonts.inter(
                fontSize: 13,
                fontWeight: FontWeight.w500,
                color: AppColors.textMuted,
              ),
            ),
          ),
        ),
      ).animate().fadeIn(delay: 300.ms, duration: 400.ms),
    );
  }

  Widget _buildBottomNav(BuildContext context, OnboardingReady state) {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Container(
        padding: EdgeInsets.fromLTRB(
          AppSpacing.screenHorizontal,
          AppSpacing.xl,
          AppSpacing.screenHorizontal,
          MediaQuery.of(context).padding.bottom + AppSpacing.xxl,
        ),
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
            colors: [
              AppColors.navyDeep,
              Color(0xCC050D1F),
              Colors.transparent,
            ],
            stops: [0.0, 0.65, 1.0],
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            OnboardingIndicator(
              currentPage: state.currentPage,
              count: state.pages.length,
            ).animate().fadeIn(delay: 400.ms, duration: 400.ms),
            const SizedBox(height: AppSpacing.xxl),
            OnboardingNavButton(
              isLastPage: state.isLastPage,
              onPressed: () {
                if (state.isLastPage) {
                  context.read<OnboardingCubit>().complete();
                } else {
                  _pageController.nextPage(
                    duration: const Duration(milliseconds: 450),
                    curve: Curves.easeOutCubic,
                  );
                }
              },
            )
                .animate()
                .fadeIn(delay: 500.ms, duration: 400.ms)
                .slideY(
                  begin: 0.3,
                  end: 0,
                  delay: 500.ms,
                  duration: 400.ms,
                  curve: Curves.easeOutCubic,
                ),
          ],
        ),
      ),
    );
  }
}
