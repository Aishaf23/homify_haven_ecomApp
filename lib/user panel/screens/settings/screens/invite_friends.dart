import 'package:flutter/material.dart';

class InviteFriendsScreen extends StatelessWidget {
  const InviteFriendsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Invite Friends'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Invite Friends',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: height * 0.02),
              const Text(
                'Share the app with your friends and enjoy exclusive benefits together! Here are some ways you can invite your friends:',
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              SizedBox(height: height * 0.02),
              const Text(
                '1. Share via Social Media',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: height * 0.01),
              const Text(
                'Post about our app on your social media accounts and let your friends know how much you love it. Use the share button below to get started.',
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              SizedBox(height: height * 0.02),
              const Text(
                '2. Send an Invitation Link',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: height * 0.01),
              const Text(
                'Copy the invitation link below and send it to your friends via email, text message, or any other platform.',
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              SizedBox(height: height * 0.02),
              Center(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                  ),
                  onPressed: () {
                    // Add share functionality here
                  },
                  child: const Text(
                    'Share Invite Link',
                    style: TextStyle(
                      color: Colors.tealAccent,
                    ),
                  ),
                ),
              ),
              SizedBox(height: height * 0.02),
              const Text(
                '3. Invite via QR Code',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: height * 0.01),
              const Text(
                'Show your friends the QR code below. They can scan it to download the app directly.',
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              SizedBox(height: height * 0.02),
              Center(
                child: Image.asset(
                  'images/homifyhaven_qr.png', // Replace with your QR code asset
                  height: 180,
                  width: 180,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
