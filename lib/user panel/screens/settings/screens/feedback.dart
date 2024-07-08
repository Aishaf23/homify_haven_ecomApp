import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:homify_haven/widgets/homi_button.dart';
import 'package:homify_haven/widgets/homi_textfield.dart';
import '../../../../model/feedback_model.dart';

class FeedbackScreen extends StatefulWidget {
  const FeedbackScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _FeedbackScreenState createState() => _FeedbackScreenState();
}

class _FeedbackScreenState extends State<FeedbackScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _feedbackController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  bool _isLoading = false;

  Future<void> _submitFeedback() async {
    if (_formKey.currentState?.validate() != true) {
      return;
    }

    setState(() {
      _isLoading = true;
    });

    User? user = _auth.currentUser;

    if (user != null) {
      String userId = user.uid;
      String name = _nameController.text.trim();
      String email = _emailController.text.trim();
      String feedback = _feedbackController.text.trim();

      FeedbackModel feedbackModel = FeedbackModel(
        userId: userId,
        name: name,
        email: email,
        feedback: feedback,
      );

      await _firestore.collection('feedback').add(feedbackModel.toMap());

      // Clear the fields after submission
      _nameController.clear();
      _emailController.clear();
      _feedbackController.clear();

      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Feedback submitted successfully!')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('You need to be logged in to submit feedback')),
      );
    }

    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Feedback'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                HomifyTextField(
                  hintText: 'Name',
                  controller: _nameController,
                  validate: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your name';
                    }
                    return null;
                  },
                ),
                HomifyTextField(
                  hintText: 'Email',
                  controller: _emailController,
                  validate: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email';
                    }
                    if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                      return 'Please enter a valid email address';
                    }
                    return null;
                  },
                ),
                HomifyTextField(
                  hintText: 'Feedback',
                  controller: _feedbackController,
                  maxLines: 5,
                  validate: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your feedback';
                    }
                    return null;
                  },
                ),
                SizedBox(height: height * 0.05),
                _isLoading
                    ? const CircularProgressIndicator()
                    : HomifyButton(
                        isLoading: false,
                        isLoginButton: true,
                        title: 'Submit Feedback',
                        onPress: _submitFeedback,
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
