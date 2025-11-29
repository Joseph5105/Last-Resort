import 'package:flutter/material.dart';
import 'package:last_resort/game/services/sfx_service.dart';
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
    return IgnorePointer( // <-- DOES NOT BLOCK TOUCHES
      ignoring: true,
      child: Material(
        color: Colors.transparent,
        child: Align(
          alignment: Alignment.bottomRight,
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
                  child: Center(
                    child: Text(
                      title,
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.center,
                    ),
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
      ),
    );
  }
}

void showBottomRightNotification({
  required BuildContext context,
  required String title,
  required String message,
  Duration duration = const Duration(seconds: 6),
}) {
  final overlay = Overlay.of(context);

  // Play notification sound AFTER current frame
  WidgetsBinding.instance.addPostFrameCallback((_) {
    SfxService().notification();
  });

  // Create bottom-right popup
  final overlayEntry = OverlayEntry(
    builder: (_) => OldWinEmailNotificationDialog(
      title: title,
      message: message,
    ),
  );

  overlay.insert(overlayEntry);

  // Remove after delay
  Future.delayed(duration, () {
    overlayEntry.remove();
  });
}

