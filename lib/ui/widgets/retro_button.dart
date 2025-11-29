import 'package:flutter/material.dart';

class RetroButton extends StatelessWidget {
  final String label;
  final Color color;
  final VoidCallback onPressed;

  const RetroButton({
    super.key,
    required this.label,
    required this.color,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        decoration: BoxDecoration(
          color: Colors.black,
          border: Border.all(color: color, width: 2),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontFamily: "PixelFont",
            fontSize: 14,
            color: color,
          ),
        ),
      ),
    );
  }
}
