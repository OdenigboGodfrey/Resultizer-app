import 'dart:convert';

import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String id;
  final String email;
  final String username;
  String? fullname;
  List<String>? roles = [];
  List<dynamic>? following = [];
  List<dynamic>? followers = [];
  String? profileImageURL;
  
  User({
    required this.id,
    required this.email,
    required this.username,
    required this.fullname,
    this.roles,
    this.following,
    this.followers,
    this.profileImageURL,
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
      'following': jsonEncode(following ?? []),
      'followers': jsonEncode(followers ?? []),
      'profileImageURL': profileImageURL,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
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
    
    return User(
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
}
