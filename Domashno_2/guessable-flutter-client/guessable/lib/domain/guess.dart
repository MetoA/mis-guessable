import 'package:equatable/equatable.dart';
import 'package:guessable/domain/location.dart';

/// Represents a guess for a location for the application
///
/// * [id] - the unique identifier for the [Guess]
/// * [location] - the [Location] this guess is meant for
/// * [guessedLatitude] - the guessed map latitude for the given location
/// * [guessedLongitude] - the guessed map longitude for the given location
/// * [distance] - the distance between the guess and the actual location in kilometers
/// * [Guess.fromJson] - used for creating a [Guess] object from JSON, typically from HTTP requests
class Guess extends Equatable {
  final int id;
  final Location location;
  final double guessedLatitude;
  final double guessedLongitude;
  final double distance;

  const Guess(
      {required this.id,
      required this.location,
      required this.guessedLatitude,
      required this.guessedLongitude,
      required this.distance});

  factory Guess.fromJson(Map<String, dynamic> json) {
    return Guess(
        id: json['id'],
        location: Location.fromJson(json['location']),
        guessedLatitude: json['guessedLatitude'],
        guessedLongitude: json['guessedLongitude'],
        distance: json['distance']);
  }

  @override
  List<Object?> get props => [id, location, guessedLatitude, guessedLongitude, distance];
}
