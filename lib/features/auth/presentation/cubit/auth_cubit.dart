import 'package:resultizer_merged/features/auth/domain/use_cases/login_use_case.dart';
import 'package:resultizer_merged/features/auth/presentation/cubit/auth_state.dart';
import 'package:bloc/src/cubit.dart';



class AuthCubit extends Cubit<AuthState> {
  final LoginUseCase loginUseCase;

  AuthCubit({
    required this.loginUseCase,
  }): super(AuthInitial());
  
  Future<void> login({required String email, required String password}) async {
    emit(AuthLoading());
    final params = LoginParams(email: email, password: password, name: '');
    final result = await loginUseCase(params);
    result.fold((left) => emit(AuthLoadFailed(left.message)),
        (right) {
          emit(AuthLoadSuccess(data: right));
        });
  }

  // Future<void> signUpWithGoogle() async {
  //   emit(AuthLoading());
  //   final result = await googleSignInUseCase(NoParams());
  //   result.fold((left) => emit(AuthLoadFailed(left.message)),
  //       (right) => emit(AuthLoadSuccess()));
  // }
}