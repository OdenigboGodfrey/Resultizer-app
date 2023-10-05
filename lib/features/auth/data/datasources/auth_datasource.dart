import 'package:firebase_auth/firebase_auth.dart';
import 'package:resultizer_merged/core/error/firebase_error_handler.dart';
import 'package:resultizer_merged/features/auth/data/models/user_model.dart';
import 'package:google_sign_in/google_sign_in.dart';

abstract class AuthDatasource {
  final FirebaseAuth authInstance = FirebaseAuth.instance;

  Future<UserModel> signUpWithEmail({
    required String email,
    required String password,
    required String username,
  }) async {
    try {
      UserCredential userCredential =
          await authInstance.createUserWithEmailAndPassword(
        email: email.trim(),
        password: password.trim(),
      );
      await userCredential.user?.updateDisplayName(username);
      return UserModel(
        id: userCredential.user!.uid,
        email: email,
        username: username,
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
      userModel = UserModel(
          id: userCred.user!.uid,
          email: email,
          username: userCred.user!.displayName ?? '');
    } on FirebaseAuthException catch (e) {
      parseFirebaseException(e.code);
    } catch (e) {
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
      userModel = UserModel(
          id: userCred.user!.uid,
          email: googleUser!.email,
          username: googleUser.displayName ?? '');
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
  Future<UserModel> signUpWithEmail(
      {required String email,
      required String password,
      required String username}) async {
    UserModel? userModel;
    try {
      final userCred = await authInstance.createUserWithEmailAndPassword(
          email: email, password: password);
      userCred.user!.updateDisplayName(username);
      userModel = UserModel(
          id: userCred.user!.uid,
          email: email,
          username: userCred.user!.displayName ?? username);
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
