import 'package:resultizer_merged/container_injector.dart';
import 'package:resultizer_merged/core/api/dio_helper.dart';
import 'package:resultizer_merged/core/network/network_info.dart';
import 'package:resultizer_merged/features/home/data/datasources/soccer_datasource.dart';
import 'package:resultizer_merged/features/home/data/repositories/soccer_repository_implementation.dart';
import 'package:resultizer_merged/features/home/domain/use_cases/day_fixtures_usecase.dart';
import 'package:resultizer_merged/features/home/domain/repositories/soccer_repository.dart';
import 'package:resultizer_merged/features/home/domain/use_cases/fixture_detail_usecase.dart';
import 'package:resultizer_merged/features/home/domain/use_cases/live_fixtures_usecase.dart';
import 'package:resultizer_merged/features/home/presentation/cubit/soccer_cubit.dart';

void initHome() {
  sl
  ..registerLazySingleton<SoccerDataSource>(() => SoccerDataSourceImplementation(dioHelper: sl<DioHelper>()))
  ..registerLazySingleton<SoccerRepository>(() => SoccerRepositoryImplementation(
        soccerDataSource: sl<SoccerDataSource>(), networkInfo: sl<NetworkInfoImpl>()))
  ..registerLazySingleton<DayFixturesUseCase>(
      () => DayFixturesUseCase(soccerRepository:  sl<SoccerRepository>()),
    )
    ..registerLazySingleton<LiveGamesUseCase>(
      () => LiveGamesUseCase(soccerRepository:  sl<SoccerRepository>()),
    )
    ..registerLazySingleton<FixtureDetailUseCase>(
      () => FixtureDetailUseCase(soccerRepository:  sl<SoccerRepository>()),
    )
  ..registerLazySingleton<SoccerCubit>(
      () => SoccerCubit(
          sl<DayFixturesUseCase>(),
    ));
}