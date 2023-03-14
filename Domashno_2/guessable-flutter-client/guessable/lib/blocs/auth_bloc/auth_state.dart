/// State in the application related to user authentication
abstract class AuthenticationState {}

/// State of the application when an authentication has not yet happened
class AuthenticationUninitialized extends AuthenticationState {}

/// State of the application where the user is authenticated
class AuthenticationAuthenticated extends AuthenticationState {}

/// State of the application where the user is not authenticated
class AuthenticationUnauthenticated extends AuthenticationState {}
