import 'package:flutter/material.dart';
import 'package:last_resort/game/services/sfx_service.dart';

class FinFangSharkEventService {
  static final FinFangSharkEventService _instance =
      FinFangSharkEventService._internal();

  factory FinFangSharkEventService() => _instance;
  FinFangSharkEventService._internal();

  bool _played = false;

  void tryTrigger({required BuildContext context, required double debt}) {
    if (debt > 0 || _played) return;

    _played = true;

    Navigator.of(context).push(
      PageRouteBuilder(
        opaque: false,
        pageBuilder: (_, __, ___) => const _SharkDeathOverlay(),
      ),
    );
  }
}

class _SharkDeathOverlay extends StatefulWidget {
  const _SharkDeathOverlay();

  @override
  State<_SharkDeathOverlay> createState() => _SharkDeathOverlayState();
}

class _SharkDeathOverlayState extends State<_SharkDeathOverlay>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _sharkX;
  late Animation<double> _fade;

  @override
  void initState() {
    super.initState();

    SfxService().playSfx('audio/shark.wav');

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    );

    _sharkX = Tween<double>(
      begin: 1.2,
      end: -0.6,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeIn));

    _fade = Tween<double>(begin: 1.0, end: 0.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.35, 0.55, curve: Curves.easeOut),
      ),
    );

    _controller.forward();

    Future.delayed(const Duration(milliseconds: 2200), () {
      SfxService().playSfx('audio/gunshot.wav');
    });

    Future.delayed(const Duration(seconds: 4), () {
      Navigator.pop(context);
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black.withOpacity(0.85),
      body: AnimatedBuilder(
        animation: _controller,
        builder: (_, __) {
          return Stack(
            children: [
              if (_controller.value < 0.55)
                Center(
                  child: Opacity(
                    opacity: _fade.value,
                    child: const Text(
                      "DEBT CLEARED",
                      style: TextStyle(
                        fontFamily: "PixelFont",
                        fontSize: 36,
                        color: Colors.greenAccent,
                      ),
                    ),
                  ),
                ),
              Positioned(
                top: MediaQuery.of(context).size.height * 0.45,
                left: MediaQuery.of(context).size.width * _sharkX.value,
                child: Image.asset(
                  "assets/images/Shark.png",
                  width: 220,
                  fit: BoxFit.contain,
                ),
              ),
              if (_controller.value > 0.55)
                const Center(
                  child: Text(
                    "FINFANG DEFEATED",
                    style: TextStyle(
                      fontFamily: "PixelFont",
                      fontSize: 28,
                      color: Colors.redAccent,
                    ),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }
}
