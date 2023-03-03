import 'package:equatable/equatable.dart';
import 'package:guessable/domain/user.dart';

class Location extends Equatable {
  final int id;
  final double latitude;
  final double longitude;
  final User addedBy;

  const Location(
      {required this.id, required this.latitude, required this.longitude, required this.addedBy});

  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(
        id: json['id'],
        latitude: json['latitude'],
        longitude: json['longitude'],
        addedBy: User.fromJson(json['createdBy']));
  }

  @override
  List<Object?> get props => [id, latitude, longitude, addedBy];
}
