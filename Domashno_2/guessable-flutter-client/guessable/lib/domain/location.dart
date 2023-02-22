import 'dart:typed_data';

import 'package:guessable/domain/user.dart';

class Location {
  final int id;
  final double latitude;
  final double longitude;
  final Uint8List image;
  final User addedBy;

  Location(
      {required this.id, required this.latitude, required this.longitude, required this.image, required this.addedBy});

  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(
        id: json['id'],
        latitude: json['latitude'],
        longitude: json['longitude'],
        image: Uint8List.fromList(json['image']),
        addedBy: User.fromJson(json['addedBy']));
  }
}
