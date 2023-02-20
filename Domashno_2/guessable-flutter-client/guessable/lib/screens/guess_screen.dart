import 'package:flutter/material.dart';

import '../widgets/bottom_nav.dart';

class GuessScreen extends StatefulWidget {
  static const String route = '/guess';

  const GuessScreen({super.key});

  @override
  State<StatefulWidget> createState() => _GuessScreenState();
}

class _GuessScreenState extends State<GuessScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Guess'),
      ),
      body: Container(
        padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20, top: 50),
        child: Center(
            child: Column(
              children: [],
            )),
      ),
      bottomNavigationBar: const BottomNav(
        currentRoute: GuessScreen.route,
      ),
    );
  }

}