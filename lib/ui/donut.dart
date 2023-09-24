import 'package:flutter/material.dart';
import 'dart:math';

class ChartSection {
  final Color color;
  final double value;
  final String label;

  ChartSection({required this.color, required this.value, required this.label});
}


class DonutChart extends StatelessWidget {
  final Map<String, int> transactionCounts;

  const DonutChart({super.key, required this.transactionCounts});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: const Size(800, 800),
      painter: DonutChartPainter(transactionCounts: transactionCounts),
    );
  }
}

class DonutChartPainter extends CustomPainter {
  final Map<String, int> transactionCounts;

  DonutChartPainter({required this.transactionCounts});

  @override
  void paint(Canvas canvas, Size size) {
    final center = size.width / 2;
    final radius = size.width / 4;
    double startAngle = 0.0;
    transactionCounts.forEach((type, count) {
      final sweepAngle = (count / transactionCounts.values.reduce((a, b) => a + b)) * 2 * pi;
      final endAngle = startAngle + sweepAngle;
      final arcRect = Rect.fromCircle(center: Offset(center, center), radius: radius);

      final borderPaint = Paint()
        ..color = Colors.black
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.0;

      final borderRect = Rect.fromCircle(center: Offset(center, center), radius: radius);
      canvas.drawCircle(Offset(center, center), radius, borderPaint);

      final paint = Paint()
        ..color = getRandomColor()
        ..style = PaintingStyle.fill;
      canvas.drawArc(arcRect, startAngle, sweepAngle, true, paint);

      startAngle = endAngle;

      final text = TextSpan(
        text: '$type: $count',
        style: const TextStyle(fontSize: 13, color: Colors.white),
      );
      final textPainter = TextPainter(
        text: text,
        textDirection: TextDirection.ltr,
      );
      textPainter.layout();
      final angle = startAngle - sweepAngle / 2;
      final textX = center + radius / 1.5 * cos(angle) - textPainter.width / 2;
      final textY = center + radius / 1.5 * sin(angle) - textPainter.height / 2;
      textPainter.paint(canvas, Offset(textX, textY));
    });
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }

  Color getRandomColor() {
    final random = Random();
    return Color.fromARGB(
      255,
      random.nextInt(256),
      random.nextInt(256),
      random.nextInt(256),
    );
  }
}


