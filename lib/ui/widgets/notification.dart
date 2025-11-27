import 'package:flutter/material.dart';
import '../../public/colors.dart';

class OldWinNotificationDialog extends StatelessWidget {
  final String title;
  final String message;

  const OldWinNotificationDialog({
    super.key,
    required this.title,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: OldWinColors.background,
      shape: RoundedRectangleBorder(
        side: const BorderSide(color: Colors.black, width: 2),
        borderRadius: BorderRadius.zero,
      ),
      child: SizedBox(
        width: 260,
        height: 150,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // HEADER BAR
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 4),
              color: OldWinColors.blue,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Text(
                    title,
                    style: const TextStyle(fontSize: 16, color: Colors.white),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),

            // MESSAGE
            Expanded(
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Text(
                    message,
                    style: const TextStyle(
                      fontFamily: "PixelFont",
                      fontSize: 14,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

void showOldWinNotification({
  required BuildContext context,
  required String title,
  required String message,
}) {
  showDialog(
    context: context,
    barrierDismissible: true,
    builder: (_) => OldWinNotificationDialog(title: title, message: message),
  );
}