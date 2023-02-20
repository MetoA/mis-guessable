import 'package:flutter/material.dart';
import 'package:guessable/screens/create_screen.dart';
import 'package:guessable/screens/guess_screen.dart';
import 'package:guessable/screens/history_screen.dart';
import 'package:guessable/screens/home_screen.dart';
import 'package:guessable/screens/login_screen.dart';
import 'package:guessable/screens/signup_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Guessable',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.deepPurple).copyWith(secondary: Colors.deepPurpleAccent)
      ),
      initialRoute: HomeScreen.route,
      routes: {
        LoginScreen.route: (context) => const LoginScreen(),
        SignupScreen.route: (context) => const SignupScreen(),
        HomeScreen.route: (context) => const HomeScreen(),
        HistoryScreen.route: (context) => const HistoryScreen(),
        CreateScreen.route: (context) => const CreateScreen(),
        GuessScreen.route: (context) => const GuessScreen()
      },
    );
  }
}
