import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:guessable/api/location_api.dart';
import 'package:guessable/api/status_codes_extensions.dart';
import 'package:guessable/domain/guess.dart';

import '../api/guess_api.dart';
import '../domain/location.dart';
import '../widgets/bottom_nav.dart';

class GuessScreen extends StatefulWidget {
  static const String route = '/guess';

  const GuessScreen({super.key});

  @override
  State<StatefulWidget> createState() => _GuessScreenState();
}

class _GuessScreenState extends State<GuessScreen> {
  Location? _randomGuessableLocation;
  Marker? _guessMarker;
  
  Guess? _guess;
  bool _loadingRandomLocation = false;
  bool _loadingResults = false;
  String? error;

  final Completer<GoogleMapController> _mapController = Completer<GoogleMapController>();

  @override
  void initState() {
    super.initState();
    setState(() {
      _loadingRandomLocation = true;
    });

    LocationAPI.randomLocation().then((response) {
      if (response.statusCode.isSuccessful) {
        print("Response: ${response.body}");
        setState(() {
          _randomGuessableLocation = response.body.isEmpty ? null : Location.fromJson(jsonDecode(response.body));
        });
        print("Random guessable location: $_randomGuessableLocation");
      } else {
        error = 'Error getting location to guess!';
      }

      setState(() {
        _loadingRandomLocation = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Guess'),
      ),
      body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20, top: 50),
            child: Center(
                child: Column(
                  children: [
                    _locationImage(),
                    const SizedBox(
                      height: 20,
                    ),
                    _mapsWidget(),
                    _guess != null ? Text('You were off ${_guess!.distance}km') : Container(),
                    ElevatedButton(
                      onPressed: _canMakeGuess() ? () {
                        print('Guess clicked');
                        setState(() {
                          _loadingResults = true;
                        });
                        GuessAPI.createGuess(_randomGuessableLocation!.id, _guessMarker!.position.latitude,
                            _guessMarker!.position.longitude).then((response) {
                              setState(() {
                                _loadingResults = false;
                              });
                               if (response.statusCode.isSuccessful) {
                                 setState(() {
                                   _guess = Guess.fromJson(json.decode(response.body));
                                 });
                               }
                        });
                      } : null,
                      child: _loadingResults ? const CircularProgressIndicator() : const Text('Make a guess!'),
                    )
                  ],
                )),
          )),
      bottomNavigationBar: const BottomNav(
        currentRoute: GuessScreen.route,
      ),
    );
  }

  Widget _locationImage() {
    return _loadingRandomLocation
        ? const CircularProgressIndicator()
        : Container(
      decoration: _borderBoxDecoration(),
      child:
      _randomGuessableLocation != null ? Image.memory(_randomGuessableLocation!.image) : const Text('No image'),
    );
  }

  Widget _mapsWidget() {
    return _randomGuessableLocation != null
        ? Container(
        decoration: _borderBoxDecoration(),
        height: 500,
        child: GoogleMap(
          gestureRecognizers: Set()
            ..add(Factory<OneSequenceGestureRecognizer>(() => EagerGestureRecognizer())),
          mapType: MapType.normal,
          initialCameraPosition: const CameraPosition(target: LatLng(0, 0), zoom: 0),
          onMapCreated: (GoogleMapController controller) {
            _mapController.complete(controller);
          },
          onTap: (latLng) {
            setState(() {
              _guessMarker =
                  Marker(markerId: MarkerId(latLng.toString()), position: latLng, icon: BitmapDescriptor.defaultMarker);
            });
          },
          markers: _guessMarker != null ? {_guessMarker!} : <Marker>{},
        ))
        : Container();
  }

  BoxDecoration _borderBoxDecoration() {
    return BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(5)),
        border: Border.all(color: Colors.deepPurple, width: 2));
  }

  bool _canMakeGuess() => _randomGuessableLocation != null && _guessMarker != null && _guess == null && !_loadingResults;
}
