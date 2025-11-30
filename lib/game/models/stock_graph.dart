import 'package:flutter/material.dart';

class StockGraph extends StatelessWidget {
  final List<double> history;

  const StockGraph({super.key, required this.history});

  @override
  Widget build(BuildContext context) {
    if (history.isEmpty) {
      return const SizedBox(height: 60);
    }

    final maxPrice = history.reduce((a, b) => a > b ? a : b);
    final minPrice = history.reduce((a, b) => a < b ? a : b);

    final double initialPrice = history.first;
    final double currentPrice = history.last;
    final bool isDown = currentPrice < initialPrice;

    return SizedBox(
      height: 60,
      width: double.infinity,
      child: CustomPaint(
        painter: _GraphPainter(
          history: history,
          min: minPrice,
          max: maxPrice,
          isDown: isDown,
        ),
      ),
    );
  }
}

class _GraphPainter extends CustomPainter {
  final List<double> history;
  final double min;
  final double max;
  final bool isDown;

  _GraphPainter({
    required this.history,
    required this.min,
    required this.max,
    required this.isDown,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = isDown ? Colors.redAccent : Colors.greenAccent
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    final path = Path();

    for (int i = 0; i < history.length; i++) {
      final double x = (i / (history.length - 1)) * size.width;

      final double y = size.height -
          ((history[i] - min) / ((max - min).abs() + 0.01)) * size.height;

      if (i == 0) {
        path.moveTo(x, y);
      } else {
        path.lineTo(x, y);
      }
    }

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
