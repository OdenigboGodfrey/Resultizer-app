import 'package:dartz/dartz.dart';
import 'package:resultizer_merged/core/error/error_handler.dart';
import 'package:resultizer_merged/core/usecase/usecase.dart';
import 'package:resultizer_merged/features/home/domain/repositories/soccer_repository.dart';

class TeamStatsParam {
  final int teamId;
  final int leagueId;

  TeamStatsParam(this.teamId, this.leagueId);
}


class TeamStatsUseCase implements UseCase<dynamic, TeamStatsParam> {
  final SoccerRepository soccerRepository;

  TeamStatsUseCase({required this.soccerRepository});
  
  @override
  Future<Either<Failure, dynamic>> call(TeamStatsParam params) async {
    return await soccerRepository.getTeamStatistic(params.teamId, params.leagueId);
  }
}