import 'package:flutter/material.dart';

class DialogBox extends StatelessWidget {
  const DialogBox({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      actions: [
        ElevatedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('CLOSE'),
        ),
      ],
    );
  }
}
