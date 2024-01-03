import 'package:dartz/dartz.dart';
import 'package:resultizer_merged/core/error/error_handler.dart';
import 'package:resultizer_merged/core/usecase/usecase.dart';
import 'package:resultizer_merged/features/videos/data/model/scorebat_model_dto.dart';
import 'package:resultizer_merged/features/videos/domain/repositories/recent_feeds_repository.dart';

class HighlightByTeamUseCase implements UseCase<List<ScorebatVideoModel>, String> {
  final ScorebatRepository scorebatRepository;

  HighlightByTeamUseCase({required this.scorebatRepository});
  
  @override
  Future<Either<Failure, List<ScorebatVideoModel>>> call(String team) async {
    return await scorebatRepository.getHighlightsByTeam(team);
  }
}