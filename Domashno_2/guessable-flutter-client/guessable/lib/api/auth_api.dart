import 'dart:convert';

import 'package:guessable/api/headers.dart';
import 'package:guessable/api/urls.dart';
import 'package:http/http.dart' as http;

// TODO maybe convert these functions to the appropriate data classes here because
// https://docs.flutter.dev/cookbook/networking/fetch-data#convert-the-httpresponse-to-an-album
class AuthAPI {
  static Future<http.Response> login(String username, String password) async {
    return http.post(Uri.parse('$baseUrl/api/auth/login'),
        headers: await headers(), body: jsonEncode(<String, String>{'username': username, 'password': password}));
  }

  static Future<http.Response> register(String username, String password) async {
    return http.post(Uri.parse('$baseUrl/api/auth/register'),
        headers: await headers(), body: jsonEncode(<String, String>{'username': username, 'password': password}));
  }
}
