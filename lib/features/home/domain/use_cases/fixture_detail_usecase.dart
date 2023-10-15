import 'package:dartz/dartz.dart';
import 'package:resultizer_merged/core/error/error_handler.dart';
import 'package:resultizer_merged/core/usecase/usecase.dart';
import 'package:resultizer_merged/features/home/data/models/fixture_model_dto.dart';
import 'package:resultizer_merged/features/home/domain/repositories/soccer_repository.dart';

class FixtureDetailUseCase implements UseCase<List<dynamic>, int> {
  final SoccerRepository soccerRepository;

  FixtureDetailUseCase({required this.soccerRepository});
  
  @override
  Future<Either<Failure, List<FullFixtureModel>>> call(int fixtureId) async {
    return await soccerRepository.getMatchInfoByFixtureId(fixtureId: fixtureId);
  }
}