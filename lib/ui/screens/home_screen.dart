import 'package:flutter/material.dart';
import 'trading_screen.dart';
import 'email_screen.dart';
import 'bank_screen.dart';
import '../widgets/notification.dart';
import '../widgets/email_notifications.dart';
import '../../game/services/main_game_music_service.dart';
import 'backend_market_screen.dart';
import '../../game/services/backend_inventory_service.dart';

class HomeScreen extends StatefulWidget {
  // StatefulWidget
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

Widget stockTradeAppIcon(BuildContext context) {
  return GestureDetector(
    onDoubleTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const TradingScreen()),
      );
    },
    child: SizedBox(
      width: 100,
      height: 100,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: 70,
            height: 70,
            child: Image.asset(
              'assets/images/stockAppIcon.png',
              fit: BoxFit.contain,
            ),
          ),
          const SizedBox(height: 4),
          const Text("R2R", style: TextStyle(color: Colors.white)),
        ],
      ),
    ),
  );
}

Widget bankAppIcon(BuildContext context) {
  return GestureDetector(
    onDoubleTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const BankScreen()),
      );
    },
    child: SizedBox(
      width: 100,
      height: 100,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: 60,
            height: 60,
            child: Image.asset(
              'assets/images/bankAppIcon.png',
              fit: BoxFit.contain,
            ),
          ),
          const SizedBox(height: 4),
          const Text("Bank", style: TextStyle(color: Colors.white)),
        ],
      ),
    ),
  );
}

Widget emailAppIcon(BuildContext context) {
  return GestureDetector(
    onDoubleTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const EmailScreen()),
      );
    },
    child: SizedBox(
      width: 100,
      height: 100,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: 60,
            height: 60,
            child: Image.asset(
              'assets/images/emailAppIcon.png',
              fit: BoxFit.contain,
            ),
          ),
          const SizedBox(height: 4),
          const Text("Email", style: TextStyle(color: Colors.white)),
        ],
      ),
    ),
  );
}

Widget backendMarketAppIcon(BuildContext context) {
  return GestureDetector(
    onDoubleTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => const BackendMarketScreen()),
      ).then((_) {
        (context as Element).markNeedsBuild();
      });
    },
    child: Column(
      children: [
        Image.asset(
          'assets/images/marketAppIcon.png',
          width: 60,
        ),
        const Text("Backend Market", style: TextStyle(color: Colors.white)),
      ],
    ),
  );
}


class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    MainGameMusicService().playBgm();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      showOldWinNotification(
        context: context,
        title: "Tutorial",
        message: "Welcome To Last Resort!\nDouble-Click Apps To Open Them\n\nClick Anywhere To Continue",
      );

      await Future.delayed(const Duration(seconds: 2));

      showBottomRightNotification(
        context: context,
        title: "BlueHeart Email 64",
        message: "You recieved 1 new email!",
      );
    });
  }

  final BackendInventoryService inventory = BackendInventoryService();

  @override
  void dispose() {
    MainGameMusicService().stopBgm();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/win64Background.png"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Positioned(top: 36, left: 50, child: stockTradeAppIcon(context)),
          Positioned(top: 40, left: 140, child: bankAppIcon(context)),
          Positioned(top: 40, left: 230, child: emailAppIcon(context)),
          Positioned(top: 50, left: 330, child: backendMarketAppIcon(context)),
          Positioned(
            bottom: 16,
            left: 16,
            child: Row(
              children: inventory.items.map((item) {
                return Padding(
                  padding: const EdgeInsets.only(right: 15),
                  child: Image.asset(
                    item.imagePath,
                    width: 100,
                    height: 100,
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
