import 'dart:convert';

import 'package:resultizer_merged/features/auth/domain/entities/user.dart';

class UserModel extends User {
  final String id;
  final String email;
  final String username;
  String? fullname;
  List<String>? roles = [];
  
  UserModel({required this.id, required this.email, required this.username, required this.fullname, this.roles}): super(id: id, email: email, username: username, fullname: fullname, roles: roles);
  
  UserModel copyWith({
    String? id,
    String? email,
    String? username,
    String? fullname,
    List<String>? roles,
  }) {
    return UserModel(
      id: id ?? this.id,
      email: email ?? this.email,
      username: username ?? this.username, 
      fullname: fullname ?? this.fullname,
      roles: roles ?? [],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'email': email,
      'username': username,
      'fullname': fullname,
      'roles': jsonEncode(roles ?? []),
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'] ?? '',
      email: map['email'] ?? '',
      username: map['username'] ?? '',
      fullname: map['fullname'] ?? '',
      roles: map['roles'] ?? []
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source));

  @override
  String toString() => 'UserModel(id: $id, email: $email, username: $username)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is UserModel &&
        other.id == id &&
        other.email == email &&
        other.username == username &&
        other.roles == roles;
  }

  @override
  int get hashCode => id.hashCode ^ email.hashCode ^ username.hashCode;
}
