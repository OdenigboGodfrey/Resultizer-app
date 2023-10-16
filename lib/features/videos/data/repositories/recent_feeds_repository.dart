import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:resultizer_merged/core/error/error_handler.dart';
import 'package:resultizer_merged/core/error/error_message_types.dart';
import 'package:resultizer_merged/core/network/network_info.dart';
import 'package:resultizer_merged/features/videos/data/datasource/feeds_datasource.dart';
import 'package:resultizer_merged/features/videos/data/model/recent_feeds_dto.dart';
import 'package:resultizer_merged/features/videos/domain/repositories/recent_feeds_repository.dart';

class RecentFeedsRepositoryImplementation implements RecentFeedsRepository {
  final RecentFeedsDataSource recentFeedsDataSource;
  final NetworkInfo networkInfo;

  RecentFeedsRepositoryImplementation({required this.recentFeedsDataSource, required this.networkInfo});

  @override
  Future<Either<Failure, List<RecentFeedsModel>>> getRecentFeeds() async {
    if (!(await networkInfo.isConnected)) {
      return const Left(
          Failure(code: 00, message: ErrorMessageType.networkConnectError));
    }

    try {
      final result = await recentFeedsDataSource.getRecentFeeds();
      return Right(result);
    } on DioError catch (error) {
      return Left(ErrorHandler.handle(error).failure);
    }
  }
}