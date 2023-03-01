import 'package:guessable/api/urls.dart';
import 'package:http/http.dart';

import 'http_client.dart';

// TODO maybe convert these functions to the appropriate data classes here because
// https://docs.flutter.dev/cookbook/networking/fetch-data#convert-the-httpresponse-to-an-album
class GuessAPI {

  static final http = HttpClient.client;

  static Future<Response> myGuesses() async {
    return http.get(Uri.parse('$baseUrl/api/guess/my_guesses'));
  }
}
