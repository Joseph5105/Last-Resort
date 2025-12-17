import 'package:flutter/material.dart';
import 'package:last_resort/game/services/sfx_service.dart';
import '../../public/colors.dart';
import '../../game/services/bank_balance.dart';
import '../widgets/pixel_button.dart';
import '../widgets/notification.dart';
import 'package:intl/intl.dart';

class FinFangDebt {
  static final FinFangDebt _instance = FinFangDebt._internal();
  factory FinFangDebt() => _instance;

  FinFangDebt._internal() {
    debt = 9644123.82;
    previousDebt = debt;
  }

  late double debt;
  late double previousDebt;

  void pay(double amount) {
    previousDebt = debt;
    debt -= amount;
    if (debt < 0) debt = 0;
  }
}

enum Recipient { none, r2r, finFang }

class BankScreen extends StatefulWidget {
  const BankScreen({super.key});

  @override
  State<BankScreen> createState() => _BankScreenState();
}

bool openedApp = false;

class _BankScreenState extends State<BankScreen> {
  final TextEditingController _amountController = TextEditingController();
  Recipient _currentRecipient = Recipient.none;

  @override
  void initState() {
    super.initState();
    if (!openedApp) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        showOldWinNotification(
          context: context,
          title: "Tutorial",
          message:
              "This is your bank application! View your balance, send money to R2R or FinFang, and track debts.",
        );
      });
      openedApp = true;
    }
  }

  void _sendMoney(double amount) {
    if (amount <= 0 || amount > BankBalance().balance) {
      _showInvalidAmount();
      return;
    }

    setState(() {
      if (_currentRecipient == Recipient.r2r) {
        BankBalance().sendMoney(
          amount,
          "Sent to 'Rags 2 Riches' Stock Trading Application",
          toR2R: true,
        );
      } else if (_currentRecipient == Recipient.finFang) {
        BankBalance().sendMoney(amount, "Sent to FinFang", toR2R: false);
        FinFangDebt().pay(amount);
      }

      _amountController.clear();
      _currentRecipient = Recipient.none;
    });
  }

  void _showInvalidAmount() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: OldWinColors.blue,
        content: const Text(
          "Invalid Amount",
          style: TextStyle(fontFamily: "PixelFont", color: Colors.white),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: OldWinColors.background,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Window Title Bar
          Container(
            height: 34,
            color: OldWinColors.blue,
            child: Stack(
              children: [
                const Center(
                  child: Text(
                    "Secure Shrine Bank",
                    style: TextStyle(
                      fontFamily: "PixelFont",
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                ),
                Positioned(right: 4, top: 4, child: _buildCloseButton()),
              ],
            ),
          ),
          const SizedBox(height: 20),

          // Animated Balance
          Center(
            child: TweenAnimationBuilder<double>(
              tween: Tween<double>(
                begin: BankBalance().previousBalance,
                end: BankBalance().balance,
              ),
              duration: const Duration(milliseconds: 500),
              builder: (context, value, child) {
                return Text(
                  "Balance: \$${value.toStringAsFixed(2)}",
                  style: const TextStyle(fontFamily: "PixelFont", fontSize: 45),
                );
              },
            ),
          ),
          const SizedBox(height: 20),

          // Send Money Buttons
          Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                PixelButton(
                  label: _currentRecipient == Recipient.r2r
                      ? "Cancel"
                      : "Send Money To R2R",
                  onPressed: () {
                    setState(() {
                      _currentRecipient = _currentRecipient == Recipient.r2r
                          ? Recipient.none
                          : Recipient.r2r;
                    });
                  },
                ),
                const SizedBox(width: 10),
                PixelButton(
                  label: _currentRecipient == Recipient.finFang
                      ? "Cancel"
                      : "Send Money To FinFang",
                  onPressed: () {
                    setState(() {
                      _currentRecipient = _currentRecipient == Recipient.finFang
                          ? Recipient.none
                          : Recipient.finFang;
                    });
                  },
                ),
              ],
            ),
          ),

          if (_currentRecipient != Recipient.none) ...[
            const SizedBox(height: 20),
            Center(
              child: SizedBox(
                width: 200,
                child: TextField(
                  controller: _amountController,
                  cursorColor: Colors.black,
                  style: const TextStyle(
                    color: Colors.black,
                    fontFamily: "PixelFont",
                  ),
                  decoration: const InputDecoration(
                    labelText: "Amount",
                    labelStyle: TextStyle(
                      color: Colors.black,
                      fontFamily: "PixelFont",
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black, width: 2),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            Center(
              child: PixelButton(
                label: "Confirm Send",
                onPressed: () {
                  SfxService().paidDebt();
                  final amount = double.tryParse(_amountController.text) ?? 0.0;
                  _sendMoney(amount);
                },
              ),
            ),
          ],

          const SizedBox(height: 20),

          // Animated FinFang Debt
          Center(
            child: TweenAnimationBuilder<double>(
              tween: Tween<double>(
                begin: FinFangDebt().previousDebt,
                end: FinFangDebt().debt,
              ),
              duration: const Duration(milliseconds: 500),
              builder: (context, value, child) {
                return Text(
                  "Debt to FinFang: \$${NumberFormat('#,###.00').format(value)}",
                  style: const TextStyle(
                    fontFamily: "PixelFont",
                    fontSize: 34,
                    color: Colors.red,
                  ),
                  textAlign: TextAlign.center,
                );
              },
            ),
          ),

          const SizedBox(height: 20),

          // Transactions
          const Center(
            child: Text(
              "Recent Transactions:",
              style: TextStyle(fontFamily: "PixelFont", fontSize: 16),
            ),
          ),
          const SizedBox(height: 10),
          Expanded(
            child: Center(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: BankBalance().transactions.length,
                itemBuilder: (_, index) {
                  final t = BankBalance().transactions[index];
                  return Center(
                    child: ListTile(
                      title: Text(
                        "${t["type"] == "sent" ? 'Sent' : 'Deposit'} "
                        "\$${t["amount"].toStringAsFixed(2)}",
                        textAlign: TextAlign.center,
                        style: const TextStyle(fontFamily: "PixelFont"),
                      ),
                      subtitle: Text(
                        t["note"],
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontFamily: "PixelFont",
                          fontSize: 12,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCloseButton() {
    return GestureDetector(
      onTap: () => Navigator.pop(context),
      child: Container(
        width: 24,
        height: 24,
        decoration: BoxDecoration(
          color: Colors.grey[300],
          border: Border.all(color: Colors.black, width: 2),
        ),
        child: const Center(
          child: Text(
            "X",
            style: TextStyle(
              fontFamily: "PixelFont",
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
