import 'package:last_resort/game/services/stock_balance.dart';

class BankBalance {
  // Singleton implementation (factory + private named constructor)
  static final BankBalance _instance = BankBalance._internal();
  factory BankBalance() => _instance;
  BankBalance._internal();

  // Data
  double balance = 100.0;

  final List<Map<String, dynamic>> transactions = [
    {"type": "deposit", "amount": 100.0, "note": "Get your money up \n- Mom"},
  ];

  // Methods
  void deposit(double amount, String note) {
    balance += amount;
    transactions.insert(0, {
      "type": "deposit",
      "amount": amount,
      "note": note,
    });
  }

  void sendMoney(double amount, String note) {
    balance -= amount;
    transactions.insert(0, {
      "type": "sent",
      "amount": amount,
      "note": note,
    });
    StockBalance().deposit(amount);// Adds money into global brokerage account balance
  }
}
