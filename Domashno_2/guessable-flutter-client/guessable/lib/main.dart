import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guessable/blocs/create_guess_bloc/create_guess_bloc.dart';
import 'package:guessable/screens/create_screen.dart';
import 'package:guessable/screens/guess_screen.dart';
import 'package:guessable/screens/history_screen.dart';
import 'package:guessable/screens/home_screen.dart';
import 'package:guessable/screens/login_screen.dart';
import 'package:guessable/screens/signup_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'blocs/guesses_bloc/guesses_bloc.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  SharedPreferences.getInstance().then((prefs) {
    bool isLoggedIn = prefs.getString('auth_token') != null;
    runApp(MyApp(isLoggedIn: isLoggedIn));
  });
}

class MyApp extends StatelessWidget {
  final bool isLoggedIn;

  const MyApp({super.key, required this.isLoggedIn});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider<GuessesBloc>(create: (BuildContext context) => GuessesBloc()),
          BlocProvider<CreateGuessBloc>(create: (BuildContext context) => CreateGuessBloc())
        ],
        child:
        MaterialApp(
          title: 'Guessable',
          theme: ThemeData(
              colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.deepPurple).copyWith(
                  secondary: Colors.deepPurpleAccent)
          ),
          initialRoute: isLoggedIn ? HomeScreen.route : LoginScreen.route,
          routes: {
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
