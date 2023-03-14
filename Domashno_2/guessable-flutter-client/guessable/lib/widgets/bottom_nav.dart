import 'package:flutter/material.dart';
import 'package:guessable/screens/create_screen.dart';
import 'package:guessable/screens/guess_screen.dart';
import 'package:guessable/screens/home_screen.dart';
import 'package:collection/collection.dart';

import '../screens/history_screen.dart';

/// A bottom navigation bar for multiple screens of the application
class BottomNav extends StatefulWidget {
  final String currentRoute;

  const BottomNav({super.key, required this.currentRoute});

  @override
  State<StatefulWidget> createState() => _BottomNavState();
}

/// The state and logic of the bottom navigation bar for navigating across screens
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
    _currentIndex = _navItems
        .firstWhereOrNull((element) => element.route == widget.currentRoute)
        ?.index ?? 0;
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

/// Represents information needed for the bottom navigation bar
///
/// * [route] decides what page the user will navigate to when clicking the item
/// * [index] is used for ordering of the [_NavItem]
/// * [icon] is displayed on the button and for contextual purposes
/// * [label] is presented under the icon in cases where the icon is not self-explanatory
class _NavItem {
  final String route;
  final int index;
  final Icon icon;
  final String label;

  const _NavItem(this.route, this.index, this.icon, this.label);
}

/// A list of [_NavItem] that is used for the bottom navigation bar to navigate through all of the screens in the application
final _navItems = <_NavItem>[
  const _NavItem(HomeScreen.route, 0, Icon(Icons.home), 'Home'),
  const _NavItem(HistoryScreen.route, 1, Icon(Icons.list), 'History'),
  const _NavItem(CreateScreen.route, 2, Icon(Icons.add), 'Create'),
  const _NavItem(GuessScreen.route, 3, Icon(Icons.pin_drop), 'Guess'),
];
