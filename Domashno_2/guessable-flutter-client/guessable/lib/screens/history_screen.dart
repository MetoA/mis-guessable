import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:guessable/blocs/guesses_bloc/guesses_bloc.dart';
import 'package:guessable/blocs/guesses_bloc/guesses_event.dart';
import 'package:guessable/blocs/guesses_bloc/guesses_state.dart';
import 'package:guessable/widgets/user_app_bar.dart';
import '../api/urls.dart';
import '../domain/guess.dart';
import '../widgets/bottom_nav.dart';

class HistoryScreen extends StatelessWidget {
  static const String route = '/history';

  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<GuessesBloc>(context).add(GuessesInitializedEvent());
    return Scaffold(
      appBar: const UserAppBar(
        title: 'History',
      ),
      body: Container(
        padding:
            const EdgeInsets.only(left: 20, right: 20, bottom: 20, top: 30),
        child: _body(context),
      ),
      bottomNavigationBar: const BottomNav(
        currentRoute: HistoryScreen.route,
      ),
    );
  }

  Widget _body(context) {
    return BlocBuilder<GuessesBloc, GuessesState>(builder: (context, state) {
      if (state is GuessesInitialState) {
        return const Center(child: CircularProgressIndicator());
      } else if (state is GuessesErrorState) {
        return Center(
          child: Text(state.error),
        );
      } else if (state is GuessesEmptyState) {
        return const Center(
          child: Text("No guesses"),
        );
      } else {
        return SingleChildScrollView(
          child: Column(
            children: state.guesses.map((e) => _guessCard(e, context)).toList(),
          ),
        );
      }
    });
  }

  Widget _guessCard(Guess guess, context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Guessed distance: ${guess.distanceMeters}m",
              style: const TextStyle(fontSize: 16),
            ),
            SizedBox(
              child: ElevatedButton(
                onPressed: () {
                  _openMap(context, guess);
                },
                style: ElevatedButton.styleFrom(
                  shape: const CircleBorder(),
                  elevation: 0,
                  side: const BorderSide(color: Colors.deepPurple),
                  padding: const EdgeInsets.all(10),
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.deepPurpleAccent,
                ),
                child: const Icon(Icons.map_sharp, color: Colors.deepPurple),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _openMap(context, guess) {
    BlocProvider.of<GuessesBloc>(context).add(GuessSelectedEvent(guess));
    Navigator.of(context).push(MaterialPageRoute(builder: (builder) {
      return _HistoryMapScreen();
    }));
  }
}

class _HistoryMapScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        Navigator.pop(context, false);
        BlocProvider.of<GuessesBloc>(context).add(GuessesInitializedEvent());
        return Future.value(false);
      },
      child: Scaffold(
        appBar: AppBar(),
        body: BlocBuilder<GuessesBloc, GuessesState>(builder: (context, state) {
          if (state is GuessSelectedState) {
            final guessedLatLng = LatLng(
              state.guess.guessedLatitude,
              state.guess.guessedLongitude,
            );

            final locationLatLng = LatLng(
              state.guess.location.latitude,
              state.guess.location.longitude,
            );

            return Stack(
              children: [
                GoogleMap(
                  mapType: MapType.normal,
                  initialCameraPosition: const CameraPosition(
                    target: LatLng(0, 0),
                    zoom: 15,
                  ),
                  onMapCreated: (GoogleMapController controller) async {
                    update() async {
                      var region = await controller.getVisibleRegion();
                      if (region.southwest.latitude == 0.0) {
                        return false;
                      }
                      CameraUpdate update = CameraUpdate.newLatLngBounds(
                        _getBounds(guessedLatLng, locationLatLng),
                        50,
                      );
                      controller.animateCamera(update);
                      return true;
                    }

                    while (await update() == false) {
                      update();
                    }
                  },
                  zoomControlsEnabled: false,
                  polylines: {
                    Polyline(
                      polylineId: const PolylineId("1"),
                      points: [guessedLatLng, locationLatLng],
                      patterns: [PatternItem.dot, PatternItem.gap(15)],
                      width: 5,
                    ),
                  },
                  markers: {
                    Marker(
                      markerId: MarkerId("${state.guess.id}"),
                      position: guessedLatLng,
                      infoWindow: const InfoWindow(title: "Your Guess"),
                    ),
                    Marker(
                      markerId: MarkerId("${state.guess.location.id}"),
                      position: locationLatLng,
                      icon: BitmapDescriptor.defaultMarkerWithHue(
                        BitmapDescriptor.hueGreen,
                      ),
                      infoWindow: const InfoWindow(
                        title: "Original Location",
                      ),
                    ),
                  },
                ),
                Positioned(
                  right: 0,
                  bottom: 0,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.of(context)
                          .push(MaterialPageRoute(builder: (builder) {
                        return _ImageFullScreen(id: state.guess.location.id);
                      }));
                    },
                    child: Hero(
                      tag: state.guess.location.id,
                      child: Container(
                        margin: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(5)),
                            border:
                                Border.all(color: Colors.deepPurple, width: 2)),
                        width: 150,
                        height: 150,
                        child: Image.network(
                          "$baseUrl/api/location/${state.guess.location.id}/image",
                          fit: BoxFit.fill,
                          height: double.infinity,
                          width: double.infinity,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            );
          } else {
            return const Center(
              child: Text("Error"),
            );
          }
        }),
      ),
    );
  }

  _getBounds(LatLng guessedLatLng, LatLng locationLatLng) {
    final points = [guessedLatLng, locationLatLng];

    final highestLat = points.map((e) => e.latitude).reduce(max);
    final highestLng = points.map((e) => e.longitude).reduce(max);
    final lowestLat = points.map((e) => e.latitude).reduce(min);
    final lowestLng = points.map((e) => e.longitude).reduce(min);

    final lowestLatLowestLong = LatLng(lowestLat, lowestLng);
    final highestLatHighestLong = LatLng(highestLat, highestLng);

    return LatLngBounds(
      southwest: lowestLatLowestLong,
      northeast: highestLatHighestLong,
    );
  }
}

class _ImageFullScreen extends StatelessWidget {
  final int id;

  const _ImageFullScreen({required this.id});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Hero(
        tag: id,
        child: Image.network(
          "$baseUrl/api/location/$id/image",
          fit: BoxFit.fill,
          height: double.infinity,
          width: double.infinity,
        ),
      ),
    );
  }
}
