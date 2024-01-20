import 'dart:convert';

import 'package:resultizer_merged/features/auth/domain/entities/user.dart';

class UserModel extends User {
  final String id;
  final String email;
  final String username;
  String? fullname;
  List<String>? roles = [];
  List<dynamic>? following = [];
  List<dynamic>? followers = [];
  String? profileImageURL;

  UserModel(
      {required this.id,
      required this.email,
      required this.username,
      required this.fullname,
      this.roles,
      this.following,
      this.followers,
      this.profileImageURL,
      })
      : super(
            id: id,
            email: email,
            username: username,
            fullname: fullname,
            roles: roles,
            following: following,
      followers: followers,
      profileImageURL: profileImageURL,

    );

  UserModel copyWith({
    String? id,
    String? email,
    String? username,
    String? fullname,
    List<String>? roles,
    List<dynamic>? following,
    List<dynamic>? followers,
    String? profileImageURL,
  }) {
    return UserModel(
      id: id ?? this.id,
      email: email ?? this.email,
      username: username ?? this.username,
      fullname: fullname ?? this.fullname,
      roles: roles ?? [],
      followers: followers ?? [],
      following: following ?? [],
      profileImageURL: profileImageURL ?? this.profileImageURL,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'email': email,
      'username': username,
      'fullname': fullname,
      'roles': jsonEncode(roles ?? []),
      'following': jsonEncode(following ?? []),
      'followers': jsonEncode(followers ?? []),
      'profileImageURL': profileImageURL,
    };
  }

  Map<String, dynamic> toDbStorageMap() {
    return {
      'id': id,
      'email': email,
      'username': username,
      'fullname': fullname,
      'roles': jsonEncode(roles ?? []),
      'profileImageURL': profileImageURL,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    List<String> _roles = [];
    List<dynamic> _followers = [];
    List<dynamic> _following = [];
    
    if (map.containsKey('roles')) {
      var tmpRoles = jsonDecode(map['roles']) as List;
      for(var item in tmpRoles) {
        _roles.add(item.toString());
      }
    }

    if (map.containsKey('followers')) {
      var tmp = jsonDecode(map['followers']) as List;
      for(var item in tmp) {
        _followers.add(item.toString());
      }
    }

    if (map.containsKey('following')) {
      var tmp = jsonDecode(map['following']) as List;
      for(var item in tmp) {
        _following.add(item.toString());
      }
    }

    return UserModel(
        id: map['id'] ?? '',
        email: map['email'] ?? '',
        username: map['username'] ?? '',
        fullname: map['fullname'] ?? '',
        roles: _roles,
        followers: _followers,
        following: _following,
        profileImageURL: map['profileImageURL'] ?? '',
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
