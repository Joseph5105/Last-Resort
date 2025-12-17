import 'package:last_resort/game/services/stock_balance.dart';

class BankBalance {
  // Singleton
  static final BankBalance _instance = BankBalance._internal();
  factory BankBalance() => _instance;
  BankBalance._internal() {
    previousBalance = balance; // Initialize previous balance
  }

  // Data
  double balance = 1000.0;
  double previousBalance = 1000.0; // <-- new field

  final List<Map<String, dynamic>> transactions = [
    {"type": "deposit", "amount": 1000.0, "note": "Get your money up \n- Mom"},
  ];

  // Deposit into bank
  void deposit(double amount, String note) {
    previousBalance = balance; // save previous balance
    balance += amount;
    transactions.insert(0, {
      "type": "deposit",
      "amount": amount,
      "note": note,
    });
  }

  /// Send money from the bank.
  /// [toR2R] = true means money goes to the global brokerage account.
  void sendMoney(double amount, String note, {bool toR2R = true}) {
    previousBalance = balance; // save previous balance
    balance -= amount;

    transactions.insert(0, {
      "type": "sent",
      "amount": amount,
      "note": note,
    });

    // Only deposit into StockBalance if sending to R2R
    if (toR2R) {
      StockBalance().deposit(amount);
    }
  }
}
