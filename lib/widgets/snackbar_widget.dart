import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';

class SnackbarService {
  static void showSuccess(BuildContext context, String message,
      {FlushbarPosition position = FlushbarPosition.BOTTOM}) {
    _showSnackbar(
      context,
      message,
      backgroundColor: Colors.green.shade600,
      icon: Icons.check_circle,
      position: position,
    );
  }

  static void showError(BuildContext context, String message,
      {FlushbarPosition position = FlushbarPosition.BOTTOM}) {
    _showSnackbar(
      context,
      message,
      backgroundColor: Colors.red.shade600,
      icon: Icons.error,
      position: position,
    );
  }

  static void showInfo(BuildContext context, String message,
      {FlushbarPosition position = FlushbarPosition.BOTTOM}) {
    _showSnackbar(
      context,
      message,
      backgroundColor: Colors.blue,
      icon: Icons.shopping_bag_outlined,
      position: position,
    );
  }

  static void showAdded(BuildContext context, String message,
      {FlushbarPosition position = FlushbarPosition.TOP}) {
    _showSnackbar(
      context,
      message,
      backgroundColor: Colors.amber.shade700,
      icon: Icons.add,
      position: position,
    );
  }

  static void _showSnackbar(
    BuildContext context,
    String message, {
    required Color backgroundColor,
    IconData? icon,
    FlushbarPosition position = FlushbarPosition.BOTTOM,
  }) {
    Flushbar(
      messageText: Row(
        children: [
          if (icon != null) Icon(icon, color: Colors.white),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              message,
              style: const TextStyle(color: Colors.white, fontSize: 16),
            ),
          ),
        ],
      ),
      backgroundColor: backgroundColor,
      flushbarPosition: position,
      margin: const EdgeInsets.all(12),
      borderRadius: BorderRadius.circular(12),
      duration: const Duration(seconds: 3),
    ).show(context);
  }
}
