import 'package:dartz/dartz.dart';
import 'package:resultizer_merged/core/error/error_handler.dart';
import 'package:resultizer_merged/core/usecase/usecase.dart';
import 'package:resultizer_merged/features/home/data/models/league_event_dto.dart';
import 'package:resultizer_merged/features/home/domain/repositories/soccer_repository.dart';

class TeamFixturesUseCase implements UseCase<List<LeagueEventDTO>, int> {
  final SoccerRepository soccerRepository;

  TeamFixturesUseCase({required this.soccerRepository});
  
  @override
  Future<Either<Failure, List<LeagueEventDTO>>> call(int teamId) async {
    return await soccerRepository.getMatchByTeam(teamId);
  }
}