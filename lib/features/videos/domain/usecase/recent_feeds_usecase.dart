import 'package:dartz/dartz.dart';
import 'package:resultizer_merged/core/error/error_handler.dart';
import 'package:resultizer_merged/core/usecase/usecase.dart';
import 'package:resultizer_merged/features/videos/data/model/scorebat_model_dto.dart';
import 'package:resultizer_merged/features/videos/domain/repositories/recent_feeds_repository.dart';

class RecentFeedsUseCase implements UseCase<List<ScorebatVideoModel>, NoParams> {
  final ScorebatRepository scorebatRepository;

  RecentFeedsUseCase({required this.scorebatRepository});
  
  @override
  Future<Either<Failure, List<ScorebatVideoModel>>> call(NoParams params) async {
    return await scorebatRepository.getRecentFeeds();
  }
}