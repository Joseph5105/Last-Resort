import 'package:flutter/material.dart';
import '../../public/colors.dart';

class OldWinEmailNotificationDialog extends StatelessWidget {
  final String title;
  final String message;

  const OldWinEmailNotificationDialog({
    super.key,
    required this.title,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent, // allow underlying content to show
      child: Align(
        alignment: Alignment.bottomRight, // bottom-right position
        child: Container(
          margin: const EdgeInsets.all(16),
          width: 260,
          height: 150,
          decoration: BoxDecoration(
            color: OldWinColors.background,
            border: Border.all(color: Colors.black, width: 2),
          ),
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
      ),
    );
  }
}

// Helper function to show the bottom-right notification
void showBottomRightNotification({
  required BuildContext context,
  required String title,
  required String message,
  Duration duration = const Duration(seconds: 7),
}) {
  final overlay = Overlay.of(context);
  final overlayEntry = OverlayEntry(
    builder: (_) => OldWinEmailNotificationDialog(
      title: title,
      message: message,
    ),
  );

  overlay?.insert(overlayEntry);

  // Auto-remove after the duration
  Future.delayed(duration, () {
    overlayEntry.remove();
  });
}
