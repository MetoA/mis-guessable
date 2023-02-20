import 'package:flutter/material.dart';
import 'package:guessable/screens/home_screen.dart';
import 'package:collection/collection.dart';

import '../screens/history_screen.dart';

// TODO change this so that the navigation happens on the same screen?
class BottomNav extends StatefulWidget {
  static const String route = '/login';
  final String currentRoute;

  const BottomNav({super.key, required this.currentRoute});

  @override
  State<StatefulWidget> createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  int _currentIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      String clickedRoute = _navItems[index].route;

      if (clickedRoute != widget.currentRoute) {
        Navigator.of(context).pushNamedAndRemoveUntil(_navItems[index].route, (route) => false);
        _currentIndex = index;
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _currentIndex = _navItems.firstWhereOrNull((element) => element.route == widget.currentRoute)?.index ?? 0;
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      onTap: _onItemTapped,
      items: _navItems
          .map(
              (item) => BottomNavigationBarItem(icon: item.icon, label: item.label, backgroundColor: Colors.deepPurple))
          .toList(),
      currentIndex: _currentIndex,
      showUnselectedLabels: true,
    );
  }
}

class _NavItem {
  final String route;
  final int index;
  final Icon icon;
  final String label;

  const _NavItem(this.route, this.index, this.icon, this.label);
}

final _navItems = <_NavItem>[
  const _NavItem(HomeScreen.route, 0, Icon(Icons.home), 'Home'),
  const _NavItem(HistoryScreen.route, 1, Icon(Icons.list), 'History'), // TODO
  const _NavItem('/create', 2, Icon(Icons.add), 'Create'), // TODO
  const _NavItem('/guess', 3, Icon(Icons.pin_drop), 'Guess'), // TODO
];
