import 'dart:math';
import 'package:flutter/material.dart';

class AvatarProgressRing extends StatelessWidget {
  final double progress; // Between 0.0 and 1.0
  final Color progressColor;
  final String? avatarUrl;
  final String? initials;
  final double size;
  final double strokeWidth;

  const AvatarProgressRing({
    super.key,
    required this.progress,
    required this.progressColor,
    this.avatarUrl,
    this.initials,
    this.size = 56,
    this.strokeWidth = 3.5,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Circular Progress Line using CustomPainter
          Positioned.fill(
            child: CustomPaint(
              painter: _RingPainter(
                progress: progress,
                color: progressColor,
                strokeWidth: strokeWidth,
              ),
            ),
          ),
          // Inner Avatar
          Container(
            width: size - (strokeWidth * 2) - 4,
            height: size - (strokeWidth * 2) - 4,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: progressColor.withValues(alpha: 0.12),
            ),
            alignment: Alignment.center,
            child: ClipOval(
              child: avatarUrl != null
                  ? Image.network(
                      avatarUrl!,
                      fit: BoxFit.cover,
                      width: double.infinity,
                      height: double.infinity,
                      errorBuilder: (context, error, stackTrace) =>
                          _buildInitials(),
                    )
                  : _buildInitials(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInitials() {
    return Text(
      initials ?? "?",
      style: TextStyle(
        color: progressColor,
        fontWeight: FontWeight.bold,
        fontSize: size * 0.32,
      ),
    );
  }
}

class _RingPainter extends CustomPainter {
  final double progress;
  final Color color;
  final double strokeWidth;

  _RingPainter({
    required this.progress,
    required this.color,
    required this.strokeWidth,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final double radius = (size.width - strokeWidth) / 2;
    final Offset center = Offset(size.width / 2, size.height / 2);

    // Draw background track
    final Paint trackPaint = Paint()
      ..color = Colors.grey.shade100
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth;
    canvas.drawCircle(center, radius, trackPaint);

    // Draw active progress arc (starting from top -90 degrees)
    final Paint progressPaint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = strokeWidth;

    final double sweepAngle = 2 * pi * progress.clamp(0.0, 1.0);
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -pi / 2,
      sweepAngle,
      false,
      progressPaint,
    );
  }

  @override
  bool shouldRepaint(covariant _RingPainter oldDelegate) {
    return oldDelegate.progress != progress ||
        oldDelegate.color != color ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}
