import 'package:last_resort/game/services/bank_balance.dart';

class StockBalance {
  /*double _balance;

  StockBalance({double initialBalance = 0}) : _balance = initialBalance;

  double get balance => _balance;

  void deposit(double amount){
    _balance += amount;
  }

  void withdraw(double amount) {
    if(amount <= _balance){
      _balance -= amount;
    }
  }*/

  static final StockBalance _instance = StockBalance._internal();
  factory StockBalance() => _instance;

  StockBalance._internal(){
    _balance = 0;
  }

  late double _balance;

  double get balance => _balance;

  void deposit(double amount) {
    _balance += amount;
  }

  void withdraw(double amount) {
    if (amount <= _balance) {
      _balance -= amount;
    }
    BankBalance().deposit(amount, "Withdrawal From R2R Stock Trading");
  }

}