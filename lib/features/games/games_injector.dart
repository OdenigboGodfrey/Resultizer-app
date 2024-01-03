import 'package:resultizer_merged/container_injector.dart';
import 'package:resultizer_merged/core/api/dio_helper.dart';
import 'package:resultizer_merged/core/network/network_info.dart';
import 'package:resultizer_merged/features/games/data/datasource/games_datasource.dart';
import 'package:resultizer_merged/features/games/data/repositories/leagues_repository_implementation.dart';
import 'package:resultizer_merged/features/games/data/repositories/teams_repository_implementation.dart';
import 'package:resultizer_merged/features/games/domain/repositories/leagues_repository.dart';
import 'package:resultizer_merged/features/games/domain/repositories/teams_repository.dart';
import 'package:resultizer_merged/features/games/domain/usecase/leagues_usercase.dart';
import 'package:resultizer_merged/features/games/domain/usecase/teams_usercase.dart';
import 'package:resultizer_merged/features/games/presentation/cubit/leagues_cubit.dart';
import 'package:resultizer_merged/features/games/presentation/cubit/teams_cubit.dart';

void initGames() {
  sl
  ..registerLazySingleton<FirebaseGamesDatasource>(() => FirebaseGamesDatasource(dioHelper: sl<DioHelper>()))
  ..registerLazySingleton<LeaguesRepository>(() => LeaguesRepositoryImplemenatation(
        gamesDatasource: sl<FirebaseGamesDatasource>(), networkInfo: sl<NetworkInfoImpl>()))
  ..registerLazySingleton<TeamsRepository>(() => TeamsRepositoryImplemenatation(
        gamesDatasource: sl<FirebaseGamesDatasource>(), networkInfo: sl<NetworkInfoImpl>()))
  ..registerLazySingleton<LeagueUseCase>(
      () => LeagueUseCase(leaguesRepository:  sl<LeaguesRepository>()),
    )
    ..registerLazySingleton<TeamsUseCase>(
      () => TeamsUseCase(teamsRepository:  sl<TeamsRepository>()),
    )
  ..registerLazySingleton<LeagueCubit>(
      () => LeagueCubit(
          sl<LeagueUseCase>(),
    ))
    ..registerLazySingleton<TeamsCubit>(
      () => TeamsCubit(
          sl<TeamsUseCase>(),
    ));
}