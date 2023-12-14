import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String id;
  final String email;
  final String username;
  String? fullname;
  List<String>? roles = [];
  User({
    required this.id,
    required this.email,
    required this.username,
    required this.fullname,
    this.roles,
  });

  @override
  List<Object?> get props => [id, email, username];
}
