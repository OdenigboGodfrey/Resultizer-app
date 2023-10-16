import 'package:dartz/dartz.dart';
import 'package:resultizer_merged/core/error/error_handler.dart';
import 'package:resultizer_merged/features/videos/data/model/recent_feeds_dto.dart';

abstract class RecentFeedsRepository {
  Future<Either<Failure, List<RecentFeedsModel>>> getRecentFeeds();
}
