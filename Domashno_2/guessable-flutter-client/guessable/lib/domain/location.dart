import 'package:equatable/equatable.dart';
import 'package:guessable/domain/user.dart';

/// Represents a guessable location for the application
///
/// * [id] - the unique identifier for the [Location]
/// * [latitude] - the map latitude of the [Location]
/// * [longitude] - the map longitude of the [Location]
/// * [addedBy] - the [User] that created the [Location]
/// * [Location.fromJson] - used for creating a [Location] object from JSON, typically from HTTP requests
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
