import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guessable/blocs/auth_bloc/auth_bloc.dart';
import 'package:guessable/blocs/auth_bloc/auth_events.dart';

import '../blocs/auth_bloc/auth_state.dart';
import '../screens/login_screen.dart';

/// A top application bar that displays a [title] of choice and any other navigation actions
class UserAppBar extends StatelessWidget with PreferredSizeWidget {
  final String title;

  const UserAppBar({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return BlocListener(
      bloc: BlocProvider.of<AuthenticationBloc>(context),
      listener: (BuildContext context, AuthenticationState state) {
        if (state is AuthenticationUnauthenticated) {
          Navigator.of(context)
              .pushNamedAndRemoveUntil(LoginScreen.route, (route) => false);
        }
      },
      child: AppBar(title: Text(title), actions: [
        IconButton(
          onPressed: () {
            BlocProvider.of<AuthenticationBloc>(context).add(AuthLogOutEvent());
          },
          icon: const Icon(Icons.logout),
          tooltip: 'Log out',
        )
      ]),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
