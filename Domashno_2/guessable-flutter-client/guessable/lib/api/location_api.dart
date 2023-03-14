import 'dart:convert';
import 'dart:typed_data';

import 'package:guessable/api/urls.dart';
import 'package:http/http.dart';

import 'http_client.dart';

/// Handles the HTTP requests to the API related to guessable locations
class LocationAPI {

  static final http = HttpClient.client;

  /// Gets a random [Location] that the current logged in user has not yet guessed or null if there are none left
  static Future<Response> randomLocation() async {
    return http.get(Uri.parse('$baseUrl/api/location/random'));
  }

  /// Creates a guessable location
  ///
  /// * [latitude] - the map latitude of the location that needs to be guessed
  /// * [longitude] - the map longitude of the location that needs to be guessed
  /// * [image] - a [Uint8List] of the image data that is used to assist in guessing where the location is
  static Future<Response> createLocation(double latitude, double longitude, Uint8List image) async {
    return http.post(Uri.parse('$baseUrl/api/location'),
        body: jsonEncode(<String, dynamic>{'latitude': latitude, 'longitude': longitude, 'image': image}));
  }

  /// Gets the [Uint8List] image data for a specific location by its id [locationId]
  static Future<Response> image(int locationId) async {
    return http.get(Uri.parse('$baseUrl/api/location/$locationId/image'));
  }
}
