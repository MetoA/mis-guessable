import 'package:equatable/equatable.dart';

/// Represents a JWT token response for authenticating the user
///
/// * [token] - the JWT token
/// * [username] - the username whom this token belongs to
/// * [JwtTokenResponse.fromJson] - used for creating a [JwtTokenResponse] object from JSON, typically from HTTP requests
class JwtTokenResponse extends Equatable {
  final String token;
  final String username;

  const JwtTokenResponse({required this.token, required this.username});

  factory JwtTokenResponse.fromJson(Map<String, dynamic> json) {
    return JwtTokenResponse(token: json['token'], username: json['username']);
  }

  @override
  List<Object?> get props => [token, username];
}
