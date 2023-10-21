import 'package:dartz/dartz.dart';
import 'package:resultizer_merged/core/error/error_handler.dart';
import 'package:resultizer_merged/core/usecase/usecase.dart';
import 'package:resultizer_merged/features/videos/domain/repositories/recent_feeds_repository.dart';

class ListCompetitionUseCase implements UseCase<List<Map>, NoParams> {
  final ScorebatRepository scorebatRepository;

  ListCompetitionUseCase({required this.scorebatRepository});
  
  @override
  Future<Either<Failure, List<Map>>> call(NoParams noParams) async {
    return await scorebatRepository.getCompetitions();
  }
}