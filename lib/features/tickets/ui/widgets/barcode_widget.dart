import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:fly_flex/core/theme/app_colors.dart';

class BarcodeWidget extends StatelessWidget {
  const BarcodeWidget({
    super.key,
    required this.data,
    this.height = 72,
  });

  final String data;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: height,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
          ),
          clipBehavior: Clip.hardEdge,
          child: CustomPaint(
            painter: _BarcodePainter(seed: data.hashCode),
            child: const SizedBox.expand(),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          data,
          style: GoogleFonts.spaceMono(
            fontSize: 10,
            color: AppColors.textMuted,
            letterSpacing: 1.2,
            fontWeight: FontWeight.w500,
          ),
          textAlign: TextAlign.center,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }
}

class _BarcodePainter extends CustomPainter {
  _BarcodePainter({required this.seed});

  final int seed;

  @override
  void paint(Canvas canvas, Size size) {
    final rng = math.Random(seed);
    final paint = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.fill;

    var x = 4.0;
    while (x < size.width - 4) {
      final barWidth = rng.nextDouble() * 3 + 1;
      final gap = rng.nextDouble() * 2.5 + 0.8;
      canvas.drawRect(Rect.fromLTWH(x, 0, barWidth, size.height), paint);
      x += barWidth + gap;
    }
  }

  @override
  bool shouldRepaint(_BarcodePainter old) => old.seed != seed;
}
