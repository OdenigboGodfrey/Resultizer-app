import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:resultizer_merged/core/error/firebase_error_handler.dart';
import 'package:resultizer_merged/core/utils/app_global.dart';
import 'package:resultizer_merged/core/utils/custom_promise.dart';
import 'package:resultizer_merged/features/auth/data/models/user_model.dart';
import 'package:resultizer_merged/utils/constant/app_string.dart';

abstract class UserDetailDataSource {
  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  final FirebaseAuth authInstance = FirebaseAuth.instance;

  Future<UserModel> fetchUserByEmail({required String email});
  Future<UserModel> fetchUserByUid({required String uid});
  Future<bool> updateUser({required UserModel userModel});
  Future<bool> updatePassword(
      {required String oldPassword, required String newPassword});
  Future<bool> toggleFollowUser({required String uid});
  Future<Map<String, dynamic>> getFollowers({required String uid});
  Future<Map<String, dynamic>> getFollowing({required String uid});
}

class FirebaseUserDetailDataSource implements UserDetailDataSource {
  @override
  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  @override
  final FirebaseAuth authInstance = FirebaseAuth.instance;

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
        // get social info
        var followersUids = await getFollowers(uid:  userData['id']);
        var followingUids  = await getFollowing(uid:  userData['id']);
        
        userData = (documentSnapshot.data() as Map<dynamic, dynamic>);
        List roles = jsonDecode(userData['roles']);
        userModel = UserModel(
          id: userData['id'],
          email: email,
          username: userData['username'] ?? '',
          fullname: userData['fullname'] ?? '',
          roles: roles.map((e) => e.toString()).toList(),
        );

        if (followersUids.containsKey('data')) userModel.followers = followersUids['data'];
        if (followingUids.containsKey('data')) userModel.following = followingUids['data'];
      }
    } catch (e, stackTrace) {
      print(e);
      print(stackTrace);
      throw Exception(e);
    }
    return userModel!;
  }

  @override
  Future<UserModel> fetchUserByUid({required String uid}) async {
    UserModel? userModel;
    try {
      var documentSnapshot = await FirebaseFirestore.instance
          .collection(AppString.usersCollectionKey)
          .get();
      if (documentSnapshot.size > 0) {
        // Retrieve the 'fullname' field from the document
        var usersData = (documentSnapshot.docs);

        List<QueryDocumentSnapshot<Map<String, dynamic>>> usersDataList =
            documentSnapshot.docs;
        // usersDataList[0].
        var userData = usersDataList.firstWhere((element) {
          var tmpData = element.data();
          if (tmpData['id'] == uid) return true;
          return false;
        }).data();
        if (userData.isNotEmpty) {
          // get social info
          var followersUids = await getFollowers(uid:  userData['id']);
          var followingUids  = await getFollowing(uid:  userData['id']);
          
          // prepare user model
          List roles = jsonDecode(userData['roles']);
          userModel = UserModel(
            id: userData['id'],
            email: userData['id'],
            username: userData['username'] ?? '',
            fullname: userData['fullname'] ?? '',
            roles: roles.map((e) => e.toString()).toList(),
            profileImageURL: userData['profileImageURL'] ?? '',
          );

          if (followersUids.containsKey('data')) userModel.followers = followersUids['data'];
          if (followingUids.containsKey('data')) userModel.following = followingUids['data'];
        }
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
    // save to Firestore
    try {
      var _email =
          userModel.email.toString().replaceAll('odenigbo', 'Odenigbo');
      final userDocRef = FirebaseFirestore.instance
          .collection(AppString.usersCollectionKey)
          .doc(_email);
      DocumentSnapshot documentSnapshot = await userDocRef.get();
      if (documentSnapshot.exists) {
        return await customPromise(() async {
          await userDocRef.set(userModel.toDbStorageMap());
        });
      }
    } catch (e, stackTrace) {
      print(stackTrace);
    }
    return false;
  }

  @override
  Future<bool> updatePassword(
      {required String oldPassword, required String newPassword}) async {
    UserModel? userModel;
    var email =
        GlobalDataSource.userData.email.replaceAll('odenigbo', 'Odenigbo');
    try {
      final userCred = await authInstance.signInWithEmailAndPassword(
          email: email, password: oldPassword);
      await userCred.user!.updatePassword(newPassword);
      return true;
    } on FirebaseAuthException catch (e, stackTrace) {
      print(stackTrace);
      parseFirebaseException(e.code);
    } catch (e, stackTrace) {
      print(e);
      print(stackTrace);
      // throw Exception(e);
    }
    return false;
  }

  @override
  Future<bool> toggleFollowUser({required String uid}) async {
    var followingResult = await toggleAddToFollowing(uid);
    if (followingResult) {
      var followersResult = await toggleAddToFollowers(uid);
      if (!followersResult) {
        // reverse the first action
        var removeResult = await toggleAddToFollowing(uid);
      }
      return followersResult;
    }
    return false;
  }

  Future<dynamic> toggleAddToFollowing(String uid) async {
    String myUid = GlobalDataSource.userData.id;
    final userDocRef = FirebaseFirestore.instance
        .collection(AppString.followingCollectionKey)
        .doc(myUid);
    DocumentSnapshot documentSnapshot = await userDocRef.get();
    Map<String, dynamic> data;
    if (documentSnapshot.exists) {
      data = documentSnapshot.data() as Map<String, dynamic>;
      List<dynamic> dataUids = data['data'];
      if (dataUids.contains(uid)) {
        // remove item
        dataUids.remove(uid);
      } else {
        dataUids.add(uid);
      }

      data['data'] = dataUids;
    } else {
      data = {
        'data': [uid]
      };
    }

    return await customPromise(() async {
      await userDocRef.set(data);
    });
  }

  toggleAddToFollowers(String uid) async {
    String myUid = GlobalDataSource.userData.id;
    final userDocRef = FirebaseFirestore.instance
        .collection(AppString.followersCollectionKey)
        .doc(uid);
    DocumentSnapshot documentSnapshot = await userDocRef.get();
    Map<String, dynamic> data;
    if (documentSnapshot.exists) {
      data = documentSnapshot.data() as Map<String, dynamic>;
      List<dynamic> dataUids = data['data'];
      if (dataUids.contains(myUid)) {
        // remove item
        dataUids.remove(myUid);
      } else {
        dataUids.add(myUid);
      }

      data['data'] = dataUids;
    } else {
      data = {
        'data': [myUid]
      };
    }

    return await customPromise(() async {
      await userDocRef.set(data);
    });
  }

  @override
  Future<Map<String, dynamic>> getFollowers({required String uid}) async {
    // user a is followed by Users B,C and D
    // get user a's followers = Users B,C and D
    final userDocRef = FirebaseFirestore.instance
        .collection(AppString.followersCollectionKey)
        .doc(uid);
    DocumentSnapshot documentSnapshot = await userDocRef.get();
    Map<String, dynamic> data = {};
    if (documentSnapshot.exists) {
      data = documentSnapshot.data() as Map<String, dynamic>;
    }
    return data;
  }

  @override
  Future<Map<String, dynamic>> getFollowing({required String uid}) async {
    // user a is following User B,C and D
    // get user a's following = Users B,C and D
    final userDocRef = FirebaseFirestore.instance
        .collection(AppString.followingCollectionKey)
        .doc(uid);
    DocumentSnapshot documentSnapshot = await userDocRef.get();
    Map<String, dynamic> data = {};
    if (documentSnapshot.exists) {
      // documentSnapshot.
      data = documentSnapshot.data() as Map<String, dynamic>;
    }

    return data;
  }
}
