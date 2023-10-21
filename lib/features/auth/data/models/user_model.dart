import 'dart:convert';

import 'package:resultizer_merged/features/auth/domain/entities/user.dart';

class UserModel extends User {
  final String id;
  final String email;
  final String username;
  final String fullname;
  
  const UserModel({required this.id, required this.email, required this.username, required this.fullname}): super(id: id, email: email, username: username, fullname: fullname);
  
  UserModel copyWith({
    String? id,
    String? email,
    String? username,
    String? fullname,
  }) {
    return UserModel(
      id: id ?? this.id,
      email: email ?? this.email,
      username: username ?? this.username, 
      fullname: fullname ?? this.fullname,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'email': email,
      'username': username,
      'fullname': fullname,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'] ?? '',
      email: map['email'] ?? '',
      username: map['username'] ?? '',
      fullname: map['fullname'] ?? '',
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
        other.username == username;
  }

  @override
  int get hashCode => id.hashCode ^ email.hashCode ^ username.hashCode;
}
