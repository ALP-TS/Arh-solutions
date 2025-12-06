import 'package:flutter/material.dart';
import 'dart:math' as math;

class MarkPer extends StatelessWidget {
  final double value;
  final double totalmark;
  final double percent;
  final double size;
  final double strokeWidth;
  final Duration animationDuration;

  const MarkPer({
    Key? key,
    required this.value,
    required this.totalmark,
    required this.percent,
    this.size = 200.0,
    this.strokeWidth = 12.0,
    this.animationDuration = const Duration(milliseconds: 1000),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween<double>(begin: 0.0, end: percent),
      duration: animationDuration,
      curve: Curves.easeOutCubic,
      builder: (context, animatedValue, child) {
        return CustomPaint(
          size: Size(size, size),
          painter: CircularProgressPainter(
            value: animatedValue,
            strokeWidth: strokeWidth,
          ),
          child: SizedBox(
            width: size,
            height: size,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '${value.round()}/${totalmark.round()}',
                    style: TextStyle(
                      fontSize: size * 0.15,
                      fontWeight: FontWeight.bold,
                      color: _getTextColor(animatedValue),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Color _getTextColor(double value) {
    if (value >= 0) {
      return const Color(0xFF10B981); // Green
    } else {
      return const Color(0xFFEF4444); // Red
    }
  }
}

class CircularProgressPainter extends CustomPainter {
  final double value;
  final double strokeWidth;

  CircularProgressPainter({
    required this.value,
    required this.strokeWidth,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = (size.width - strokeWidth) / 2;

    // Clamp value between -100 and 100
    final clampedValue = math.max(-100, math.min(100, value));
    final isPositive = clampedValue >= 0;
    final absValue = clampedValue.abs();

    // Background circle
    final backgroundPaint = Paint()
      ..color = Colors.grey[200]!
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    canvas.drawCircle(center, radius, backgroundPaint);

    // Progress arc
    if (absValue > 0) {
      final progressPaint = Paint()
        ..color = isPositive ? const Color(0xFF10B981) : const Color(0xFFEF4444)
        ..strokeWidth = strokeWidth
        ..style = PaintingStyle.stroke
        ..strokeCap = StrokeCap.round;

      // Add gradient effect
      progressPaint.shader = LinearGradient(
        colors: isPositive
            ? [const Color(0xFF34D399), const Color(0xFF10B981)]
            : [const Color(0xFFF87171), const Color(0xFFEF4444)],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ).createShader(Rect.fromCircle(center: center, radius: radius));

      final sweepAngle = (absValue / 100) * 2 * math.pi;

      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius),
        -math.pi / 2, // Start from top
        sweepAngle,
        false,
        progressPaint,
      );

      // Add glow effect
      final glowPaint = Paint()
        ..color =
            (isPositive ? const Color(0xFF10B981) : const Color(0xFFEF4444))
                .withOpacity(0.3)
        ..strokeWidth = strokeWidth + 4
        ..style = PaintingStyle.stroke
        ..strokeCap = StrokeCap.round
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 3);

      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius),
        -math.pi / 2,
        sweepAngle,
        false,
        glowPaint,
      );
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
