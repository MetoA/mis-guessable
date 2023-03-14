/// Events that occur related to the authentication of the user and afterwards cause side effects and state transitions
abstract class AuthenticationEvent {}

/// An event that occurs at the start of the application
class AppStarted extends AuthenticationEvent {}

/// An event that occurs on successful log in of the user long with the respective JWT [token]
class AuthLogInEvent extends AuthenticationEvent {
  String token;

  AuthLogInEvent({required this.token});
}

/// An even that occurs when the user successfully logs out of the application
class AuthLogOutEvent extends AuthenticationEvent {}
