import 'package:flutter/material.dart';
import 'dart:io';
import 'package:last_resort/ui/screens/home_screen.dart';
import 'package:last_resort/ui/widgets/windows_95_boot_screen.dart';
import '../widgets/pixel_button.dart';
import '../../public/colors.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

void closeApp() => exit(0);

class _LoginScreenState extends State<LoginScreen> {
  bool openedApp = false;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      _showWelcomePopup();
    });
  }

  void _showWelcomePopup() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) {
        return Dialog(
          backgroundColor: OldWinColors.background,
          shape: RoundedRectangleBorder(
            side: const BorderSide(color: Colors.black, width: 2),
            borderRadius: BorderRadius.zero,
          ),
          child: SizedBox(
            width: 250,
            height: 150,
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    color: OldWinColors.blue,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        const Text(
                          "Login",
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        Positioned(
                          right: 5,
                          child: GestureDetector(
                            onTap: () async {
                              Navigator.pop(context);
                              await Future.delayed(const Duration(seconds: 2));
                              closeApp();
                            },
                            child: Container(
                              width: 20,
                              height: 20,
                              decoration: BoxDecoration(
                                color: OldWinColors.buttonLight,
                                border: Border(
                                  top: BorderSide(
                                    color: Colors.white,
                                    width: 3,
                                  ),
                                  left: BorderSide(
                                    color: Colors.white,
                                    width: 3,
                                  ),
                                  bottom: BorderSide(
                                    color: OldWinColors.buttonDark,
                                    width: 3,
                                  ),
                                  right: BorderSide(
                                    color: OldWinColors.buttonDark,
                                    width: 3,
                                  ),
                                ),
                              ),
                              child: const Center(
                                child: Text(
                                  "X",
                                  style: TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    "Click Here To Start",
                    style: TextStyle(
                      fontFamily: 'PixelFont',
                      fontSize: 14,
                      color: Colors.black,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 12),
                  PixelButton(
                    label: "OK",
                    onPressed: () {
                      Navigator.pop(context);

                      // Navigate to boot screen
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => Win95BootScreen(
                            onFinished: () {
                              // Navigate to HomeScreen after boot completes
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => const HomeScreen(),
                                ),
                              );
                            },
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/lockscreen.jpg"),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
