import 'package:dartz/dartz.dart';
import 'package:resultizer_merged/core/error/error_handler.dart';
import 'package:resultizer_merged/features/auth/data/models/user_model.dart';

abstract class UserDetailRepository {
  Future<Either<Failure, UserModel>> fetchUserByEmail({required String email});
  Future<Either<Failure, UserModel>> fetchUserByUid({required String uid});
  Future<Either<Failure, bool>> updateUser({required UserModel userModel});

  Future<Either<Failure, bool>> updatePassword(
      {required String oldPassword, required String newPassword});
  Future<Either<Failure, bool>> toggleFollowUser(
      {required String uid});
  Future<Either<Failure, Map<String, dynamic>>> getFollowers({required String uid});
  Future<Either<Failure, Map<String, dynamic>>> getFollowing(
      {required String uid});
}