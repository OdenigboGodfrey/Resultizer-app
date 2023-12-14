import 'package:bloc/bloc.dart';
import 'package:resultizer_merged/features/account/domain/usecase/user_detail_usecase.dart';
import 'package:resultizer_merged/features/account/presentation/cubit/user_detail_state.dart';
import 'package:resultizer_merged/features/auth/data/models/user_model.dart';


class UserDetailCubit extends Cubit<UserDetailStates> {
  UserDetailCubit(this.userDetailUseCase, this.updateUserDetailUseCase): super(UserDetailInitial());

  final FetchUserDetailUseCase userDetailUseCase;
  final UpdateUserDetailUseCase updateUserDetailUseCase;
  
  late UserModel? userModel;
  
  Future<UserModel?> fetchUserByEmail(String email) async {
    emit(UserDetailLoading());
    final fixtures = await userDetailUseCase(email);
    fixtures.fold(
      (left) { 
        emit(UserDetailLoadFailure(left.message));
        },
      (right) {
        userModel = right;
        if (userModel!.id.isNotEmpty) {
          emit(UserDetailLoaded(userModel!));
        }
        
      },
    );
    return userModel;
  }

  Future<bool> updateUser(UserModel model) async {
    bool status = false;
    final fixtures = await updateUserDetailUseCase(model);
    fixtures.fold(
      (left) {},
      (right) {
        status = right;
        
      },
    );
    return status;
  }
}