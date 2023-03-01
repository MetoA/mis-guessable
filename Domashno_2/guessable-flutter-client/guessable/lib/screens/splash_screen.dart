import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guessable/blocs/auth_bloc/auth_bloc.dart';
import 'package:guessable/blocs/auth_bloc/auth_state.dart';
import 'package:guessable/screens/home_screen.dart';
import 'package:guessable/screens/login_screen.dart';

class SplashScreen extends StatelessWidget {
  static const String route = '/splash';

  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener(
      bloc: BlocProvider.of<AuthenticationBloc>(context),
      listener: (BuildContext context, AuthenticationState state) {
        if (state is AuthenticationAuthenticated) {
          Navigator.of(context)
              .pushNamedAndRemoveUntil(HomeScreen.route, (route) => false);
        }
        if (state is AuthenticationUnauthenticated) {
          Navigator.of(context)
              .pushNamedAndRemoveUntil(LoginScreen.route, (route) => false);
        }
      },
      child: const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}
