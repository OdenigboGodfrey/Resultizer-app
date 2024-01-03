import 'package:resultizer_merged/container_injector.dart';
import 'package:resultizer_merged/core/api/dio_helper.dart';
import 'package:resultizer_merged/core/network/network_info.dart';
import 'package:resultizer_merged/features/home/data/datasources/favourites_datasource.dart';
import 'package:resultizer_merged/features/home/data/datasources/soccer_datasource.dart';
import 'package:resultizer_merged/features/home/data/repositories/favourite_repository_implementation.dart';
import 'package:resultizer_merged/features/home/data/repositories/soccer_repository_implementation.dart';
import 'package:resultizer_merged/features/home/domain/repositories/favourite_repository.dart';
import 'package:resultizer_merged/features/home/domain/use_cases/competition_fixtures_usecase.dart';
import 'package:resultizer_merged/features/home/domain/use_cases/day_fixtures_usecase.dart';
import 'package:resultizer_merged/features/home/domain/repositories/soccer_repository.dart';
import 'package:resultizer_merged/features/home/domain/use_cases/favourite_league_usecase.dart';
import 'package:resultizer_merged/features/home/domain/use_cases/favourite_matches_usecase.dart';
import 'package:resultizer_merged/features/home/domain/use_cases/favourite_teams_usecase.dart';
import 'package:resultizer_merged/features/home/domain/use_cases/fixture_detail_usecase.dart';
import 'package:resultizer_merged/features/home/domain/use_cases/live_fixtures_usecase.dart';
import 'package:resultizer_merged/features/home/domain/use_cases/team_fixtures_usecase.dart';
import 'package:resultizer_merged/features/home/domain/use_cases/team_stats_usecase.dart';
import 'package:resultizer_merged/features/home/presentation/cubit/chat_cubit.dart';
import 'package:resultizer_merged/features/home/presentation/cubit/favourites_cubit.dart';
import 'package:resultizer_merged/features/home/presentation/cubit/soccer_cubit.dart';

void initHome() {
  sl
    ..registerLazySingleton<SoccerDataSource>(
        () => SoccerDataSourceImplementation(dioHelper: sl<DioHelper>()))
    ..registerLazySingleton<FirebaseFavouriteDatasource>(
        () => FirebaseFavouriteDatasource(dioHelper: sl<DioHelper>()))
    ..registerLazySingleton<SoccerRepository>(() =>
        SoccerRepositoryImplementation(
            soccerDataSource: sl<SoccerDataSource>(),
            networkInfo: sl<NetworkInfoImpl>()))
    ..registerLazySingleton<FavouriteRepository>(() =>
        FavouriteRepositoryImplementation(
            favouritesDatasource: sl<FirebaseFavouriteDatasource>(),
            networkInfo: sl<NetworkInfoImpl>()))
    ..registerLazySingleton<DayFixturesUseCase>(
      () => DayFixturesUseCase(soccerRepository: sl<SoccerRepository>()),
    )
    ..registerLazySingleton<PastFixturesUseCase>(
      () => PastFixturesUseCase(soccerRepository: sl<SoccerRepository>()),
    )
    ..registerLazySingleton<LiveGamesUseCase>(
      () => LiveGamesUseCase(soccerRepository: sl<SoccerRepository>()),
    )
    ..registerLazySingleton<FixtureDetailUseCase>(
      () => FixtureDetailUseCase(soccerRepository: sl<SoccerRepository>()),
    )
    ..registerLazySingleton<TeamFixturesUseCase>(
      () => TeamFixturesUseCase(soccerRepository: sl<SoccerRepository>()),
    )
    ..registerLazySingleton<CompetitionFixturesUseCase>(
      () =>
          CompetitionFixturesUseCase(soccerRepository: sl<SoccerRepository>()),
    )
    ..registerLazySingleton<SetFavouriteLeagueUseCase>(
      () => SetFavouriteLeagueUseCase(
          favouriteRepository: sl<FavouriteRepository>()),
    )
    ..registerLazySingleton<GetFavouriteLeagueUseCase>(
      () => GetFavouriteLeagueUseCase(
          favouriteRepository: sl<FavouriteRepository>()),
    )
    ..registerLazySingleton<SetFavouriteTeamsUseCase>(
      () => SetFavouriteTeamsUseCase(
          favouriteRepository: sl<FavouriteRepository>()),
    )
    ..registerLazySingleton<GetFavouriteTeamsUseCase>(
      () => GetFavouriteTeamsUseCase(
          favouriteRepository: sl<FavouriteRepository>()),
    )
    ..registerLazySingleton<RemoveFavouriteLeagueUseCase>(
      () => RemoveFavouriteLeagueUseCase(
          favouriteRepository: sl<FavouriteRepository>()),
    )
    ..registerLazySingleton<RemoveFavouriteTeamsUseCase>(
      () => RemoveFavouriteTeamsUseCase(
          favouriteRepository: sl<FavouriteRepository>()),
    )
    //
    ..registerLazySingleton<SetFavouriteMatchesUseCase>(
      () => SetFavouriteMatchesUseCase(
          favouriteRepository: sl<FavouriteRepository>()),
    )
    ..registerLazySingleton<GetFavouriteMatchesUseCase>(
      () => GetFavouriteMatchesUseCase(
          favouriteRepository: sl<FavouriteRepository>()),
    )
    ..registerLazySingleton<RemoveFavouriteMatchesUseCase>(
      () => RemoveFavouriteMatchesUseCase(
          favouriteRepository: sl<FavouriteRepository>()),
    )
    ..registerLazySingleton<TeamStatsUseCase>(
      () => TeamStatsUseCase(
          soccerRepository: sl<SoccerRepository>()),
    )
    //
    ..registerLazySingleton<SoccerCubit>(() => SoccerCubit(
          sl<DayFixturesUseCase>(),
          sl<TeamFixturesUseCase>(),
          sl<CompetitionFixturesUseCase>(),
          sl<TeamStatsUseCase>(),
          sl<PastFixturesUseCase>(),
        ))
    ..registerLazySingleton<FavouritesCubit>(() => FavouritesCubit(
          setFavouriteTeamsUseCase: sl<SetFavouriteTeamsUseCase>(),
          getFavouriteTeamsUseCase: sl<GetFavouriteTeamsUseCase>(),
          setFavouriteLeagueUseCase: sl<SetFavouriteLeagueUseCase>(),
          getFavouriteLeagueUseCase: sl<GetFavouriteLeagueUseCase>(),
          removeFavouriteTeamsUseCase: sl<RemoveFavouriteTeamsUseCase>(),
          removeFavouriteLeagueUseCase: sl<RemoveFavouriteLeagueUseCase>(),
          setFavouriteMatchesUseCase: sl<SetFavouriteMatchesUseCase>(),
          getFavouriteMatchesUseCase: sl<GetFavouriteMatchesUseCase>(),
          removeFavouriteMatchesUseCase: sl<RemoveFavouriteMatchesUseCase>(),
        ))
    ..registerLazySingleton<ChatCubit>(() => ChatCubit())
  ;
}
