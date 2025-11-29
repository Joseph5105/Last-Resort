import 'dart:math';
import '../models/stock.dart';

class StockPriceGenerator {
  final Random _rng = Random();
  final int riskLevel;

  StockPriceGenerator({required this.riskLevel});

  double nextPrice(Stock s) {
    final maxDeltaPercent = 0.02 * riskLevel;
    double delta = s.price * maxDeltaPercent;

    if (riskLevel <= 3) {
      delta *= _rng.nextDouble();
      if (_rng.nextDouble() < 0.2) delta *= -1;
    } else if (riskLevel <= 6) {
      delta *= _rng.nextDouble() * (_rng.nextBool() ? 1 : -1);
    } else {
      delta *= (_rng.nextDouble() * 2 - 1);
    }

    return (s.price + delta).clamp(0, 99999999);
  }
}
