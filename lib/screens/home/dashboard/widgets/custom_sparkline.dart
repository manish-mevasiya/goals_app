import 'package:flutter/material.dart';

class CustomSparkline extends StatelessWidget {
  final List<double> data;
  final List<String> labels;
  final Color lineColor;
  final List<Color> fillColors;

  const CustomSparkline({
    super.key,
    required this.data,
    required this.labels,
    this.lineColor = const Color(0xFF10B981),
    this.fillColors = const [
      Color(0x3310B981),
      Color(0x0010B981),
    ],
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: CustomPaint(
            size: Size.infinite,
            painter: _SparklinePainter(
              data: data,
              lineColor: lineColor,
              fillColors: fillColors,
            ),
          ),
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: labels.map((label) => Text(
            label,
            style: const TextStyle(
              color: Colors.grey,
              fontSize: 12,
            ),
          )).toList(),
        ),
      ],
    );
  }
}

class _SparklinePainter extends CustomPainter {
  final List<double> data;
  final Color lineColor;
  final List<Color> fillColors;

  _SparklinePainter({
    required this.data,
    required this.lineColor,
    required this.fillColors,
  });

  @override
  void paint(Canvas canvas, Size size) {
    if (data.isEmpty) return;

    final double width = size.width;
    final double height = size.height;

    final double minVal = 0.0;
    final double maxVal = data.reduce((a, b) => a > b ? a : b) * 1.1; // Add 10% padding on top
    final double valRange = maxVal - minVal;

    final double stepX = width / (data.length - 1);

    final List<Offset> points = [];
    for (int i = 0; i < data.length; i++) {
      final double x = i * stepX;
      final double normalizedY = valRange == 0 ? 0.5 : (data[i] - minVal) / valRange;
      // Invert Y because canvas (0,0) is at top-left
      final double y = height - (normalizedY * height);
      points.add(Offset(x, y));
    }

    // Generate smooth bezier curve path
    final Path path = Path();
    path.moveTo(points[0].dx, points[0].dy);

    for (int i = 0; i < points.length - 1; i++) {
      final Offset p0 = points[i];
      final Offset p1 = points[i + 1];
      
      // Control points for cubic bezier
      final double controlX = (p0.dx + p1.dx) / 2;
      path.cubicTo(
        controlX, p0.dy,
        controlX, p1.dy,
        p1.dx, p1.dy,
      );
    }

    // Paint the filled gradient under the path
    final Path fillPath = Path.from(path);
    fillPath.lineTo(width, height);
    fillPath.lineTo(0, height);
    fillPath.close();

    final Paint fillPaint = Paint()
      ..shader = LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: fillColors,
      ).createShader(Rect.fromLTRB(0, 0, width, height))
      ..style = PaintingStyle.fill;

    canvas.drawPath(fillPath, fillPaint);

    // Paint the line
    final Paint linePaint = Paint()
      ..color = lineColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.5
      ..strokeCap = StrokeCap.round
      ..isAntiAlias = true;

    canvas.drawPath(path, linePaint);
  }

  @override
  bool shouldRepaint(covariant _SparklinePainter oldDelegate) {
    return oldDelegate.data != data ||
        oldDelegate.lineColor != lineColor ||
        oldDelegate.fillColors != fillColors;
  }
}
