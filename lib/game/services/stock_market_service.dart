import 'dart:async';
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
      'Risky Co.': Stock(name: 'Risky Co.', price: 100),
      'Moderate Co.': Stock(name: 'Moderate Co.', price: 100),
      'Safe Co.': Stock(name: 'Safe Co.', price: 100),
      'Bruh Co.': Stock(name: 'Bruh Co.', price: 100),
    };

    stockGeneratorIndex = {
      'Risky Co.': 6,
      'Moderate Co.': 4,
      'Safe Co.': 0,
      'Bruh Co.': 9,
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
      return true;
    }
    return false;
  }
}
