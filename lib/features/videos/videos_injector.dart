import 'package:resultizer_merged/container_injector.dart';
import 'package:resultizer_merged/core/api/dio_helper.dart';
import 'package:resultizer_merged/core/network/network_info.dart';
import 'package:resultizer_merged/features/videos/data/datasource/feeds_datasource.dart';
import 'package:resultizer_merged/features/videos/data/repositories/recent_feeds_repository.dart';
import 'package:resultizer_merged/features/videos/domain/repositories/recent_feeds_repository.dart';
import 'package:resultizer_merged/features/videos/domain/usecase/recent_feeds_usecase.dart';
import 'package:resultizer_merged/features/videos/presentation/cubic/video_cubit.dart';

void initVideos() {
  sl
  ..registerLazySingleton<RecentFeedsDataSource>(() => RecentFeedsDataSourceImplementation(dioHelper: sl<DioHelper>()))
  ..registerLazySingleton<RecentFeedsRepository>(() => RecentFeedsRepositoryImplementation(
        recentFeedsDataSource: sl<RecentFeedsDataSource>(), networkInfo: sl<NetworkInfoImpl>()))
  ..registerLazySingleton<RecentFeedsUseCase>(
      () => RecentFeedsUseCase(recentFeedsRepository:  sl<RecentFeedsRepository>(),),
    )
  ..registerLazySingleton<RecentFeedsCubit>(
      () => RecentFeedsCubit(
          sl<RecentFeedsUseCase>(),
    ));
}