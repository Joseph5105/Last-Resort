import 'package:flutter/material.dart';

class Stock {
  String name;
  double price;

  Stock({required this.name, required this.price});

  Stock copyWith({String? name, double? price}){
    return Stock(
      name: name ?? this.name,
      price: price ?? this.price,
    );
  }

  // Displays stock
  Widget buildWidget(VoidCallback onTick) {
    return Column(
      children: [
        Text(
          name,
          style: const TextStyle(
            fontFamily: "PixelFont",
            fontSize: 16,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          "\$${price.toStringAsFixed(2)}",
          style: const TextStyle(
            fontFamily: "PixelFont",
            fontSize: 16,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 8),
        GestureDetector(
          onTap: onTick, // pass the updatePrice function here
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: Colors.grey[700],
              border: Border.all(color: Colors.black, width: 2),
            ),
            child: const Text(
              "Tick Price",
              style: TextStyle(
                fontFamily: "PixelFont",
                color: Colors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
