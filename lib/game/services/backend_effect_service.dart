import 'dart:async';
import 'dart:math';
import 'stock_market_service.dart';
import 'stock_balance.dart';
import '../models/backend_item.dart';

class BackendEffectService {
  // Singleton
  static final BackendEffectService _instance = BackendEffectService._internal();
  factory BackendEffectService() => _instance;
  BackendEffectService._internal();

  final StockMarketService _market = StockMarketService();

  bool marketFrozen = false;
  double globalVolatilityMultiplier = 1.0;
  double globalUpBias = 0.0;

  void apply(BackendItemEffect effect) {
    switch (effect) {
      case BackendItemEffect.priceSpike:
        _priceSpike();
        break;
      case BackendItemEffect.priceDrop:
        _priceDrop();
        break;
      case BackendItemEffect.trojanDeposit:
        _trojanDeposit();
        break;
      case BackendItemEffect.marketFreeze:
        _freezeMarket();
        break;
      case BackendItemEffect.latencyInject:
        _latencyInject();
        break;
      case BackendItemEffect.packetSniff:
        _packetSniff();
        break;
      case BackendItemEffect.spoofOrders:
        _spoofOrders();
        break;
      case BackendItemEffect.rollbackPatch:
        _rollbackPatch();
        break;
      case BackendItemEffect.dataPoison:
        _dataPoison();
        break;
      case BackendItemEffect.clockSkew:
        _clockSkew();
        break;
      case BackendItemEffect.sandboxEscape:
        _sandboxEscape();
        break;
      case BackendItemEffect.darkPoolAccess:
        _darkPoolAccess();
        break;
    }
  }

  // --------------------
  // IMPLEMENTATIONS
  // --------------------

  void _priceSpike() {
    for (final stock in _market.stocks.values) {
      stock.updatePrice(stock.price * 2);
    }
  }

  void _priceDrop() {
    for (final stock in _market.stocks.values) {
      stock.updatePrice(max(stock.price * 0.5, 0.01));
    }
  }

  void _trojanDeposit() {
    StockBalance().deposit(20000);
  }

  void _freezeMarket() {
    if (marketFrozen) return;
    marketFrozen = true;
    _market.pauseUpdates(); // Stop updates
    Timer(const Duration(seconds: 60), () {
      marketFrozen = false;
      _market.resumeUpdates(); // Resume updates
    });
  }

  // Placeholder implementations for new effects
  void _latencyInject() {
    _market.addArtificialDelay(2000); // Implement this in StockMarketService
  }

  void _packetSniff() {
    _market.predictNextPrices(); // Implement this or leave placeholder
  }

  void _spoofOrders() {
    _market.createFakeBuyPressure(); // Implement this
  }

  void _rollbackPatch() {
    _market.rollbackToPreviousState(); // Implement in StockMarketService
  }

  void _dataPoison() {
    _market.corruptAnalytics(); // Implement
  }

  void _clockSkew() {
    _market.modifyTickRate(0.5); // slow down 50%
    Timer(const Duration(seconds: 30), () {
      _market.modifyTickRate(1.0); // reset
    });
  }

  void _sandboxEscape() {
    StockBalance().enableUnlimitedBuying(duration: const Duration(seconds: 30));
  }

  void _darkPoolAccess() {
    StockBalance().enableDarkPoolProfits(multiplier: 1.5, duration: const Duration(seconds: 30));
  }

  // --------------------
  // HOOKS
  // --------------------
  double applyVolatilityModifier(double volatility) {
    return volatility * globalVolatilityMultiplier;
  }

  double applyDirectionBias(double baseProbability) {
    return (baseProbability + globalUpBias).clamp(0.0, 1.0);
  }
}
