import 'package:flutter/material.dart';
import 'package:last_resort/game/services/sfx_service.dart';

class Win95BootScreen extends StatefulWidget {
  final VoidCallback onFinished;
  const Win95BootScreen({super.key, required this.onFinished});

  @override
  State<Win95BootScreen> createState() => _Win95BootScreenState();
}

class _Win95BootScreenState extends State<Win95BootScreen>
    with TickerProviderStateMixin {
  late AnimationController _fadeController;
  late Animation<double> _fadeAnimation;
  late AnimationController _loadingController;

  @override
  void initState() {
    super.initState();

    // Fade animation
    _fadeController = AnimationController(
        vsync: this, duration: const Duration(seconds: 1));
    _fadeAnimation = Tween<double>(begin: 0, end: 1).animate(_fadeController);
    _fadeController.forward();

    // Loading bar animation
    _loadingController =
        AnimationController(vsync: this, duration: const Duration(seconds: 4))
          ..repeat();

    // Play boot sound effect
    SfxService().login();
    // After 5 seconds, fade out and finish
    Future.delayed(const Duration(seconds: 5), () async {
      await _fadeController.reverse();
      widget.onFinished();
    });
  }

  @override
  void dispose() {
    _fadeController.dispose();
    _loadingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF000080),
      body: Center(
        child: FadeTransition(
          opacity: _fadeAnimation,
          child: Container(
            width: 350,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: const Color(0xFFC0C0C0),
              border: Border.all(color: Colors.black, width: 3),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  color: const Color(0xFF000080),
                  child: const Center(
                    child: Text(
                      "Burned Sand 95",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  "Starting Burned Sand...",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 25),
                Container(
                  width: 250,
                  height: 22,
                  padding: const EdgeInsets.all(2),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black, width: 2),
                  ),
                  child: AnimatedBuilder(
                    animation: _loadingController,
                    builder: (_, __) {
                      return Align(
                        alignment: Alignment(
                            -1 + (_loadingController.value * 2), 0),
                        child: Container(
                          width: 70,
                          height: 20,
                          color: const Color(0xFF008000),
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 25),
                const Text(
                  "© Bighard Corporation 1995",
                  style: TextStyle(fontSize: 12),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
