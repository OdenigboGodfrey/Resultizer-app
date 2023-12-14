import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:resultizer_merged/core/error/firebase_error_handler.dart';
import 'package:resultizer_merged/core/utils/custom_promise.dart';
import 'package:resultizer_merged/features/auth/data/models/user_model.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:resultizer_merged/utils/constant/app_string.dart';

Future<bool> setUserInfoFireStore(User? user, UserModel userModel) async {
  final userDocRef =
      FirebaseFirestore.instance.collection(AppString.usersCollectionKey).doc(userModel.email.toLowerCase());
  DocumentSnapshot documentSnapshot = await userDocRef.get();
  Map<String, dynamic> existingData = {};
  if (documentSnapshot.exists) {
    existingData = documentSnapshot.data() as Map<String, dynamic>;
  }

  // save to Firestore
  bool result = await customPromise(() async {
    await userDocRef.set(userModel.toMap());
  });
  return result;
}

abstract class AuthDatasource {
  final FirebaseAuth authInstance = FirebaseAuth.instance;

  Future<UserModel> signUpWithEmail({
    required String email,
    required String password,
    required String username,
    required String firstName,
    required String lastName,
  }) async {
    try {
      UserCredential userCredential =
          await authInstance.createUserWithEmailAndPassword(
        email: email.trim(),
        password: password.trim(),
      );
      await userCredential.user?.updateDisplayName(username);
      // setFullName(userCredential.user,firstName: firstName, lastName: lastName);
      return UserModel(
        id: userCredential.user!.uid,
        email: email,
        username: username,
        fullname: '$firstName $lastName',
      );
    } on FirebaseAuthException catch (e) {
      // Handle Firebase-specific signup errors here if needed
      throw Exception(e.message);
    }
  }

  Future<UserModel> logInWithEmail(
      {required String email, required String password});
  Future<UserModel> signInWithGoogle();
  Future<bool> signOut();
}

class FirebaseAuthDatasource implements AuthDatasource {
  @override
  final FirebaseAuth authInstance = FirebaseAuth.instance;

  @override
  Future<UserModel> logInWithEmail(
      {required String email, required String password}) async {
    UserModel? userModel;
    try {
      final userCred = await authInstance.signInWithEmailAndPassword(
          email: email, password: password);
      var _email = userCred.user!.email.toString().replaceAll('odenigbo', 'Odenigbo');
      Map<dynamic, dynamic> userData = {};
      DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance
          .collection(AppString.usersCollectionKey)
          .doc(_email)
          .get();
      if (documentSnapshot.exists) {
        // Retrieve the 'fullname' field from the document
        userData  =
            (documentSnapshot.data() as Map<dynamic, dynamic>);
        
      }

      List roles = jsonDecode(userData['roles']);
      userModel = UserModel(
          id: userCred.user!.uid,
          email: email,
          username: userData['username'] ?? (userCred.user!.displayName ?? ''),
          fullname: userData['fullname'] ?? '',
          roles: roles.map((e) => e.toString()).toList(),
        );
    } on FirebaseAuthException catch (e, stackTrace) {
      print(stackTrace);
      parseFirebaseException(e.code);
    } catch (e, stackTrace) {
      print(e);
      print(stackTrace);
      throw Exception(e);
    }
    return userModel!;
  }

  @override
  Future<UserModel> signInWithGoogle() async {
    UserModel? userModel;
    try {
      final googleUser = await GoogleSignIn().signIn();
      final googleAuth = await googleUser?.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );
      final userCred = await authInstance.signInWithCredential(credential);
      // setFullName(userCred.user, firstName: googleUser?.displayName.toString(), lastName: '');
      
      userModel?.fullname = googleUser?.displayName.toString();
      setUserInfoFireStore(userCred.user, userModel!);

      userModel = UserModel(
          id: userCred.user!.uid,
          email: googleUser!.email,
          username: googleUser.displayName ?? '',
          fullname: googleUser.displayName.toString());
    } on FirebaseAuthException catch (e) {
      parseFirebaseException(e.code);
    } catch (e) {
      //To prevent caching of failed credentials
      await GoogleSignIn().signOut();
      throw Exception(e);
    }
    return userModel!;
  }

  @override
  Future<UserModel> signUpWithEmail({
    required String email,
    required String password,
    required String username,
    required String firstName,
    required String lastName,
  }) async {
    UserModel? userModel;
    try {
      var fullname = '$firstName $lastName';
      final userCred = await authInstance.createUserWithEmailAndPassword(
          email: email, password: password);
      userCred.user!.updateDisplayName(username);
      userModel = UserModel(
          id: userCred.user!.uid,
          email: email,
          username: userCred.user!.displayName ?? username,
          fullname: fullname);
      // setFullName(userCred.user, firstName: firstName, lastName: lastName);
      setUserInfoFireStore(userCred.user, userModel);
    } on FirebaseAuthException catch (e) {
      parseFirebaseException(e.code);
    } catch (e, stackTrace) {
      print(stackTrace);
      throw Exception(e);
    }
    return userModel!;
  }

  @override
  Future<bool> signOut() async {
    bool result = false;
    try {
      await authInstance.signOut();
      await GoogleSignIn().signOut();
    } catch (e) {
      throw Exception(e);
    }
    return result;
  }
}
