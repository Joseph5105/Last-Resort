import 'package:flutter/material.dart';
import '../widgets/stock_widget.dart';

class StockGrid extends StatelessWidget {
  final Map<String, dynamic> stocks;
  final void Function() onTick;
  final void Function(String) onBuy;
  final void Function(String) onSell;

  const StockGrid({
    super.key,
    required this.stocks,
    required this.onTick,
    required this.onBuy,
    required this.onSell,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Wrap(
        spacing: 14,
        runSpacing: 14,
        children: stocks.entries.map((entry) {
          return StockWidget(
            stock: entry.value,
            onTick: onTick,
            onBuy: () => onBuy(entry.key),
            onSell: () => onSell(entry.key),
          );
        }).toList(),
      ),
    );
  }
}
