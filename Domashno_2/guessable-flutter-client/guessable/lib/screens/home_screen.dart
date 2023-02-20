import 'package:flutter/material.dart';
import 'package:guessable/screens/create_screen.dart';
import 'package:guessable/screens/guess_screen.dart';
import 'package:guessable/widgets/bottom_nav.dart';

import 'history_screen.dart';

class HomeScreen extends StatelessWidget {
  static const String route = '/home';

  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: Container(
        padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20, top: 50),
        child: Center(
            child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(minimumSize: const Size.fromHeight(50)),
                onPressed: () {
                  Navigator.of(context).pushNamedAndRemoveUntil(HistoryScreen.route, (route) => false);
                },
                child: Stack(
                  children: const [
                    Align(alignment: Alignment.centerLeft, child: Text('VIEW PAST GUESSES')),
                    Align(alignment: Alignment.centerRight, child: Icon(Icons.list)),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(minimumSize: const Size.fromHeight(50)),
                onPressed: () {
                  Navigator.of(context).pushNamedAndRemoveUntil(GuessScreen.route, (route) => false);
                },
                child: Stack(
                  children: const [
                    Align(alignment: Alignment.centerLeft, child: Text('GUESS LOCATION')),
                    Align(alignment: Alignment.centerRight, child: Icon(Icons.pin_drop)),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(minimumSize: const Size.fromHeight(50)),
                onPressed: () {
                  Navigator.of(context).pushNamedAndRemoveUntil(CreateScreen.route, (route) => false);
                },
                child: Stack(
                  children: const [
                    Align(alignment: Alignment.centerLeft, child: Text('CREATE GUESSABLE LOCATION')),
                    Align(alignment: Alignment.centerRight, child: Icon(Icons.add)),
                  ],
                ),
              ),
            ),
          ],
        )),
      ),
      bottomNavigationBar: const BottomNav(
        currentRoute: route,
      ),
    );
  }
}
