import 'package:flutter/material.dart';
import 'package:fly_flex/core/theme/app_colors.dart';

class TearLineWidget extends StatelessWidget {
  const TearLineWidget({super.key, this.backgroundColor = AppColors.navyDeep});

  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 28,
      child: Row(
        children: [
          _EdgeNotch(left: true, backgroundColor: backgroundColor),
          Expanded(
            child: CustomPaint(
              painter: _TearLinePainter(),
              child: const SizedBox.expand(),
            ),
          ),
          _EdgeNotch(left: false, backgroundColor: backgroundColor),
        ],
      ),
    );
  }
}

class _EdgeNotch extends StatelessWidget {
  const _EdgeNotch({required this.left, required this.backgroundColor});

  final bool left;
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    return ClipRect(
      child: Align(
        alignment: left ? Alignment.centerRight : Alignment.centerLeft,
        widthFactor: 0.5,
        child: Container(
          width: 28,
          height: 28,
          decoration: BoxDecoration(
            color: backgroundColor,
            shape: BoxShape.circle,
          ),
        ),
      ),
    );
  }
}

class _TearLinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AppColors.glassBorderBright
      ..strokeWidth = 1.5
      ..style = PaintingStyle.stroke;
    const dashWidth = 8.0;
    const dashSpace = 5.0;
    var x = 0.0;
    while (x < size.width) {
      canvas.drawLine(
        Offset(x, size.height / 2),
        Offset(x + dashWidth, size.height / 2),
        paint,
      );
      x += dashWidth + dashSpace;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
