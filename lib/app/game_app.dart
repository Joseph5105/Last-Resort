import 'package:flutter/material.dart';
import '../../ui/themes/pixel_theme.dart';
import '../ui/screens/login_screen.dart';


class GameApp extends StatelessWidget {
  const GameApp({super.key});


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Stock Trading Roguelike',
      theme: PixelTheme.theme,
      home: const LoginScreen(),
      debugShowCheckedModeBanner: false,
      );
    }
}