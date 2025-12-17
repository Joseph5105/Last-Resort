import 'package:flutter/material.dart';
import '../../../game/services/stock_balance.dart';
import '../widgets/retro_header.dart';
import '../widgets/notification.dart';
import '../../game/services/backend_inventory_service.dart';
import '../../public/backend_market_inventory.dart';
import '../../game/services/bank_balance.dart';
import '../../game/services/backend_effect_service.dart';
import '../../game/models/backend_item.dart';
import '../../game/services/market_music_service.dart';
import '../../game/services/main_game_music_service.dart';

class BackendMarketScreen extends StatefulWidget {
  const BackendMarketScreen({super.key});

  @override
  State<BackendMarketScreen> createState() => _BackendMarketScreenState();
}

class _BackendMarketScreenState extends State<BackendMarketScreen> {
  final BackendInventoryService inventory = BackendInventoryService();
  final BackendEffectService effectService = BackendEffectService();

  bool _isOwned(BackendItem item) => inventory.isOwned(item.id);

  void _buyItem(BackendItem item) {
    if (_isOwned(item)) return;

    final bank = BankBalance();
    if (bank.balance < item.price) {
      _showNotification("Transaction Failed", "Insufficient bank funds.");
      return;
    }

    bank.sendMoney(item.price, "Purchased ${item.name}", toR2R: false);
    inventory.addItem(item.id);

    if (item.effect != null) {
      effectService.apply(item.effect!);
    }

    _showNotification(
      "Purchase Successful",
      "${item.name} added to inventory.",
    );
    setState(() {});
  }

  void _showNotification(String title, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Colors.black87,
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontFamily: "PixelFont",
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: Colors.greenAccent,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              message,
              style: const TextStyle(
                fontFamily: "PixelFont",
                fontSize: 12,
                color: Colors.white70,
              ),
            ),
          ],
        ),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    MainGameMusicService().pauseBgm();
    MarketMusicService().playBgm();
  }

  @override
  void dispose() {
    MarketMusicService().stopBgm();
    MainGameMusicService().playBgm();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          RetroHeader(
            title: "BACKEND MARKET",
            onClose: () => Navigator.pop(context),
          ),
          Expanded(
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 1000),
                child: GridView.builder(
                  padding: const EdgeInsets.all(16),
                  gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 250,
                    mainAxisSpacing: 16,
                    crossAxisSpacing: 16,
                    childAspectRatio: 0.75,
                  ),
                  itemCount: backendMarketItems.length,
                  itemBuilder: (context, index) {
                    final item = backendMarketItems[index];
                    final owned = _isOwned(item);

                    return _MarketItemCard(
                      item: item,
                      owned: owned,
                      onBuy: () => _buyItem(item),
                    );
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _MarketItemCard extends StatelessWidget {
  final BackendItem item;
  final bool owned;
  final VoidCallback onBuy;

  const _MarketItemCard({
    required this.item,
    required this.owned,
    required this.onBuy,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: owned
            ? LinearGradient(
                colors: [Colors.grey.shade800, Colors.grey.shade900],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              )
            : LinearGradient(
                colors: [Colors.deepPurple.shade900, Colors.purple.shade800],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
        borderRadius: BorderRadius.circular(
          2,
        ), // very small radius for pixel effect
        border: Border.all(
          color: owned ? Colors.grey : Colors.greenAccent,
          width: 2,
        ),
      ),
      padding: const EdgeInsets.all(4),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            flex: 4,
            child: Image.asset(
              item.imagePath,
              fit: BoxFit.contain,
              color: owned ? Colors.grey : null,
              colorBlendMode: owned ? BlendMode.saturation : null,
            ),
          ),
          Flexible(
            flex: 1,
            child: Text(
              item.name,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: "PixelFont",
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: owned ? Colors.grey : Colors.white,
              ),
            ),
          ),
          Flexible(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 6),
              child: SingleChildScrollView(
                child: Text(
                  item.description,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontFamily: "PixelFont",
                    fontSize: 12,
                    color: Colors.white70,
                  ),
                ),
              ),
            ),
          ),
          Flexible(
            flex: 1,
            child: Text(
              owned ? "OWNED" : "\$${item.price.toStringAsFixed(0)}",
              style: TextStyle(
                fontFamily: "PixelFont",
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: owned ? Colors.grey : Colors.white,
              ),
            ),
          ),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: owned ? null : onBuy,
              style: ElevatedButton.styleFrom(
                backgroundColor: owned ? Colors.grey : Colors.greenAccent,
                padding: const EdgeInsets.symmetric(vertical: 6),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                    2,
                  ), // rigid pixelated button
                ),
              ),
              child: Text(
                owned ? "SOLD OUT" : "BUY",
                style: const TextStyle(
                  fontFamily: "PixelFont",
                  fontSize: 12,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
