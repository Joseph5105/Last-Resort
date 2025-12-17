import 'package:flutter/material.dart';

class TransactionLog extends StatelessWidget {
  final List transactions;

  const TransactionLog({super.key, required this.transactions});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      padding: const EdgeInsets.all(6),
      decoration: BoxDecoration(
        color: Colors.black,
        border: Border.all(color: Colors.greenAccent, width: 2),
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(4),
            width: double.infinity,
            color: Colors.green.withOpacity(0.2),
            child: const Text(
              "TRANSACTIONS",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: "PixelFont",
                fontSize: 18,
                color: Colors.greenAccent,
              ),
            ),
          ),
          const SizedBox(height: 6),
          Expanded(
            child: ListView.builder(
              itemCount: transactions.length,
              itemBuilder: (context, index) {
                final tx = transactions[index];
                return Container(
                  margin: const EdgeInsets.symmetric(vertical: 2),
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: Colors.grey[900],
                    border: Border.all(color: Colors.greenAccent, width: 1),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${tx.type}${tx.stockName != null ? " ${tx.stockName}" : ""}",
                        style: const TextStyle(
                          fontFamily: "PixelFont",
                          fontSize: 13,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        "\$${tx.amount.toStringAsFixed(2)}",
                        style: const TextStyle(
                          fontFamily: "PixelFont",
                          fontSize: 16,
                          color: Colors.greenAccent,
                        ),
                      ),
                      Text(
                        "${tx.timestamp.hour.toString().padLeft(2, '0')}:${tx.timestamp.minute.toString().padLeft(2, '0')}:${tx.timestamp.second.toString().padLeft(2, '0')}",
                        style: const TextStyle(
                          fontFamily: "PixelFont",
                          fontSize: 12,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
