import 'package:flutter/material.dart';
import '../../../game/services/stock_balance.dart';

class BalanceDisplay extends StatelessWidget {
  const BalanceDisplay({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text(
          "BROKERAGE BALANCE",
          style: TextStyle(
            fontFamily: "PixelFont",
            fontSize: 45,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          "\$${StockBalance().balance.toStringAsFixed(2)}",
          style: const TextStyle(
            fontFamily: "PixelFont",
            fontSize: 35,
            color: Colors.greenAccent,
          ),
        ),
      ],
    );
  }
}
