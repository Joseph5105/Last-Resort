import 'package:flutter/material.dart';
import 'package:last_resort/public/colors.dart';
import '../../public/emails.dart';
import '../widgets/notification.dart';

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
    if(openedApp == false){
      super.initState();
      WidgetsBinding.instance.addPostFrameCallback((_) {
        showOldWinNotification(
          context: context,
          title: "Tutorial",
          message:
              "This is your email application here you can recieve emails to learn about the outside world!",
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
            color: const Color(0xFFC0C0C0), // classic win95 grey
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

  // Title Bar
  Widget _buildWindowTitleBar() {
    return Container(
      height: 32,
      color: OldWinColors.blue, // Win95 blue
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

  // EMAIL LIST VIEW
  Widget _buildEmailList() {
    return Container(
      padding: const EdgeInsets.all(10),
      child: ListView.builder(
        itemCount: emails.length,
        itemBuilder: (context, index) {
          final email = emails[index];
          return GestureDetector(
            onTap: () {
              setState(() => openedEmailIndex = index);
            },
            child: Container(
              margin: const EdgeInsets.only(bottom: 10),
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.white,
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
    );
  }

  // Email Viewer
  Widget _buildOpenedEmail(int index) {
    final email = emails[index];

    return Column(
      crossAxisAlignment:
          CrossAxisAlignment.center, // center main content horizontally
      children: [
        Align(
          alignment: Alignment.centerLeft, // aligns only the back button
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

        // Subject
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Text(
            email["subject"]!,
            style: const TextStyle(
              fontFamily: "PixelFont",
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center, // center subject text
          ),
        ),

        // Sender
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
          child: Text(
            "From: ${email["sender"]}",
            style: const TextStyle(fontFamily: "PixelFont", fontSize: 14),
            textAlign: TextAlign.center, // center sender text
          ),
        ),

        const Divider(color: Colors.black, thickness: 2),

        // Email Body
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(10),
            color: Colors.white,
            child: SingleChildScrollView(
              child: Text(
                email["body"]!,
                style: const TextStyle(fontFamily: "PixelFont", fontSize: 14),
                textAlign: TextAlign.center, // center email text
              ),
            ),
          ),
        ),
      ],
    );
  }
}
