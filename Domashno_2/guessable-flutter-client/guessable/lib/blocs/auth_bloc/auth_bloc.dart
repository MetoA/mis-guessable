import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'auth_events.dart';
import 'auth_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationBloc() : super(AuthenticationUninitialized()) {
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

    on<AuthLogInEvent>((event, emit) async {
      final sharedPreferences = await SharedPreferences.getInstance();
      sharedPreferences.setString('auth_token', 'Bearer ${event.token}');
      emit(AuthenticationAuthenticated());
    });

    on<AuthLogOutEvent>((event, emit) async {
      final sharedPreferences = await SharedPreferences.getInstance();
      sharedPreferences.remove('auth_token');
      emit(AuthenticationUnauthenticated());
    });
  }
}
