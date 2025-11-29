import 'package:flutter/material.dart';
import '../../game/models/stock.dart';
import '../../game/models/stock_graph.dart';
import '../widgets/retro_button.dart';

class StockWidget extends StatelessWidget {
  final Stock stock;
  final VoidCallback onTick;
  final VoidCallback onBuy;
  final VoidCallback onSell;

  const StockWidget({
    super.key,
    required this.stock,
    required this.onTick,
    required this.onBuy,
    required this.onSell,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 180,
      decoration: BoxDecoration(
        color: Colors.black,
        border: Border.all(color: Colors.greenAccent, width: 3),
      ),
      child: Column(
        children: [
          // Retro top header
          Container(
            padding: const EdgeInsets.all(6),
            width: double.infinity,
            color: Colors.green.withOpacity(0.2),
            child: Text(
              stock.name.toUpperCase(),
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontFamily: "PixelFont",
                fontSize: 16,
                color: Colors.greenAccent,
              ),
            ),
          ),

          // Graph
          SizedBox(height: 100, child: StockGraph(history: stock.history)),

          const SizedBox(height: 6),

          Text(
            "\$${stock.price.toStringAsFixed(2)}",
            style: const TextStyle(
              fontFamily: "PixelFont",
              fontSize: 18,
              color: Colors.white,
            ),
          ),

          const SizedBox(height: 4),

          Text(
            "OWNED: ${stock.owned}",
            style: const TextStyle(
              fontFamily: "PixelFont",
              fontSize: 14,
              color: Colors.greenAccent,
            ),
          ),

          const SizedBox(height: 10),

          // Buy/Sell row
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              RetroButton(
                label: "BUY",
                color: Colors.greenAccent,
                onPressed: onBuy,
              ),
              const SizedBox(width: 10),
              RetroButton(
                label: "SELL",
                color: Colors.redAccent,
                onPressed: onSell,
              ),
            ],
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}
