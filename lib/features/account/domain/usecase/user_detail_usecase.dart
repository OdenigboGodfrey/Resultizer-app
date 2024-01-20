import 'package:dartz/dartz.dart';
import 'package:resultizer_merged/core/error/error_handler.dart';
import 'package:resultizer_merged/core/usecase/usecase.dart';
import 'package:resultizer_merged/features/account/domain/repository/user_detail_repository.dart';
import 'package:resultizer_merged/features/auth/data/models/user_model.dart';

class ChangePasswordParams {
  final String oldPassword;
  final String newPassword;

  ChangePasswordParams(this.oldPassword, this.newPassword);
}

class FetchUserDetailByEmailUseCase implements UseCase<UserModel, String> {
  final UserDetailRepository _repository;
  FetchUserDetailByEmailUseCase(this._repository);
  @override
  Future<Either<Failure, UserModel>> call(String email) async {
    return await _repository.fetchUserByEmail(email: email);
  }
}

class FetchUserDetailByUidUseCase implements UseCase<UserModel, String> {
  final UserDetailRepository _repository;
  FetchUserDetailByUidUseCase(this._repository);
  @override
  Future<Either<Failure, UserModel>> call(String uid) async {
    return await _repository.fetchUserByUid(uid: uid);
  }
}


class UpdateUserDetailUseCase implements UseCase<bool, UserModel> {
  final UserDetailRepository _repository;
  UpdateUserDetailUseCase(this._repository);
  @override
  Future<Either<Failure, bool>> call(UserModel model) async {
    return await _repository.updateUser(userModel: model);
  }
}

class ChangePasswordUseCase implements UseCase<bool, ChangePasswordParams> {
  final UserDetailRepository _repository;
  ChangePasswordUseCase(this._repository);
  @override
  Future<Either<Failure, bool>> call(ChangePasswordParams model) async {
    return await _repository.updatePassword(newPassword: model.newPassword, oldPassword: model.oldPassword);
  }
}

class GetFollowerUserUseCase implements UseCase<Map<String, dynamic>, String> {
  final UserDetailRepository _repository;
  GetFollowerUserUseCase(this._repository);
  @override
  Future<Either<Failure, Map<String, dynamic>>> call(String args) async {
    return await _repository.getFollowers(uid:args);
  }
}

class GetFollowingUserUseCase implements UseCase<Map<String, dynamic>, String> {
  final UserDetailRepository _repository;
  GetFollowingUserUseCase(this._repository);
  @override
  Future<Either<Failure, Map<String, dynamic>>> call(String args) async {
    return await _repository.getFollowing(uid:args);
  }
}

class ToggleFollowUserUseCase implements UseCase<bool, String> {
  final UserDetailRepository _repository;
  ToggleFollowUserUseCase(this._repository);
  @override
  Future<Either<Failure, bool>> call(String args) async {
    return await _repository.toggleFollowUser(uid:args);
  }
}
