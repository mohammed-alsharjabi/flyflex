import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/theme/app_colors.dart';

class AnimatedCounter extends StatefulWidget {
  const AnimatedCounter({
    super.key,
    required this.target,
    required this.suffix,
    this.style,
    this.duration = const Duration(milliseconds: 1800),
    this.curve = Curves.easeOutCubic,
    this.startDelay = Duration.zero,
  });

  final int target;
  final String suffix;
  final TextStyle? style;
  final Duration duration;
  final Curve curve;
  final Duration startDelay;

  @override
  State<AnimatedCounter> createState() => _AnimatedCounterState();
}
class _AnimatedCounterState extends State<AnimatedCounter>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _animation;
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: widget.duration,
    );
    _animation = CurvedAnimation(
      parent: _controller,
      curve: widget.curve,
    );

    Future.delayed(widget.startDelay, () {
      if (mounted) _controller.forward();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final defaultStyle = GoogleFonts.inter(
      fontSize: 40,
      fontWeight: FontWeight.w900,
      color: AppColors.goldPure,
      letterSpacing: -1.5,
      height: 1,
    );

    return AnimatedBuilder(
      animation: _animation,
      builder: (context, _) {
        final value = (_animation.value * widget.target).round();
        return Text(
          '$value${widget.suffix}',
          style: widget.style ?? defaultStyle,
        );
      },
    );
  }
}
