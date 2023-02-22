import 'package:guessable/domain/location.dart';
import 'package:guessable/domain/user.dart';

class Guess {
  final int id;
  final Location location;
  final User guessedBy;
  final double guessedLatitude;
  final double guessedLongitude;
  final double distanceMeters;

  Guess(
      {required this.id,
      required this.location,
      required this.guessedBy,
      required this.guessedLatitude,
      required this.guessedLongitude,
      required this.distanceMeters});

  factory Guess.fromJson(Map<String, dynamic> json) {
    return Guess(
        id: json['id'],
        location: Location.fromJson(json['location']),
        guessedBy: User.fromJson(json['guessedBy']),
        guessedLatitude: json['guessedLatitude'],
        guessedLongitude: json['guessedLongitude'],
        distanceMeters: json['distanceMeters']);
  }
}
