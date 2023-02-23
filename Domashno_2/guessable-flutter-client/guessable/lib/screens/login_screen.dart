import 'dart:convert';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:guessable/api/auth_api.dart';
import 'package:guessable/api/status_codes_extensions.dart';
import 'package:guessable/domain/jwt_token_response.dart';
import 'package:guessable/screens/home_screen.dart';
import 'package:guessable/screens/signup_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  static const String route = '/login';

  const LoginScreen({super.key});

  @override
  State<StatefulWidget> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  String username = '';
  String password = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Login'),
        ),
        body: Container(
          padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20, top: 50),
          child: Center(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 15),
                  child: TextField(
                    controller: _usernameController,
                    onChanged: (username) {
                      setState(() {
                        this.username = username;
                      });
                    },
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(), labelText: 'Username', hintText: 'Enter username...'),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 25),
                  child: TextField(
                    obscureText: true,
                    enableSuggestions: false,
                    autocorrect: false,
                    controller: _passwordController,
                    onChanged: (password) {
                      setState(() {
                        this.password = password;
                      });
                    },
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(), labelText: 'Password', hintText: 'Enter password...'),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 50),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(minimumSize: const Size.fromHeight(40)),
                    onPressed: username.isEmpty || password.isEmpty
                        ? null
                        : () {
                            onLogin();
                          },
                    child: const Text('LOGIN'),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 15),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        minimumSize: const Size.fromHeight(40),
                        backgroundColor: Colors.white,
                        foregroundColor: Colors.deepPurple,
                        side: const BorderSide(width: 2.0, color: Colors.deepPurple)),
                    onPressed: () {
                      print('CONTINUE WITH GOOGLE CLICKED');
                    },
                    child: const Text('CONTINUE WITH GOOGLE'),
                  ),
                ),
                RichText(
                  text: TextSpan(
                    children: [
                      const TextSpan(text: 'Don\'t have an account? ', style: TextStyle(color: Colors.black87)),
                      TextSpan(
                        text: 'Sign up',
                        style: const TextStyle(color: Colors.deepPurple),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Navigator.of(context).pushNamed(SignupScreen.route);
                          },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
  }

  void onLogin() async {
    final loginResponse = await AuthAPI.login(username, password);
    if (loginResponse.statusCode.isSuccessful) {
      SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
      JwtTokenResponse response = JwtTokenResponse.fromJson(jsonDecode(loginResponse.body));
      sharedPreferences.setString('auth_token', 'Bearer ${response.token}');

      // TODO shouldn't use context in async calls...
      Navigator.of(context).pushNamedAndRemoveUntil(HomeScreen.route, (route) => false);
    } else {
      throw Exception('Failed to login');
    }
  }
}