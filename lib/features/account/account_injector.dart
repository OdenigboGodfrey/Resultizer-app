import 'package:resultizer_merged/container_injector.dart';
import 'package:resultizer_merged/core/network/network_info.dart';
import 'package:resultizer_merged/features/account/data/datasource/manage_chat_datasource.dart';
import 'package:resultizer_merged/features/account/data/datasource/user_detail_datasource.dart';
import 'package:resultizer_merged/features/account/data/repositories/manage_chat_implementation.dart';
import 'package:resultizer_merged/features/account/data/repositories/user_detail_implementation.dart';
import 'package:resultizer_merged/features/account/domain/repository/manage_chat_repository.dart';
import 'package:resultizer_merged/features/account/domain/repository/user_detail_repository.dart';
import 'package:resultizer_merged/features/account/domain/usecase/manage_chat_usecase.dart';
import 'package:resultizer_merged/features/account/domain/usecase/user_detail_usecase.dart';
import 'package:resultizer_merged/features/account/presentation/cubit/manage_chat_cubit.dart';
import 'package:resultizer_merged/features/account/presentation/cubit/user_detail_cubit.dart';

void initAccount() {
  sl
    ..registerLazySingleton<FirebaseUserDetailDataSource>(
        () => FirebaseUserDetailDataSource())
    ..registerLazySingleton<FirebaseManageChatDataSource>(
        () => FirebaseManageChatDataSource())
    ..registerLazySingleton<UserDetailRepository>(() =>
        UserDetailImplementation(
            dataSource: sl<FirebaseUserDetailDataSource>(),
            networkInfo: sl<NetworkInfoImpl>()))
    ..registerLazySingleton<ManageChatRepository>(() =>
        ManageChatImplementation(
            dataSource: sl<FirebaseManageChatDataSource>(),
            networkInfo: sl<NetworkInfoImpl>()))
    ..registerLazySingleton<FetchUserDetailUseCase>(
      () => FetchUserDetailUseCase(sl<UserDetailRepository>()),
    )
    ..registerLazySingleton<UpdateUserDetailUseCase>(
      () => UpdateUserDetailUseCase(sl<UserDetailRepository>()),
    )
    ..registerLazySingleton<CountChatUseCase>(
      () => CountChatUseCase(sl<ManageChatRepository>()),
    )
    ..registerLazySingleton<GetChatMetaUseCase>(
      () => GetChatMetaUseCase(sl<ManageChatRepository>()),
    )
    ..registerLazySingleton<DeleteChatUseCase>(
      () => DeleteChatUseCase(sl<ManageChatRepository>()),
    )
    ..registerLazySingleton<DeleteChatMetaUseCase>(
      () => DeleteChatMetaUseCase(sl<ManageChatRepository>()),
    )
    ..registerLazySingleton<UserDetailCubit>(() => UserDetailCubit(
          sl<FetchUserDetailUseCase>(),
          sl<UpdateUserDetailUseCase>(),
        ))
    ..registerLazySingleton<ManageChatCubit>(() => ManageChatCubit(
          countChatUseCase: sl<CountChatUseCase>(),
          getChatMetaUseCase: sl<GetChatMetaUseCase>(),
          deleteChatUseCase: sl<DeleteChatUseCase>(),
          deleteChatMetaUseCase: sl<DeleteChatMetaUseCase>(),
        ));
}
