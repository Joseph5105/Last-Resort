import 'package:flutter/material.dart';

class RetroHeader extends StatelessWidget {
  final String title;
  final VoidCallback onClose;

  const RetroHeader({super.key, required this.title, required this.onClose});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 34,
      color: Colors.red[900],
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Stack(
        children: [
          Center(
            child: Text(
              title.toUpperCase(),
              style: const TextStyle(
                fontFamily: "PixelFont",
                fontSize: 16,
                color: Colors.white,
              ),
            ),
          ),
          Positioned(
            right: 0,
            top: 4,
            child: GestureDetector(
              onTap: onClose,
              child: Container(
                width: 24,
                height: 24,
                decoration: BoxDecoration(
                  color: Colors.grey[800],
                  border: Border.all(color: Colors.black, width: 1),
                ),
                child: const Center(
                  child: Text(
                    "X",
                    style: TextStyle(
                      fontFamily: "PixelFont",
                      fontSize: 14,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
