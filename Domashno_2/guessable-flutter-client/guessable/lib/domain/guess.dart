import 'package:guessable/domain/guessable_location.dart';
import 'package:guessable/domain/user.dart';

class Guess {
  int id;
  GuessableLocation guessableLocation;
  User user;
  double guessedLatitude;
  double guessedLongitude;
  double distanceMeters;

  Guess(
      {required this.id,
      required this.guessableLocation,
      required this.user,
      required this.guessedLatitude,
      required this.guessedLongitude,
      required this.distanceMeters});
}
