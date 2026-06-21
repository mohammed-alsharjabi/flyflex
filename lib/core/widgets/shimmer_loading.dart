import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import '../theme/app_colors.dart';
import '../theme/app_radius.dart';

class ShimmerBox extends StatelessWidget {
  const ShimmerBox({
    super.key,
    required this.width,
    required this.height,
    this.borderRadius,
  });

  final double width;
  final double height;
  final BorderRadius? borderRadius;

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: AppColors.navyLight,
      highlightColor: AppColors.navyAccent,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: AppColors.navyMid,
          borderRadius: borderRadius ?? AppRadius.cardBorderRadius,
        ),
      ),
    );
  }
}

class ShimmerFlightCard extends StatelessWidget {
  const ShimmerFlightCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: AppColors.navyLight,
      highlightColor: AppColors.navyAccent,
      child: Container(
        height: 140,
        margin: const EdgeInsets.only(bottom: 16),
        decoration: BoxDecoration(
          color: AppColors.navyMid,
          borderRadius: AppRadius.cardBorderRadius,
        ),
      ),
    );
  }
}
