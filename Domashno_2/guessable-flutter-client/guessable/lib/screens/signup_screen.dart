import 'package:flutter/material.dart';
import '../api/auth_api.dart';

/// The sign up screen where the users can create a new account
class SignupScreen extends StatefulWidget {
  static const String route = '/signup';

  const SignupScreen({super.key});

  @override
  State<StatefulWidget> createState() => _SignupScreenState();
}

/// The state and logic of the sign up screen
class _SignupScreenState extends State<SignupScreen> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  String username = '';
  String password = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Sign Up'),
        ),
        body: Container(
          padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20, top: 50),
          child: Center(
            child: SingleChildScrollView(
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
                        border: OutlineInputBorder(),
                        labelText: 'Username',
                        hintText: 'Enter username...',
                      ),
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
                          border: OutlineInputBorder(),
                          labelText: 'Password',
                          hintText: 'Enter password...',
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 50),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          minimumSize: const Size.fromHeight(40)),
                      onPressed: username.isEmpty || password.isEmpty
                          ? null
                          : onRegister,
                      child: const Text('SIGN UP'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
    );
  }

  void onRegister() {
    AuthAPI.register(username, password);
  }
}
