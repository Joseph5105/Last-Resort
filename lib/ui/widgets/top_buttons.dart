import 'package:flutter/material.dart';
import '../widgets/pixel_button.dart';

class TopButtons extends StatelessWidget {
  final bool showWithdraw;
  final VoidCallback toggleWithdraw;

  const TopButtons({
    super.key,
    required this.showWithdraw,
    required this.toggleWithdraw,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        PixelButton(
          label: showWithdraw ? "Cancel" : "Withdraw",
          onPressed: toggleWithdraw,
        ),
      ],
    );
  }
}
