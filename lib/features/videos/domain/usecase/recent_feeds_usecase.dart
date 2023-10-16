import 'package:dartz/dartz.dart';
import 'package:resultizer_merged/core/error/error_handler.dart';
import 'package:resultizer_merged/core/usecase/usecase.dart';
import 'package:resultizer_merged/features/videos/data/model/recent_feeds_dto.dart';
import 'package:resultizer_merged/features/videos/domain/repositories/recent_feeds_repository.dart';

class RecentFeedsUseCase implements UseCase<List<RecentFeedsModel>, NoParams> {
  final RecentFeedsRepository recentFeedsRepository;

  RecentFeedsUseCase({required this.recentFeedsRepository});
  
  @override
  Future<Either<Failure, List<RecentFeedsModel>>> call(NoParams params) async {
    return await recentFeedsRepository.getRecentFeeds();
  }
}