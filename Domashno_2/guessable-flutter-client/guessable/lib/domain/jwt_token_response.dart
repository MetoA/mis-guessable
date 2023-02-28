import 'package:equatable/equatable.dart';

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
