import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'auth_events.dart';
import 'auth_state.dart';

/// Bloc for authentication events with side effects and state transitions
class AuthenticationBloc extends Bloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationBloc() : super(AuthenticationUninitialized()) {

    /// Side effects occurring after the app has started. If the user is already logged in the JWT token gets save in local storage
    on<AppStarted>((event, emit) async {
      await Future.delayed(const Duration(seconds: 2));
      final sharedPreferences = await SharedPreferences.getInstance();
      final hasToken = sharedPreferences.containsKey('auth_token');
      if (hasToken) {
        emit(AuthenticationAuthenticated());
      } else {
        emit(AuthenticationUnauthenticated());
      }
    });

    /// When the user logs successfully logs in, the JWT token gets saved into local storage for persistent connections
    on<AuthLogInEvent>((event, emit) async {
      final sharedPreferences = await SharedPreferences.getInstance();
      sharedPreferences.setString('auth_token', 'Bearer ${event.token}');
      emit(AuthenticationAuthenticated());
    });

    /// When the user successfully logs out, we remove the JWT token from the local storage
    on<AuthLogOutEvent>((event, emit) async {
      final sharedPreferences = await SharedPreferences.getInstance();
      sharedPreferences.remove('auth_token');
      emit(AuthenticationUnauthenticated());
    });
  }
}
