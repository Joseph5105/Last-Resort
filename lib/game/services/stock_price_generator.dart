import 'dart:math';
import '../models/stock.dart';

class StockPriceGenerator {
  final Random _rng = Random();
  final int riskLevel; // 1–10

  StockPriceGenerator({required this.riskLevel});

  double nextPrice(Stock s) {
    // 1. Base volatility (small swings for all)
    double baseMinVol = 0.001; // 0.1%
    double baseMaxVol = 0.10;  // 10%
    double volatility = baseMinVol + _rng.nextDouble() * (baseMaxVol - baseMinVol);

    // 2. Apply rare risk-based spikes
    double spikeChance = riskLevel * 0.01; // 1% → 10%
    if (_rng.nextDouble() < spikeChance) {
      double spikeMultiplier = 1 + _rng.nextDouble() * riskLevel * 0.1; // 1x → 2x+
      volatility *= spikeMultiplier;
    }

    // 3. Bias direction if price < $1
    double upProbability = s.price < 1.0 ? 0.7 : 0.5; // 70% chance to go up if cheap
    double direction = _rng.nextDouble() < upProbability ? 1 : -1;

    // 4. Calculate delta and clamp to avoid crashes
    double delta = s.price * volatility * direction;
    double maxDelta = s.price * 0.5; // can't move more than 50% in one tick
    delta = delta.clamp(-maxDelta, maxDelta);

    // 5. Final price
    double next = s.price + delta;
    next = next.clamp(0.01, double.infinity);

    // 6. Update stock history
    s.updatePrice(double.parse(next.toStringAsFixed(2)));

    return s.price;
  }
}
