import 'package:equatable/equatable.dart';
import 'package:guessable/domain/location.dart';

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
