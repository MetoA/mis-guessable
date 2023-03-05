import 'package:flutter/material.dart';
import 'package:guessable/main.dart';

class NotificationsService {
  static void success(String text, {int durationSeconds = 4}) {
    MyApp.scaffoldMessengerKey.currentState?.showSnackBar(
      SnackBar(
        duration: Duration(seconds: durationSeconds),
        content: Text(
          text,
          style: const TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.green,
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.all(10),
      ),
    );
  }

  static void error(String message, {int durationSeconds = 4}) {
    MyApp.scaffoldMessengerKey.currentState?.showSnackBar(
      SnackBar(
        duration: Duration(seconds: durationSeconds),
        content: Text(
          message,
          style: const TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.red,
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.all(10),
      ),
    );
  }
}
