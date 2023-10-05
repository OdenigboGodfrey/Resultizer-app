import 'package:dartz/dartz.dart';
import 'package:resultizer_merged/features/auth/domain/entities/user.dart';
import 'package:resultizer_merged/core/error/error_handler.dart';

abstract class AuthRepository {
  Future<Either<Failure, User>> signUpWithEmail(
      {required String email, required String password, required String name});
  Future<Either<Failure, User>> logInWithEmail(
      {required String email, required String password});
  Future<Either<Failure, User>> signInWithGoogle();
  Future<Either<Failure, bool>> signOut();
}
