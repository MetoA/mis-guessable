import 'dart:typed_data';

import 'package:guessable/domain/user.dart';

class GuessableLocation {
  int id;
  double latitude;
  double longitude;
  Uint8List image;
  User addedBy;

  GuessableLocation(
      {required this.id, required this.latitude, required this.longitude, required this.image, required this.addedBy});
}
