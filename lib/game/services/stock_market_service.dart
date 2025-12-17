import 'dart:async';
import 'dart:math';
import 'package:last_resort/game/services/sfx_service.dart';

import '../models/stock.dart';
import 'stock_price_generator.dart';
import 'stock_balance.dart';

class StockMarketService {
  // Singleton
  static final StockMarketService _instance = StockMarketService._internal();
  factory StockMarketService() => _instance;
  StockMarketService._internal() {
    _init();
  }

  final List<StockPriceGenerator> generators =
      List.generate(10, (i) => StockPriceGenerator(riskLevel: i + 1));

  late Map<String, Stock> stocks;
  late Map<String, int> stockGeneratorIndex;

  Timer? _timer;
  final Duration tickDuration = const Duration(milliseconds: 500);

  final StreamController<void> _priceUpdateController = StreamController.broadcast();
  Stream<void> get priceUpdates => _priceUpdateController.stream;

  bool _paused = false;
  bool _artificialDelayActive = false;
  double _tickRateMultiplier = 1.0;

  // For dropping next updates
  int _dropNextTicks = 0;

  void _init() {
    stocks = {
      'Wallspire Fortifications Ltd.': Stock(name: 'Wallspire Fortifications Ltd.', price: 15.65),
      'Helion Dropworks': Stock(name: 'Helion Dropworks', price: 18.92),
      'Nightspire Recovery Agency': Stock(name: 'Nightspire Recovery Agency', price: 16.74),
      'Moon Melody Hall': Stock(name: 'Moon Melody Hall', price: 6.74),
    };

    stockGeneratorIndex = {
      'Wallspire Fortifications Ltd.': 1,
      'Helion Dropworks': 5,
      'Nightspire Recovery Agency': 7,
      'Moon Melody Hall': 4,
    };

    _timer = Timer.periodic(tickDuration, (_) => _updatePrices());
  }

  void _updatePrices() async {
    if (_paused) return;

    // Handle artificial delay effect
    if (_artificialDelayActive) {
      await Future.delayed(const Duration(milliseconds: 10000));
      _artificialDelayActive = false; // apply once
    }

    // Handle dropped updates
    if (_dropNextTicks > 0) {
      _dropNextTicks--;
      return;
    }

    stocks.forEach((name, stock) {
      int index = stockGeneratorIndex[name]!;
      double newPrice = generators[index].nextPrice(stock) * _tickRateMultiplier;
      stock.updatePrice(newPrice);
    });

    _priceUpdateController.add(null); // notify UI
  }

  void updateAll() => _updatePrices();

  void pauseUpdates() => _paused = true;
  void resumeUpdates() => _paused = false;

  // --------------------
  // Stock Operations
  // --------------------
  bool buy(String stockName, int shares) {
    final stock = stocks[stockName]!;
    final cost = stock.price * shares;

    if (StockBalance().buyingStock(cost, stockName)) {
      stock.owned += shares;
      SfxService().buy();
      return true;
    }
    return false;
  }

  bool sell(String stockName, int shares) {
    final stock = stocks[stockName]!;
    if (stock.owned < shares) return false;

    final amount = stock.price * shares;
    if (StockBalance().sellingStock(amount, stockName)) {
      stock.owned -= shares;
      SfxService().sell();
      return true;
    }
    return false;
  }

  // --------------------
  // New Item Effects
  // --------------------
  void addArtificialDelay(int milliseconds) {//Works
    _artificialDelayActive = true;
  }

  void predictNextPrices() {//Works
    // Example: temporarily bias next tick by +10% for all stocks
    stocks.forEach((_, stock) {
      stock.updatePrice(stock.price + stock.price * 1.0);
    });
  }

  void createFakeBuyPressure() {//Works
    // Example: increase volatility multiplier for next tick
    for (final stock in stocks.values) {
      final change = (Random().nextDouble() * 0.9 - 0.1) * stock.price;
      stock.updatePrice(max(stock.price + change, 0.01));
    }
  }

  void rollbackToPreviousState() {//Works
    // Simple implementation: reset to initial prices
    stocks['Wallspire Fortifications Ltd.']!.updatePrice(15.65);
    stocks['Helion Dropworks']!.updatePrice(18.92);
    stocks['Nightspire Recovery Agency']!.updatePrice(16.74);
    stocks['Moon Melody Hall']!.updatePrice(6.74);
  }

  void corruptAnalytics() {
    // Example: randomize prices slightly
    for (final stock in stocks.values) {//Works
      stock.updatePrice(stock.price * (0.9 + Random().nextDouble() * 0.2));
    }
  }

  void modifyTickRate(double multiplier) {//Doesnt work as previously intended
    _tickRateMultiplier = multiplier;
  }

}
