import 'dart:convert';
import 'dart:typed_data';

import 'package:guessable/api/urls.dart';
import 'package:http/http.dart';

import 'http_client.dart';

class LocationAPI {

  static final http = HttpClient.client;

  static Future<Response> randomLocation() async {
    return http.get(Uri.parse('$baseUrl/api/location/random'));
  }

  static Future<Response> createLocation(double latitude, double longitude, Uint8List image) async {
    return http.post(Uri.parse('$baseUrl/api/location'),
        body: jsonEncode(<String, dynamic>{'latitude': latitude, 'longitude': longitude, 'image': image}));
  }

  static Future<Response> image(int locationId) async {
    return http.get(Uri.parse('$baseUrl/api/location/$locationId/image'));
  }
}
