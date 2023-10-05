import 'package:resultizer_merged/container_injector.dart';
import 'package:resultizer_merged/core/network/network_info.dart';
import 'package:resultizer_merged/features/auth/data/datasources/auth_datasource.dart';
import 'package:resultizer_merged/features/auth/data/repositories/auth_repository_implementation.dart';
import 'package:resultizer_merged/features/auth/domain/repositories/auth_repository.dart';
import 'package:resultizer_merged/features/auth/domain/use_cases/login_use_case.dart';
import 'package:resultizer_merged/features/auth/presentation/cubit/auth_cubit.dart';

//googleSignInUseCase: sl<GoogleSignInUseCase>(),
//signOutUseCase: sl<SignOutUseCase>(),
//signupUseCase: sl<SignupUseCase>()),

void initAuth() {
  sl
  ..registerLazySingleton<FirebaseAuthDatasource>(() => FirebaseAuthDatasource())
  ..registerLazySingleton<AuthRepository>(() => AuthRepositoryImplementation(
        datasource: sl<FirebaseAuthDatasource>(), networkInfo: sl<NetworkInfoImpl>()))
  ..registerLazySingleton<LoginUseCase>(
      () => LoginUseCase(sl<AuthRepository>()),
    )
  ..registerLazySingleton<AuthCubit>(
      () => AuthCubit(
          loginUseCase: sl<LoginUseCase>(),
    ));
}