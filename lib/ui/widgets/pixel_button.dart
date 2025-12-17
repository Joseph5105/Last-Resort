import 'package:flutter/material.dart';
import '../../public/colors.dart';

class PixelButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  final Color textColor;

  const PixelButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.textColor = Colors.black, // default = black
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        decoration: BoxDecoration(
          color: OldWinColors.buttonLight,
          border: Border(
            top: BorderSide(color: Colors.white, width: 3),
            left: BorderSide(color: Colors.white, width: 3),
            bottom: BorderSide(color: OldWinColors.buttonDark, width: 3),
            right: BorderSide(color: OldWinColors.buttonDark, width: 3),
          ),
        ),
        child: Text(
          label,
          style: TextStyle(fontFamily: "PixelFont", color: textColor),
        ),
      ),
    );
  }
}
