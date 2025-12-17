import 'dart:async';
import 'package:flutter/material.dart';
import '../../../game/services/stock_market_service.dart';
import '../../../game/services/stock_balance.dart';
import '../../game/services/background_music_service.dart';
import '../../game/services/main_game_music_service.dart';

// Imports widgets
import '../widgets/retro_header.dart';
import '../widgets/balance_display.dart';
import '../widgets/top_buttons.dart';
import '../widgets/withdraw_box.dart';
import '../widgets/stock_grid.dart';
import '../widgets/stock_transaction_widget.dart';
import '../widgets/notification.dart';

// Transaction model
class Transaction {
  final String type;
  final String? stockName;
  final double amount;
  final DateTime timestamp;

  Transaction({
    required this.type,
    this.stockName,
    required this.amount,
    DateTime? timestamp,
  }) : timestamp = timestamp ?? DateTime.now();
}

class TradingScreen extends StatefulWidget {
  const TradingScreen({super.key});

  @override
  State<TradingScreen> createState() => _TradingScreenState();
}

bool openedApp = false;

class _TradingScreenState extends State<TradingScreen> {
  final market = StockMarketService();
  late StreamSubscription sub;

  bool _showWithdraw = false;
  final TextEditingController _amountController = TextEditingController();

  @override
  void initState() {
    super.initState();

    MainGameMusicService().pauseBgm();
    BackgroundMusicService().playBgm();

    sub = market.priceUpdates.listen((_) {
      if (mounted) setState(() {});
    });

    if (!openedApp) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        showDialog(
          context: context,
          builder: (_) => OldWinNotificationDialog(
            title: "Tutorial",
            message:
                "Welcome to the Trading Console! Buy low, sell high, and make that MONEY.",
          ),
        );
      });
      openedApp = true;
    }
  }

  @override
  void dispose() {
    BackgroundMusicService().stopBgm();
    MainGameMusicService().playBgm();
    sub.cancel();
    _amountController.dispose();
    super.dispose();
  }

  void _handleWithdraw() {
    final amount = double.tryParse(_amountController.text) ?? 0;
    if (!StockBalance().withdrawToBank(amount)) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.red[900],
          content: const Text(
            "Invalid amount",
            style: TextStyle(fontFamily: "PixelFont", color: Colors.white),
          ),
        ),
      );
      return;
    }

    setState(() {
      _amountController.clear();
      _showWithdraw = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final stocks = market.stocks;

    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          RetroHeader(
            title: "RAGS 2 RICHES — TRADING CONSOLE",
            onClose: () => Navigator.pop(context),
          ),
          const SizedBox(height: 12),
          BalanceDisplay(),
          const SizedBox(height: 12),
          TopButtons(
            showWithdraw: _showWithdraw,
            toggleWithdraw: () =>
                setState(() => _showWithdraw = !_showWithdraw),
          ),
          if (_showWithdraw)
            WithdrawBox(
              controller: _amountController,
              onConfirm: _handleWithdraw,
            ),
          const SizedBox(height: 12),
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: StockGrid(
                      stocks: stocks,
                      onTick: () => market.updateAll(),
                      onBuy: (name) {
                        setState(() {
                          market.buy(
                            name,
                            1,
                          ); // StockBalance updates automatically
                        });
                      },
                      onSell: (name) {
                        setState(() {
                          market.sell(
                            name,
                            1,
                          ); // StockBalance updates automatically
                        });
                      },
                    ),
                  ),
                ),
                SizedBox(
                  width: 200,
                  child: TransactionLog(
                    transactions: StockBalance().transactions,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
