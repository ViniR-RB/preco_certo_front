import 'package:flutter/material.dart';

enum SnackType {
  success,
  error,
  info,
}


class AppSnackBar {
  static void show(
    BuildContext context, {
    required String message,
    SnackType type = SnackType.info,
  }) {
    IconData icon;
    Color iconColor;

    switch (type) {
      case SnackType.success:
        icon = Icons.check_circle;
        iconColor = Colors.green;
        break;

      case SnackType.error:
        icon = Icons.cancel;
        iconColor = Colors.red;
        break;

      case SnackType.info:
        icon = Icons.info;
        iconColor = Colors.black;
        break;
    }

    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.white,
          elevation: 8,
          margin: const EdgeInsets.all(16),
          duration: const Duration(seconds: 2),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          content: Row(
            children: [
              Icon(
                icon,
                color: iconColor,
                size: 24,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  message,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ),
      );
  }
}