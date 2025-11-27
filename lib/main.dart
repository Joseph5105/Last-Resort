import 'package:flutter/material.dart';
import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'app/game_app.dart';

void main() {
  runApp(const GameApp());

  /*doWhenWindowReady(() {
    //displays window center on startup
    appWindow.alignment = Alignment.center;
    
    // Make window fullscreen
    appWindow.maximize();

    appWindow.size = const Size(800,800);

    // Optional: set title (for taskbar)
    appWindow.title = "Last Resort";

    // Show the window
    appWindow.show();

  }); Add a constant startup design to window*/ 
}

