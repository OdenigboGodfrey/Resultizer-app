import 'package:dartz/dartz.dart';
import 'package:resultizer_merged/core/error/error_handler.dart';
import 'package:resultizer_merged/features/auth/data/models/user_model.dart';

abstract class UserDetailRepository {
  Future<Either<Failure, UserModel>> fetchUserByEmail({required String email});
  Future<Either<Failure, bool>> updateUser({required UserModel userModel});
}