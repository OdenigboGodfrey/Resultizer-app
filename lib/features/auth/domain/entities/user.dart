import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String id;
  final String email;
  final String username;
  final String fullname;
  const User({
    required this.id,
    required this.email,
    required this.username,
    required this.fullname,
  });

  @override
  List<Object?> get props => [id, email, username];
}
