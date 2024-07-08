import 'package:flutter/material.dart';

class ContactUsScreen extends StatelessWidget {
  const ContactUsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Contact Us'),
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
                'Contact Us',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: height * 0.02),
              const Text(
                'We are here to help you. If you have any questions, concerns, or feedback, please don\'t hesitate to reach out to us using the following contact information:',
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              SizedBox(height: height * 0.02),
              const Text(
                'Email:',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Text(
                'aishaf214@gmail.com',
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              SizedBox(height: height * 0.02),
              const Text(
                'Phone:',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Text(
                '+92 313 1234567',
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              SizedBox(height: height * 0.02),
              const Text(
                'Address:',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Text(
                '123 Dera Adda Street\nMultan, Punjab, 60000\nPakistan',
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              SizedBox(height: height * 0.02),
              const Text(
                'We look forward to hearing from you!',
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
