import 'package:flutter/material.dart';
import '../../public/colors.dart';
import '../../game/services/bank_balance.dart';
import '../widgets/pixel_button.dart';
import '../widgets/notification.dart';

class BankScreen extends StatefulWidget {
  const BankScreen({super.key});

  @override
  State<BankScreen> createState() => _BankScreenState();
}

class _BankScreenState extends State<BankScreen> {
  final TextEditingController _amountController = TextEditingController();

  bool _showSendMoney = false;

  @override
  void initState(){
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      showOldWinNotification(
        context: context,
        title: "Tutorial",
        message: "This is your bank application here you can check your bank account balance...yikes...",
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: OldWinColors.background,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // WINDOWS TITLE BAR
          Container(
            height: 32,
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

                // CLOSE BUTTON
                Positioned(
                  right: 4,
                  top: 4,
                  child: GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Container(
                      width: 24,
                      height: 24,
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        border: Border.all(width: 2, color: Colors.black),
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
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 20),

          // BALANCE
          Center(
            child: Text(
              "Balance: \$${BankBalance().balance.toStringAsFixed(2)}",
              style: const TextStyle(fontFamily: "PixelFont", fontSize: 45),
            ),
          ),

          const SizedBox(height: 20),

          Center(
            child: PixelButton(
              label: _showSendMoney ? "Cancel" : "Send Money To R2R",
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
                  cursorColor: Colors.black,
                  style: const TextStyle(
                    color: Colors.black, // <-- input text color
                    fontFamily: "PixelFont",
                  ),
                  decoration: InputDecoration(
                    labelText: "Amount",
                    labelStyle: const TextStyle(
                      color: Colors.black, // <-- label text
                      fontFamily: "PixelFont",
                    ),
                    enabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.black,
                      ), // unfocused border
                    ),
                    focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.black,
                        width: 2,
                      ), // focused border
                    ),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 10),

            // CONFIRM SEND BUTTON
            Center(
              child: PixelButton(
                label: "Confirm Send",
                onPressed: () {
                  final amount = double.tryParse(_amountController.text) ?? 0.0;

                  if (amount <= 0 || amount > BankBalance().balance) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        backgroundColor: OldWinColors.blue,
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
                    BankBalance().sendMoney(
                      amount,
                      "Sent to 'Rags 2 Riches' Stock Trading Application",
                    );
                  });

                  _amountController.clear();
                  _showSendMoney = false;
                },
              ),
            ),
          ],

          const SizedBox(height: 20),

          // SECTION TITLE
          const Center(
            child: Text(
              "Recent Transactions:",
              style: TextStyle(fontFamily: "PixelFont", fontSize: 16),
            ),
          ),

          const SizedBox(height: 10),

          // TRANSACTION LIST
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
}
