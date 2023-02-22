import 'package:shared_preferences/shared_preferences.dart';

Future<Map<String, String>> headers() async {
  var sharedPreferences = await SharedPreferences.getInstance();
  String? authToken = sharedPreferences.getString('auth_token');

  Map<String, String> headers = {
    'Content-type': 'application/json',
    'Accept': 'application/json'
  };

  if (authToken != null) {
    headers['Authorization'] = authToken;
  }

  return headers;
}