import 'package:guessable/api/headers.dart';
import 'package:guessable/api/urls.dart';
import 'package:http/http.dart' as http;

// TODO maybe convert these functions to the appropriate data classes here because
// https://docs.flutter.dev/cookbook/networking/fetch-data#convert-the-httpresponse-to-an-album
class GuessAPI {
  static Future<http.Response> myGuesses() async {
    return http.get(Uri.parse('$baseUrl/api/guess/my_guesses'), headers: await headers());
  }
}
