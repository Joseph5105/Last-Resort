import 'package:flutter/material.dart';
import '../../../game/models/stock.dart';
import '../../../game/services/stock_price_generator.dart';
import '../../public/colors.dart';
import '../../game/services/stock_balance.dart';
import '../widgets/pixel_button.dart';

class TradingScreen extends StatefulWidget {
  const TradingScreen({super.key});

  @override
  State<TradingScreen> createState() => _TradingScreenState();
}

class _TradingScreenState extends State<TradingScreen> {
  final generator = StockPriceGenerator();
  late Stock risky;
  late Stock safe;
  late Stock moderate;
  late Stock bruh;

  @override
  void initState() {
    super.initState();
    risky = Stock(name: 'Risky Co.', price: 100);
    safe = Stock(name: 'Safe Co.', price: 100);
    moderate = Stock(name: 'Moderate Co.', price: 100);
    bruh = Stock(name: 'bruh Co.', price: 100);
  }

  void updatePrice() {
    setState(() {
      risky = generator.generateNext(risky);
      safe = generator.generateNext(safe);
      moderate = generator.generateNext(moderate);
      bruh = generator.generateNext(bruh);
    });
  }

  bool _showSendMoney = false;
  final TextEditingController _amountController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        width: size.width,
        height: size.height,
        decoration: BoxDecoration(color: Colors.grey[900]),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Custom Title Bar
            Container(
              height: 32,
              color: Colors.red[900],
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Stack(
                children: [
                  Center(
                    child: Text(
                      "Rags 2 Riches - Trading Console",
                      style: const TextStyle(
                        fontFamily: "PixelFont",
                        fontSize: 16,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Positioned(
                    right: 0,
                    top: 4,
                    child: GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Container(
                        width: 24,
                        height: 24,
                        decoration: BoxDecoration(
                          color: Colors.grey[800],
                          border: Border.all(color: Colors.black, width: 1),
                        ),
                        child: const Center(
                          child: Text(
                            "X",
                            style: TextStyle(
                              fontFamily: "PixelFont",
                              fontSize: 14,
                              color: Colors.white,
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

            const SizedBox(height: 30),

            // Brokerage Balance
            Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    "Brokerage Account Balance",
                    style: TextStyle(
                      fontFamily: "PixelFont",
                      fontSize: 16,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "\$${StockBalance().balance.toStringAsFixed(2)}",
                    style: const TextStyle(
                      fontFamily: "PixelFont",
                      fontSize: 24,
                      color: Colors.greenAccent,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),

            //Withdraw Button
            Center(
              child: PixelButton(
                label: _showSendMoney ? "Cancel" : "Withdraw",
                onPressed: () {
                  setState(() => _showSendMoney = !_showSendMoney);
                },
              ),
            ),
            if (_showSendMoney) ...[
              const SizedBox(height: 20),

              // INPUT FIELD
              Center(
                child: SizedBox(
                  width: 200,
                  child: TextField(
                    controller: _amountController,
                    cursorColor: Colors.white,
                    style: const TextStyle(
                      color: Colors.white, // <-- input text color
                      fontFamily: "PixelFont",
                    ),
                    decoration: InputDecoration(
                      labelText: "Amount",
                      labelStyle: const TextStyle(
                        color: Colors.white, // <-- label text
                        fontFamily: "PixelFont",
                      ),
                      enabledBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white), // unfocused border
                      ),
                      focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white, width: 2), // focused border
                      ),
                    ),
                  ),
                ),
              ),


              const SizedBox(height: 10),

              // CONFIRM SEND BUTTON
              Center(
                child: PixelButton(
                  label: "Confirm",
                  onPressed: () {
                    final amount =
                        double.tryParse(_amountController.text) ?? 0.0;

                    if (amount <= 0 || amount > StockBalance().balance) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          backgroundColor: Colors.red[900],
                          content: const Text(
                            "Invalid Amount",
                            style: TextStyle(
                              fontFamily: "PixelFont",
                              color: Colors.white,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      );
                      return;
                    }

                    setState(() {
                      StockBalance().withdraw(amount);
                    });

                    _amountController.clear();
                    _showSendMoney = false;
                  },
                ),
              ),
            ],

            const Spacer(),

            // Stock Row at the bottom
            Wrap(
              spacing: 12,
              runSpacing: 12,
              children: [
                risky.buildWidget(updatePrice),
                safe.buildWidget(updatePrice),
                moderate.buildWidget(updatePrice),
                bruh.buildWidget(updatePrice),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
