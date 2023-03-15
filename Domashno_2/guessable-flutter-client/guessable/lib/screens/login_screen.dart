import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guessable/api/auth_api.dart';
import 'package:guessable/blocs/auth_bloc/auth_events.dart';
import 'package:guessable/screens/home_screen.dart';
import 'package:guessable/screens/signup_screen.dart';

import '../blocs/auth_bloc/auth_bloc.dart';
import '../blocs/auth_bloc/auth_state.dart';

/// The login screen where the users login
class LoginScreen extends StatefulWidget {
  static const String route = '/login';

  const LoginScreen({super.key});

  @override
  State<StatefulWidget> createState() => _LoginScreenState();
}

/// The state and logic of the login screen
class _LoginScreenState extends State<LoginScreen> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  String username = '';
  String password = '';

  @override
  Widget build(BuildContext context) {
    return BlocListener(
      bloc: BlocProvider.of<AuthenticationBloc>(context),
      listener: (BuildContext context, AuthenticationState state) {
        if (state is AuthenticationAuthenticated) {
          Navigator.of(context)
              .pushNamedAndRemoveUntil(HomeScreen.route, (route) => false);
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Login'),
        ),
        body: Container(
          padding:
              const EdgeInsets.only(left: 20, right: 20, bottom: 20, top: 50),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
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
                    padding: const EdgeInsets.only(bottom: 30),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          minimumSize: const Size.fromHeight(40)),
                      onPressed: username.isEmpty || password.isEmpty
                          ? null
                          : () => onLogin(BlocProvider.of<AuthenticationBloc>(context)),
                      child: const Text('LOGIN'),
                    ),
                  ),
                  RichText(
                    text: TextSpan(
                      children: [
                        const TextSpan(
                          text: 'Don\'t have an account? ',
                          style: TextStyle(color: Colors.black87),
                        ),
                        TextSpan(
                          text: 'Sign up',
                          style: const TextStyle(color: Colors.deepPurple),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.of(context)
                                  .pushNamed(SignupScreen.route);
                            },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void onLogin(blocProvider) async {
    final loginResponse = await AuthAPI.login(username, password);
    final token = loginResponse?.token;
    if (token != null) {
      blocProvider.add(AuthLogInEvent(token: token));
    }
  }
}
