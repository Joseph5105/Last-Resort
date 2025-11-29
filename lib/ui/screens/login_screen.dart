import 'package:flutter/material.dart';
import 'package:last_resort/ui/screens/home_screen.dart';
import '../widgets/pixel_button.dart';
import 'trading_screen.dart';
import '../../public/colors.dart';
import 'dart:io';


class LoginScreen extends StatefulWidget { // StatefulWidget
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

void closeApp() {
  exit(0);
}

void _showWelcomePopup(BuildContext context) {// Popup Function
  showDialog(// showDialog Flutter Function
    context: context,
    barrierDismissible: false,
    builder: (_) {
      return Dialog(// The Popup Box Itself
        backgroundColor: OldWinColors.background,
        shape: RoundedRectangleBorder(
          side: const BorderSide(color: Colors.black, width: 2),
          borderRadius: BorderRadius.zero,
        ),
        child: SizedBox(// Forces Dialog Box to Fixed Size
          width: 250,
          height: 150,  
          child: Padding(// Adds Padding inside the box
            padding: const EdgeInsets.all(8),
            child: Column(// Arranges content inside box
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(// The Title Content
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  color: OldWinColors.blue,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      // Centered title
                      const Text(
                        "Login",
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      // Positioned close button
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
                              color: OldWinColors.buttonLight, // grey background
                              border: Border(
                                top: BorderSide(color: Colors.white, width: 3),
                                left: BorderSide(color: Colors.white, width: 3),
                                bottom: BorderSide(color: OldWinColors.buttonDark, width: 3),
                                right: BorderSide(color: OldWinColors.buttonDark, width: 3),
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
                const Text(// Dialog message text below the title
                  "Click Here To Start",
                  style: TextStyle(
                    fontFamily: 'PixelFont',
                    fontSize: 14,
                    color: Colors.black,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 12),



                PixelButton(//Customized Button
                  label: "OK",
                  onPressed: () async {
                    // First close the popup
                    Navigator.pop(context);

                    // Show loading spinner
                    showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder: (_) {
                        return const Center(
                          child: SizedBox(
                            width: 80,
                            height: 80,
                            //child: CircularProgressIndicator(strokeWidth: 6),
                          ),
                        );
                      },
                    );

                    // Loading Spinner Time
                    //await Future.delayed(const Duration(seconds: 5));

                    // Close spinner
                    //Navigator.pop(context);

                    // Navigate to trading screen
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const HomeScreen(),
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




class _LoginScreenState extends State<LoginScreen> {
  @override
  void initState(){
    super.initState();
    Future.delayed(Duration.zero, () {
      _showWelcomePopup(context);
    });
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