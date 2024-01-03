import 'dart:convert';

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

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'email': email,
      'username': username,
      'fullname': fullname,
      'roles': jsonEncode(roles ?? []),
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    List<String> _roles = [];
    if (map.containsKey('roles')) {
      var tmpRoles = jsonDecode(map['roles']) as List;
      for(var item in tmpRoles) {
        _roles.add(item.toString());
      }
    }
    return User(
      id: map['id'] ?? '',
      email: map['email'] ?? '',
      username: map['username'] ?? '',
      fullname: map['fullname'] ?? '',
      roles: _roles,
    );
  }
}
