import 'dart:convert';

import 'package:guessable/api/status_codes_extensions.dart';
import 'package:guessable/api/urls.dart';
import 'package:http/http.dart';
import '../domain/guess.dart';
import 'http_client.dart';

class GuessAPI {
  static final http = HttpClient.client;

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

  static Future<Response> createGuess(int locationId, double latitude, double longitude) async {
    return http.post(Uri.parse('$baseUrl/api/guess'),
        body: jsonEncode(<String, dynamic>{'locationId': locationId, 'latitude': latitude, 'longitude': longitude}));
  }
}
