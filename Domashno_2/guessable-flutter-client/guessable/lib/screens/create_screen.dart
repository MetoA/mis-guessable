import 'dart:async';
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:guessable/api/location_api.dart';
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
  final Completer<GoogleMapController> _mapController = Completer<GoogleMapController>();

  bool locationLoading = false;

  @override
  void initState() {
    _determinePosition();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CreateGuessBloc, CreateGuessState>(builder: (context, state) {
      final state = context.watch<CreateGuessBloc>().state;
      return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: const Text('Create'),
        ),
        body: _body(context, state.locationImage),
        floatingActionButton: Column(mainAxisAlignment: MainAxisAlignment.end, children: <Widget>[
          FloatingActionButton(
            onPressed: () async {
              availableCameras().then(
                  (value) => Navigator.push(context, MaterialPageRoute(builder: (_) => CameraScreen(cameras: value))));
            },
            child: const Icon(Icons.camera_alt_outlined),
          ),
          const SizedBox(height: 20),
          FloatingActionButton(
            heroTag: null,
            onPressed: userPosition != null && state.locationImage != null
                ? () async {
                    LocationAPI.createLocation(
                        userPosition!.latitude, userPosition!.longitude, await state.locationImage!.readAsBytes());
                  }
                : null,
            child: const Icon(Icons.check),
          ),
        ]),
        bottomNavigationBar: const BottomNav(
          currentRoute: CreateScreen.route,
        ),
      );
    });
  }

  Widget _body(BuildContext context, XFile? locationImage) {
    BlocProvider.of<CreateGuessBloc>(context).add(CreateGuessInitializedEvent());
    return SingleChildScrollView(
        child: Container(
      padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20, top: 50),
      child: Center(
          child: Column(
        children: [
          _imageWidget(locationImage),
          const SizedBox(height: 20),
          _mapsWidget(),
        ],
      )),
    ));
  }

  Widget _imageWidget(XFile? image) {
    return image != null
        ? Container(decoration: _borderBoxDecoration(), child: Image.file(File(image.path)))
        : const Text('You need to take a picture before submitting!', style: TextStyle(color: Colors.red));
  }

  Widget _mapsWidget() {
    if (!locationLoading) {
      return userPosition != null
          ? Container(
              decoration: _borderBoxDecoration(),
              height: 200,
              child: GoogleMap(
                mapType: MapType.normal,
                initialCameraPosition:
                    CameraPosition(target: LatLng(userPosition!.latitude, userPosition!.longitude), zoom: 10),
                onMapCreated: (GoogleMapController controller) {
                  _mapController.complete(controller);
                },
                markers: _markers().toSet(),
              ))
          : const Text('You need to allow location before submitting!', style: TextStyle(color: Colors.red));
    } else {
      return Column(
        children: const [CircularProgressIndicator(), SizedBox(height: 10), Text('Loading location...')],
      );
    }
  }

  BoxDecoration _borderBoxDecoration() {
    return BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(5)),
        border: Border.all(color: Colors.deepPurple, width: 2));
  }

  List<Marker> _markers() {
    if (userPosition != null) {
      return [
        Marker(
            markerId: MarkerId(userPosition!.toString()),
            position: LatLng(userPosition!.latitude, userPosition!.longitude),
            icon: BitmapDescriptor.defaultMarker)
      ];
    } else {
      return [];
    }
  }

  _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;
    setState(() {
      locationLoading = true;
    });

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      setState(() {
        userPositionError = 'Location services are disabled.';
        locationLoading = false;
      });
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        setState(() {
          userPositionError = 'Location permissions are denied';
          locationLoading = false;
        });
      }
    }

    if (permission == LocationPermission.deniedForever) {
      setState(() {
        userPositionError = 'Location permissions are permanently denied, we cannot request permissions.';
        locationLoading = false;
      });
    }

    var position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    setState(() {
      userPosition = position;
      locationLoading = false;
    });
  }
}
