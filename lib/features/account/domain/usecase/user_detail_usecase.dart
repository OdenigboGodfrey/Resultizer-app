import 'package:dartz/dartz.dart';
import 'package:resultizer_merged/core/error/error_handler.dart';
import 'package:resultizer_merged/core/usecase/usecase.dart';
import 'package:resultizer_merged/features/account/domain/repository/user_detail_repository.dart';
import 'package:resultizer_merged/features/auth/data/models/user_model.dart';

class FetchUserDetailUseCase implements UseCase<UserModel, String> {
  final UserDetailRepository _repository;
  FetchUserDetailUseCase(this._repository);
  @override
  Future<Either<Failure, UserModel>> call(String email) async {
    return await _repository.fetchUserByEmail(email: email);
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
