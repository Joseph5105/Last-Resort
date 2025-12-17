import 'package:flutter/material.dart';
import '../widgets/pixel_button.dart';

class WithdrawBox extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback onConfirm;

  const WithdrawBox({
    super.key,
    required this.controller,
    required this.onConfirm,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 20),
        SizedBox(
          width: 200,
          child: TextField(
            controller: controller,
            cursorColor: Colors.white,
            style: const TextStyle(
              fontFamily: "PixelFont",
              color: Colors.white,
            ),
            decoration: const InputDecoration(
              labelText: "Amount",
              labelStyle: TextStyle(
                fontFamily: "PixelFont",
                color: Colors.white,
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.white),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.greenAccent, width: 2),
              ),
            ),
          ),
        ),
        const SizedBox(height: 10),
        PixelButton(label: "Confirm", onPressed: onConfirm),
      ],
    );
  }
}
