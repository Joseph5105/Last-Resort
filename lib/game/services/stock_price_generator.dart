import 'dart:math';
import '../models/stock.dart';



class StockPriceGenerator {
  final Random _rng = Random();

  Stock generateNext(Stock s) {
    // Random price delta between -20% and +20%
    final delta = (s.price * 0.2) * (_rng.nextDouble() * 2 - 1);
    return s.copyWith(price: (s.price + delta).clamp(1, 99999));
  }
}