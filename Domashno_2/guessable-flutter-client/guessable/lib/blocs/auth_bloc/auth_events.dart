abstract class AuthenticationEvent {}

class AppStarted extends AuthenticationEvent {}

class AuthLogInEvent extends AuthenticationEvent {
  String token;

  AuthLogInEvent({required this.token});
}

class AuthLogOutEvent extends AuthenticationEvent {}
