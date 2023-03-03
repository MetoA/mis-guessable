import 'dart:convert';
import 'dart:typed_data';

import 'package:equatable/equatable.dart';

class Location extends Equatable {
  final int id;
  final double latitude;
  final double longitude;
  final Uint8List image;

  const Location({required this.id, required this.latitude, required this.longitude, required this.image});

  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(
      id: json['id'],
      latitude: json['latitude'],
      longitude: json['longitude'],
      // image: Uint8List.fromList(utf8.encode(json['image'])),
      image: Uint8List.fromList(json['image'].toString().split(',').map((e) => int.parse(e)).toList()),
    );
  }

  @override
  List<Object?> get props => [id, latitude, longitude, image];
}
