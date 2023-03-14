import 'dart:convert';
import 'package:guessable/api/http_client.dart';
import 'package:guessable/api/status_codes_extensions.dart';
import 'package:guessable/api/urls.dart';
import 'package:guessable/domain/jwt_token_response.dart';
import 'package:guessable/domain/user.dart';
import 'package:guessable/service/notifications_service.dart';

/// Handles the HTTP requests to the API for authentication purposes
class AuthAPI {
  static final http = HttpClient.client;

  /// Logs the user into the application
  ///
  /// * [username] the username of the [User] that is logging in
  /// * [password] the password of the [User] that is logging in
  ///
  /// Returns a [JwtTokenResponse] if the authentication was successful, null otherwise
  static Future<JwtTokenResponse?> login(
      String username, String password) async {
    final response = await http.post(Uri.parse('$baseUrl/api/auth/login'),
        body: jsonEncode({'username': username, 'password': password}));

    if (response.statusCode.isSuccessful) {
      return JwtTokenResponse.fromJson(jsonDecode(response.body));
    } else {
      NotificationsService.error('Invalid username or password');
    }

    return null;
  }

  /// Registers a new user into the application
  ///
  /// * [username] the username of the [User] that is being created
  /// * [password] the password of the [User] that is being created
  static Future<void> register(String username, String password) async {
    final response = await http.post(Uri.parse('$baseUrl/api/auth/register'),
        body: jsonEncode(
            <String, String>{'username': username, 'password': password}));

    if (response.statusCode.isSuccessful) {
      NotificationsService.success('Sign Up successful!');
    } else {
      NotificationsService.error('Username already exists');
    }
  }
}
