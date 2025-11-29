import 'bank_balance.dart';
import '../../ui/screens/trading_screen.dart'; // For Transaction model

class StockBalance {
  static final StockBalance _instance = StockBalance._internal();
  factory StockBalance() => _instance;

  StockBalance._internal() {
    _balance = 0;
    transactions = [];
  }

  late double _balance;
  double get balance => _balance;

  // All stock transactions stored here
  late List<Transaction> transactions;

  // Deposit into stock balance
  void deposit(double amount) {
    if (amount <= 0) return;
    _balance += amount;
    transactions.insert(0, Transaction(type: "DEPOSIT", amount: amount));
  }

  // Withdraw to bank
  bool withdrawToBank(double amount) {
    if (amount <= 0 || amount > _balance) return false;

    _balance -= amount;
    transactions.insert(0, Transaction(type: "WITHDRAW", amount: amount));
    BankBalance().deposit(amount, "Withdrawal From R2R Stock Trading");
    return true;
  }

  // Buy stock
  bool buyingStock(double amount, String stockName) {
    if (amount <= 0 || amount > _balance) return false;

    _balance -= amount;
    transactions.insert(0, Transaction(type: "BUY", stockName: stockName, amount: amount));
    return true;
  }

  // Sell stock
  bool sellingStock(double amount, String stockName) {
    if (amount <= 0) return false;

    _balance += amount;
    transactions.insert(0, Transaction(type: "SELL", stockName: stockName, amount: amount));
    return true;
  }
}
