import 'package:resultizer_merged/container_injector.dart';
import 'package:resultizer_merged/core/api/dio_helper.dart';
import 'package:resultizer_merged/core/network/network_info.dart';
import 'package:resultizer_merged/features/videos/data/datasource/scorebat_hightligt_datasource.dart';
import 'package:resultizer_merged/features/videos/data/repositories/recent_feeds_repository.dart';
import 'package:resultizer_merged/features/videos/domain/repositories/recent_feeds_repository.dart';
import 'package:resultizer_merged/features/videos/domain/usecase/highlights_by_competiton.dart';
import 'package:resultizer_merged/features/videos/domain/usecase/highlights_by_team.dart';
import 'package:resultizer_merged/features/videos/domain/usecase/list_competitons.dart';
import 'package:resultizer_merged/features/videos/domain/usecase/list_teams.dart';
import 'package:resultizer_merged/features/videos/domain/usecase/recent_feeds_usecase.dart';
import 'package:resultizer_merged/features/videos/presentation/cubic/video_cubit.dart';

void initVideos() {
  sl
  ..registerLazySingleton<RecentFeedsDataSource>(() => RecentFeedsDataSourceImplementation(dioHelper: sl<DioHelper>()))
  ..registerLazySingleton<ScorebatRepository>(() => ScorebatRepositoryImplementation(
        recentFeedsDataSource: sl<RecentFeedsDataSource>(), networkInfo: sl<NetworkInfoImpl>()))
  ..registerLazySingleton<RecentFeedsUseCase>(
      () => RecentFeedsUseCase(scorebatRepository:  sl<ScorebatRepository>(),),
    )
    ..registerLazySingleton<HighlightByTeamUseCase>(
      () => HighlightByTeamUseCase(scorebatRepository:  sl<ScorebatRepository>(),),
    )
    ..registerLazySingleton<HighlightByCompetitionUseCase>(
      () => HighlightByCompetitionUseCase(scorebatRepository:  sl<ScorebatRepository>(),),
    )
    ..registerLazySingleton<ListTeamsUseCase>(
      () => ListTeamsUseCase(scorebatRepository:  sl<ScorebatRepository>(),),
    )
    ..registerLazySingleton<ListCompetitionUseCase>(
      () => ListCompetitionUseCase(scorebatRepository:  sl<ScorebatRepository>(),),
    )
  ..registerLazySingleton<ScorebatCubit>(
      () => ScorebatCubit(
          sl<RecentFeedsUseCase>(),
          sl<HighlightByCompetitionUseCase>(),
          sl<HighlightByTeamUseCase>(),
          sl<ListTeamsUseCase>(),
          sl<ListCompetitionUseCase>(),
    ));
}