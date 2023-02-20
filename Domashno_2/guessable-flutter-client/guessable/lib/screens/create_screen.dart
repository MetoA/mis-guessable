import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

import '../widgets/bottom_nav.dart';

class CreateScreen extends StatefulWidget {
  static const String route = '/create';

  const CreateScreen({super.key});

  @override
  State<StatefulWidget> createState() => _CreateScreenState();
}

class _CreateScreenState extends State<CreateScreen> {

  Position? userPosition;
  String? userPositionError;

  @override
  void initState() {
    print(_determinePosition());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create'),
      ),
      body: Container(
        padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20, top: 50),
        child: Center(
            child: Column(
              children: [],
            )),
      ),
      bottomNavigationBar: const BottomNav(
        currentRoute: CreateScreen.route,
      ),
    );
  }

  _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      userPositionError = 'Location services are disabled.';
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        userPositionError = 'Location permissions are denied';
      }
    }

    if (permission == LocationPermission.deniedForever) {
      userPositionError = 'Location permissions are permanently denied, we cannot request permissions.';
    }

    userPosition = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    print('USER POSITION ${userPosition?.toString() ?? ''}');
    print('USER POSITION ERROR ${userPositionError ?? ''}');
  }

}