import 'package:flutter/material.dart';
import 'package:last_resort/public/colors.dart';
import '../../public/emails.dart';
import '../widgets/notification.dart';

/// Global variable to track opened emails across screens
Set<int> openedEmails = {};

class EmailScreen extends StatefulWidget {
  const EmailScreen({super.key});

  @override
  State<EmailScreen> createState() => _EmailScreen();
}

bool openedApp = false;

class _EmailScreen extends State<EmailScreen> {
  int? openedEmailIndex;

  @override
  void initState() {
    super.initState();

    if (!openedApp) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        showOldWinNotification(
          context: context,
          title: "Tutorial",
          message:
              "This is your email application! You can receive emails to learn about the outside world.",
        );
      });
      openedApp = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            color: const Color(0xFFC0C0C0),
            border: Border.all(color: Colors.black, width: 3),
          ),
          child: Column(
            children: [
              _buildWindowTitleBar(),
              Expanded(
                child: openedEmailIndex == null
                    ? _buildEmailList()
                    : _buildOpenedEmail(openedEmailIndex!),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildWindowTitleBar() {
    return Container(
      height: 34,
      color: OldWinColors.blue,
      child: Stack(
        children: [
          const Center(
            child: Text(
              "BlueHeart Email 64",
              style: TextStyle(
                fontFamily: 'PixelFont',
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Positioned(right: 4, top: 4, child: _buildCloseButton()),
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
              fontFamily: 'PixelFont',
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildEmailList() {
    return Center(
      child: Container(
        width: 400,
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: ListView.builder(
          itemCount: emails.length,
          itemBuilder: (context, index) {
            final email = emails[index];
            final bool isOpened = openedEmails.contains(index);

            return GestureDetector(
              onTap: () {
                setState(() {
                  openedEmailIndex = index;
                  openedEmails.add(index); // Persist globally
                });
              },
              child: Container(
                margin: const EdgeInsets.only(bottom: 10),
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: isOpened ? Colors.white : Colors.yellow[300],
                  border: Border.all(color: Colors.black, width: 2),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.email, color: Colors.black),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        email["subject"]!,
                        style: const TextStyle(
                          fontFamily: "PixelFont",
                          fontSize: 14,
                        ),
                      ),
                    ),
                    const Icon(Icons.arrow_right),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildOpenedEmail(int index) {
    final email = emails[index];
    openedEmails.add(index); // mark opened globally

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: GestureDetector(
            onTap: () => setState(() => openedEmailIndex = null),
            child: Container(
              margin: const EdgeInsets.all(10),
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              decoration: BoxDecoration(
                color: Colors.grey[300],
                border: Border.all(color: Colors.black),
              ),
              child: const Text(
                "< Back",
                style: TextStyle(fontFamily: "PixelFont", fontSize: 14),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Text(
            email["subject"]!,
            style: const TextStyle(
              fontFamily: "PixelFont",
              fontSize: 34,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
          child: Text(
            "From: ${email["sender"]}",
            style: const TextStyle(fontFamily: "PixelFont", fontSize: 14),
            textAlign: TextAlign.center,
          ),
        ),
        const Divider(color: Colors.black, thickness: 2),
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(10),
            color: Colors.white,
            child: SingleChildScrollView(
              child: Text(
                email["body"]!,
                style: const TextStyle(fontFamily: "PixelFont", fontSize: 16),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
