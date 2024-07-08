import 'package:flutter/material.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    // double width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Privacy Policy'),
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
                'Privacy Policy',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: height * 0.02),
              const Text(
                'Introduction',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: height * 0.01),
              const Text(
                'Welcome to Homify Haven. We are committed to protecting your privacy. This Privacy Policy explains how we collect, use, and safeguard your information when you use our application. By using our app, you agree to the terms of this Privacy Policy.',
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              SizedBox(height: height * 0.02),
              const Text(
                'Information We Collect',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: height * 0.01),
              const Text(
                'We may collect the following types of information:',
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              SizedBox(height: height * 0.01),
              const Text(
                '- Personal Information: Name, email address, profile picture, phone number, and any other information you provide.',
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              const Text(
                '- Usage Data: Information on how you use the app, such as features used, time spent, and other interaction data.',
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              SizedBox(height: height * 0.02),
              const Text(
                'How We Use Information',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: height * 0.01),
              const Text(
                'We use the information we collect to:',
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              SizedBox(height: height * 0.01),
              const Text(
                '- Provide and improve our services.',
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              const Text(
                '- Respond to user inquiries and support requests.',
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              const Text(
                '- Analyze usage patterns to enhance user experience.',
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              const Text(
                '- Comply with legal obligations and protect against legal liability.',
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              SizedBox(height: height * 0.02),
              const Text(
                'Data Security',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: height * 0.01),
              const Text(
                'We implement reasonable security measures to protect your information from unauthorized access, alteration, disclosure, or destruction.',
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              SizedBox(height: height * 0.02),
              const Text(
                'Changes to This Privacy Policy',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: height * 0.01),
              const Text(
                'We may update this Privacy Policy from time to time. We will notify you of any changes by posting the new Privacy Policy on this page.',
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              SizedBox(height: height * 0.02),
              const Text(
                'Contact Us',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: height * 0.01),
              RichText(
                text: const TextSpan(
                  text:
                      'If you have any questions about this Privacy Policy, please contact us at ',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                  ),
                  children: [
                    TextSpan(
                      text: '+92 123 4567890',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                      ),
                    ),
                    TextSpan(
                      text: '.',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
