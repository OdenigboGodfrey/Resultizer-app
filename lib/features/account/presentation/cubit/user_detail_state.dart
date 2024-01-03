import 'package:resultizer_merged/features/auth/data/models/user_model.dart';

abstract class UserDetailStates {}

class UserDetailInitial extends UserDetailStates {}
class UserDetailLoaded extends UserDetailStates {
  final UserModel userDetail;

  UserDetailLoaded(this.userDetail);
}

class UserDetailLoadFailure extends UserDetailStates {
  final String message;

  UserDetailLoadFailure(this.message);
}

class UserDetailLoading extends UserDetailStates {}

class UserDetailUpdateFailed extends UserDetailStates {}
class UserDetailUpdateLoading extends UserDetailStates {}
class UserDetailUpdateSuccessful extends UserDetailStates {}

