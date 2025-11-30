import 'dart:async';
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

  void _updatePrices() {
    stocks.forEach((name, stock) {
      int index = stockGeneratorIndex[name]!;
      double newPrice = generators[index].nextPrice(stock);
      stock.updatePrice(newPrice);
    });

    _priceUpdateController.add(null);
  }

  void updateAll() => _updatePrices();

  // BUY STOCK
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

  // SELL STOCK
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
}
