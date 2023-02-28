import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:guessable/blocs/create_guess_bloc/create_guess_bloc.dart';
import 'package:guessable/blocs/create_guess_bloc/create_guess_state.dart';

import '../blocs/create_guess_bloc/create_guess_event.dart';
import '../widgets/bottom_nav.dart';
import 'camera_screen.dart';

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
      body: _body(context),
      bottomNavigationBar: const BottomNav(
        currentRoute: CreateScreen.route,
      ),
    );
  }

  Widget _body(BuildContext context) {
    BlocProvider.of<CreateGuessBloc>(context).add(CreateGuessInitializedEvent());
    print('Initial state called');
    return BlocBuilder<CreateGuessBloc, CreateGuessState>(builder: (context, state) {
      // TODO current issue where after taking picture and getting redirected here, the image is null until maybe refresh or navigate to other place
      final state = context.watch<CreateGuessBloc>().state;
      return Container(
        padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20, top: 50),
        child: Center(
            child: Column(
          children: [
            Text('Location is: $userPosition'),
            ElevatedButton(
              onPressed: () async {
                availableCameras().then((value) =>
                    Navigator.push(context, MaterialPageRoute(builder: (_) => CameraScreen(cameras: value))));
              },
              child: Text('Take a picture'),
            ),
            Text(state is CreateGuessPopulatedState ? 'HAS IMAGE ${state.locationImage?.name}' : 'NO IMAGE')
          ],
        )),
      );
    });
  }

  _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      setState(() {
        userPositionError = 'Location services are disabled.';
      });
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        setState(() {
          userPositionError = 'Location permissions are denied';
        });
      }
    }

    if (permission == LocationPermission.deniedForever) {
      setState(() {
        userPositionError = 'Location permissions are permanently denied, we cannot request permissions.';
      });
    }

    var position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    setState(() {
      userPosition = position;
    });
    print('USER POSITION ${userPosition?.toString() ?? ''}');
    print('USER POSITION ERROR ${userPositionError ?? ''}');
  }
}
