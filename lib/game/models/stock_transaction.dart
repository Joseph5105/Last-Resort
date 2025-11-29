class Transaction {
  final String type; // "BUY", "SELL", "WITHDRAW", "DEPOSIT"
  final String? stockName; // null for deposits/withdrawals
  final double amount;
  final DateTime timestamp;

  Transaction({
    required this.type,
    this.stockName,
    required this.amount,
    DateTime? timestamp,
  }) : timestamp = timestamp ?? DateTime.now();
}
