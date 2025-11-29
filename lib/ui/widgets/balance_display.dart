import 'package:flutter/material.dart';
import '../../../game/services/stock_balance.dart';

class BalanceDisplay extends StatefulWidget {
  const BalanceDisplay({super.key});

  @override
  State<BalanceDisplay> createState() => _BalanceDisplayState();
}

class _BalanceDisplayState extends State<BalanceDisplay> {
  double displayedBalance = 0;

  @override
  void initState() {
    super.initState();
    displayedBalance = StockBalance().balance;
  }

  @override
  Widget build(BuildContext context) {
    final currentBalance = StockBalance().balance;

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
        TweenAnimationBuilder<double>(
          tween: Tween<double>(begin: displayedBalance, end: currentBalance),
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeOut,
          builder: (context, value, _) {
            return Text(
              "\$${value.toStringAsFixed(2)}",
              style: const TextStyle(
                fontFamily: "PixelFont",
                fontSize: 35,
                color: Colors.greenAccent,
              ),
            );
          },
          onEnd: () {
            displayedBalance = currentBalance;
          },
        ),
      ],
    );
  }
}
