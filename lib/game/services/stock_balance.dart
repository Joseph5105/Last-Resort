import 'dart:async';
import 'bank_balance.dart';
import '../../ui/screens/trading_screen.dart'; // For Transaction model

class StockBalance {
  static final StockBalance _instance = StockBalance._internal();
  factory StockBalance() => _instance;

  StockBalance._internal() {
    _balance = 0;
    transactions = [];
    _unlimitedBuyingActive = false;
    _darkPoolMultiplier = 1.0;
  }

  late double _balance;
  double get balance => _balance;

  late List<Transaction> transactions;

  // --------------------
  // Effect flags (initialized here)
  // --------------------
  bool _unlimitedBuyingActive = false;
  double _darkPoolMultiplier = 1.0;

  // --------------------
  // Basic Operations
  // --------------------
  void deposit(double amount) {
    if (amount <= 0) return;
    _balance += amount;
    transactions.insert(0, Transaction(type: "DEPOSIT", amount: amount));
  }

  bool withdrawToBank(double amount) {
    if (amount <= 0 || amount > _balance) return false;

    _balance -= amount;
    transactions.insert(0, Transaction(type: "WITHDRAW", amount: amount));
    BankBalance().deposit(amount, "Withdrawal From R2R Stock Trading");
    return true;
  }

  bool buyingStock(double amount, String stockName) {
    if (!_unlimitedBuyingActive && (amount <= 0 || amount > _balance)) {
      return false;
    }

    if (!_unlimitedBuyingActive) {
      _balance -= amount;
    }

    transactions.insert(
      0,
      Transaction(type: "BUY", stockName: stockName, amount: amount),
    );
    return true;
  }

  bool sellingStock(double amount, String stockName) {
    if (amount <= 0) return false;

    _balance += amount * _darkPoolMultiplier;

    transactions.insert(
      0,
      Transaction(type: "SELL", stockName: stockName, amount: amount),
    );
    return true;
  }

  // --------------------
  // Special Item Effects
  // --------------------
  void enableUnlimitedBuying({required Duration duration}) {
    _unlimitedBuyingActive = true;
    Timer(duration, () => _unlimitedBuyingActive = false);
  }

  void enableDarkPoolProfits({
    required double multiplier,
    required Duration duration,
  }) {
    _darkPoolMultiplier = multiplier;
    Timer(duration, () => _darkPoolMultiplier = 1.0);
  }
}
