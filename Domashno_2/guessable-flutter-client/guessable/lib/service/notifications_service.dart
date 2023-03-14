import 'package:flutter/material.dart';
import 'package:guessable/main.dart';

/// A service class that manages snack-bars, popups, etc
class NotificationsService {

  /// A method that shows a snack-bar with green background, indicating a successful action
  ///
  /// The [text] that is passed is displayed when the snack-bar pops up
  /// The [durationSeconds] manages the duration of the snack-bar in seconds, defaulting to 4 seconds
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

  /// A method that shows a snack-bar with red background, indicating an error has occurred
  ///
  /// The [text] that is passed is displayed when the snack-bar pops up
  /// The [durationSeconds] manages the duration of the snack-bar in seconds, defaulting to 4 seconds
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
