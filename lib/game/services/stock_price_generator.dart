import 'dart:math';
import '../models/stock.dart';

class StockPriceGenerator {
  final Random _rng = Random();
  final int riskLevel; // 1–10

  StockPriceGenerator({required this.riskLevel});

  double nextPrice(Stock s) {
    double price = s.price;

    /* --------------------------------------------------
       1. Base volatility scales with price LEVEL, not %
       -------------------------------------------------- */
    double dollarVolatility;

    if (price < 1.0) {
      // Stronger absolute movement to escape penny hell
      dollarVolatility = 0.05 + riskLevel * 0.03; // up to ~0.35
    } else if (price < 10.0) {
      dollarVolatility = price * (0.015 + riskLevel * 0.004);
    } else {
      dollarVolatility = price * (0.01 + riskLevel * 0.003);
    }

    /* --------------------------------------------------
       2. Slight positive market bias
       -------------------------------------------------- */
    double upProbability = 0.52; // default optimism

    if (price < 1.0) {
      upProbability = 0.70;      // strong recovery bias
    } else if (price < 5.0) upProbability = 0.58; // mild recovery bias

    double direction = _rng.nextDouble() < upProbability ? 1 : -1;

    /* --------------------------------------------------
       3. Risk-based spikes (whole-dollar movers)
       -------------------------------------------------- */
    if (_rng.nextDouble() < riskLevel * 0.02) {
      double spike = (0.2 + _rng.nextDouble()) * riskLevel;
      dollarVolatility += spike;
    }

    /* --------------------------------------------------
       4. Apply movement
       -------------------------------------------------- */
    double delta = dollarVolatility * direction;

    /* --------------------------------------------------
       5. Clamp extreme crashes but allow growth
       -------------------------------------------------- */
    //double maxDrop = price * 0.4; // can't lose more than 40% in one tick
    //delta = delta.clamp(-maxDrop, double.infinity);

   double next = (price + delta).clamp(0.01, double.infinity);

    /* --------------------------------------------------
       6. Update stock (round for realism)
       -------------------------------------------------- */
    s.updatePrice(double.parse(next.toStringAsFixed(2)));

    return s.price;
  }
}
