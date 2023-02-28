import 'package:equatable/equatable.dart';

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
