import 'dart:convert';

import 'package:guessable/api/status_codes_extensions.dart';
import 'package:guessable/api/urls.dart';
import 'package:http/http.dart';
import '../domain/guess.dart';
import 'http_client.dart';

/// Handles the HTTP requests to the API related to location guesses
class GuessAPI {
  static final http = HttpClient.client;

  /// Gets a [List<Guess>] of the existing guesses the logged in user has created
  static Future<List<Guess>> myGuesses() async {
    final response = await http.get(Uri.parse('$baseUrl/api/guess/my_guesses'));

    if (response.statusCode.isSuccessful) {
      return List.from(json.decode(response.body))
          .map((it) => Guess.fromJson(it))
          .toList();
    } else {
      throw Exception('Error fetching guesses!');
    }
  }

  /// Creates a guess for a specific guessable location
  ///
  /// * [locationId] - the id of the [Location] this guess is meant for
  /// * [latitude] - the map latitude the user is guessing the [Location] is at
  /// * [longitude] - the map longitude the user is guessing the [Location] is at
  static Future<Response> createGuess(int locationId, double latitude, double longitude) async {
    return http.post(Uri.parse('$baseUrl/api/guess'),
        body: jsonEncode(<String, dynamic>{'locationId': locationId, 'latitude': latitude, 'longitude': longitude}));
  }
}
