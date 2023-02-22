import 'dart:convert';
import 'dart:typed_data';

import 'package:guessable/api/headers.dart';
import 'package:guessable/api/urls.dart';
import 'package:http/http.dart' as http;

// TODO maybe convert these functions to the appropriate data classes here because
// https://docs.flutter.dev/cookbook/networking/fetch-data#convert-the-httpresponse-to-an-album
class LocationAPI {
  static Future<http.Response> randomLocation() async {
    return http.get(Uri.parse('$baseUrl/api/location'), headers: await headers());
  }

  static Future<http.Response> createLocation(double latitude, double longitude, Uint8List image) async {
    return http.post(Uri.parse('$baseUrl/api/location'),
        headers: await headers(),
        body: jsonEncode(<String, dynamic>{'latitude': latitude, 'longitude': longitude, 'image': image}));
  }

  static Future<http.Response> image(int locationId) async {
    return http.get(Uri.parse('$baseUrl/api/location/$locationId/image'), headers: await headers());
  }
}
