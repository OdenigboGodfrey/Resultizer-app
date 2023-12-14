import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:resultizer_merged/core/utils/custom_promise.dart';
import 'package:resultizer_merged/features/auth/data/models/user_model.dart';
import 'package:resultizer_merged/utils/constant/app_string.dart';

abstract class UserDetailDataSource {
  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  Future<UserModel> fetchUserByEmail({required String email});
  Future<bool> updateUser({required UserModel userModel});
}

class FirebaseUserDetailDataSource implements UserDetailDataSource {
  @override
  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  @override
  Future<UserModel> fetchUserByEmail({required String email}) async {
    UserModel? userModel;
    try {
      var _email = email.toString().replaceAll('odenigbo', 'Odenigbo');

      //var _email = email;
      Map<dynamic, dynamic> userData = {};
      DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance
          .collection(AppString.usersCollectionKey)
          .doc(_email)
          .get();
      if (documentSnapshot.exists) {
        // Retrieve the 'fullname' field from the document
        userData = (documentSnapshot.data() as Map<dynamic, dynamic>);
        List roles = jsonDecode(userData['roles']);
        userModel = UserModel(
          id: userData['id'],
          email: email,
          username: userData['username'] ?? '',
          fullname: userData['fullname'] ?? '',
          roles: roles.map((e) => e.toString()).toList(),
        );
      }
    } catch (e, stackTrace) {
      print(e);
      print(stackTrace);
      throw Exception(e);
    }
    return userModel!;
  }

  @override
  Future<bool> updateUser({required UserModel userModel}) async {
    var _email = userModel.email.toString().replaceAll('odenigbo', 'Odenigbo');
    final userDocRef = FirebaseFirestore.instance
        .collection(AppString.usersCollectionKey)
        .doc(_email);
    DocumentSnapshot documentSnapshot = await userDocRef.get();
    if (documentSnapshot.exists) {
      return await customPromise(() async {
        await userDocRef.set(userModel.toMap());
      });
    }
    return false;
    // save to Firestore
  }
}
