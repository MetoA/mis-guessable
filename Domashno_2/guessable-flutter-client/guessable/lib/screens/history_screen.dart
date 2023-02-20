import 'package:flutter/material.dart';

import '../widgets/bottom_nav.dart';

class HistoryScreen extends StatefulWidget {
  static const String route = '/history';

  const HistoryScreen({super.key});

  @override
  State<StatefulWidget> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('History'),
      ),
      body: Container(
        padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20, top: 50),
        child: Center(
            child: Column(
              children: [],
            )),
      ),
      bottomNavigationBar: const BottomNav(
        currentRoute: HistoryScreen.route,
      ),
    );
  }

}