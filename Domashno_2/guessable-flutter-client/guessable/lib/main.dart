import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guessable/blocs/auth_bloc/auth_bloc.dart';
import 'package:guessable/blocs/create_guess_bloc/create_guess_bloc.dart';
import 'package:guessable/screens/create_screen.dart';
import 'package:guessable/screens/guess_screen.dart';
import 'package:guessable/screens/history_screen.dart';
import 'package:guessable/screens/home_screen.dart';
import 'package:guessable/screens/login_screen.dart';
import 'package:guessable/screens/signup_screen.dart';
import 'package:guessable/screens/splash_screen.dart';

import 'blocs/auth_bloc/auth_events.dart';
import 'blocs/guesses_bloc/guesses_bloc.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  static GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();

  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider<AuthenticationBloc>(create: (BuildContext context) => AuthenticationBloc()..add(AppStarted())),
          BlocProvider<GuessesBloc>(create: (BuildContext context) => GuessesBloc()),
          BlocProvider<CreateGuessBloc>(create: (BuildContext context) => CreateGuessBloc())
        ],
        child:
        MaterialApp(
          scaffoldMessengerKey: scaffoldMessengerKey,
          title: 'Guessable',
          theme: ThemeData(
              colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.deepPurple).copyWith(
                  secondary: Colors.deepPurpleAccent)
          ),
          initialRoute: SplashScreen.route,
          routes: {
            SplashScreen.route: (context) => const SplashScreen(),
            LoginScreen.route: (context) => const LoginScreen(),
            SignupScreen.route: (context) => const SignupScreen(),
            HomeScreen.route: (context) => const HomeScreen(),
            HistoryScreen.route: (context) => const HistoryScreen(),
            CreateScreen.route: (context) => const CreateScreen(),
            GuessScreen.route: (context) => const GuessScreen()
          },
          debugShowCheckedModeBanner: false,
        )
    );
  }
}
