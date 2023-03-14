import 'package:equatable/equatable.dart';

/// Represents a user for the application
///
/// * [id] - the unique identifier for the [User]
/// * [username] - a unique username for the [User]
/// * [password] - encrypted password used for authentication
/// * [User.fromJson] - used for creating a [User] object from JSON, typically from HTTP requests
class User extends Equatable {
  final int id;
  final String username;
  final String password;

  const User({required this.id, required this.username, required this.password});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(id: json['id'], username: json['username'], password: json['password']);
  }

  @override
  List<Object?> get props => [id, username, password];
}
