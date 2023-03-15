import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:guessable/api/location_api.dart';
import 'package:guessable/api/status_codes_extensions.dart';
import 'package:guessable/domain/guess.dart';
import 'package:guessable/service/notifications_service.dart';
import 'package:guessable/widgets/image_frame.dart';
import 'package:guessable/widgets/user_app_bar.dart';

import '../api/guess_api.dart';
import '../domain/location.dart';
import '../widgets/bottom_nav.dart';

/// The guess screen where the user is shown a random image and he has to
/// guess the location on the map
class GuessScreen extends StatefulWidget {
  static const String route = '/guess';

  const GuessScreen({super.key});

  @override
  State<StatefulWidget> createState() => _GuessScreenState();
}

/// The state and logic of the guess screen
class _GuessScreenState extends State<GuessScreen> {
  Location? _randomGuessableLocation;
  Marker? _guessMarker;
  Guess? _guess;
  bool _loadingRandomLocation = false;
  bool _loadingResults = false;
  String? error;

  @override
  void initState() {
    super.initState();
    setState(() {
      _loadingRandomLocation = true;
    });

    LocationAPI.randomLocation().then((response) {
      if (response.statusCode.isSuccessful) {
        setState(() {
          _randomGuessableLocation = response.body.isEmpty ? null : Location.fromJson(jsonDecode(response.body));
        });
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
      appBar: const UserAppBar(
        title: 'Guess',
      ),
      body: _body(),
      bottomNavigationBar: const BottomNav(
        currentRoute: GuessScreen.route,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _canMakeGuess()
            ? () {
                setState(() {
                  _loadingResults = true;
                });
                GuessAPI.createGuess(
                        _randomGuessableLocation!.id, _guessMarker!.position.latitude, _guessMarker!.position.longitude)
                    .then((response) {
                  setState(() {
                    _loadingResults = false;
                  });
                  if (response.statusCode.isSuccessful) {
                    setState(() {
                      _guess = Guess.fromJson(json.decode(response.body));
                    });
                    NotificationsService.success('You were ${_guess!.distance.toStringAsFixed(2)}km away!', durationSeconds: 10);
                  }
                });

              }
            : null,
        child: const Text('Guess'),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
    );
  }

  Widget _body() {
    if (_loadingRandomLocation) {
      return const CircularProgressIndicator();
    }

    if (_randomGuessableLocation == null) {
      return const Center(
        child: Text('Error getting location', style: TextStyle(color: Colors.red),)
      );
    }
    return Stack(
      children: [
        GoogleMap(
          mapType: MapType.normal,
          initialCameraPosition: const CameraPosition(
            target: LatLng(0, 0),
            zoom: 0,
          ),
          zoomControlsEnabled: false,
          polylines: _polylines(),
          markers: _markers(),
          onTap: _guess == null ? (latLng) {
            setState(() {
              _guessMarker =
                  Marker(markerId: MarkerId(latLng.toString()), position: latLng, icon: BitmapDescriptor.defaultMarker);
            });
          } : null,
        ),
        ImageFrame(locationId: _randomGuessableLocation!.id),
      ],
    );
  }

  Set<Polyline> _polylines() {
    if (_guess != null && _randomGuessableLocation != null) {
      var locationLatLng = LatLng(_randomGuessableLocation!.latitude, _randomGuessableLocation!.longitude);
      var guessedLatLng = LatLng(_guess!.guessedLatitude, _guess!.guessedLongitude);
      return {
        Polyline(
          polylineId: const PolylineId("1"),
          points: [guessedLatLng, locationLatLng],
          patterns: [PatternItem.dot, PatternItem.gap(15)],
          width: 5,
        ),
      };
    } else {
      return <Polyline>{};
    }
  }

  Set<Marker> _markers() {
    var locationMarker = _randomGuessableLocation != null && _guess != null
        ? Marker(
            markerId: MarkerId("${_randomGuessableLocation!.id}"),
            position: LatLng(_randomGuessableLocation!.latitude, _randomGuessableLocation!.longitude),
            icon: BitmapDescriptor.defaultMarkerWithHue(
              BitmapDescriptor.hueGreen,
            ),
            infoWindow: const InfoWindow(
              title: "Original Location",
            ),
          )
        : null;

    return {_guessMarker, locationMarker}.whereType<Marker>().toSet();
  }

  bool _canMakeGuess() =>
      _randomGuessableLocation != null && _guessMarker != null && _guess == null && !_loadingResults;
}
