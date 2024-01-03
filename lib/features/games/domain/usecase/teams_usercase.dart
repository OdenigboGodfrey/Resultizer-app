import 'package:dartz/dartz.dart';
import 'package:resultizer_merged/core/error/error_handler.dart';
import 'package:resultizer_merged/core/usecase/usecase.dart';
import 'package:resultizer_merged/features/games/data/model/league_dto.dart';
import 'package:resultizer_merged/features/games/data/model/team_list_item_dto.dart';
import 'package:resultizer_merged/features/games/domain/repositories/leagues_repository.dart';
import 'package:resultizer_merged/features/games/domain/repositories/teams_repository.dart';
import 'package:resultizer_merged/features/home/data/models/league_event_dto.dart';
import 'package:resultizer_merged/features/home/domain/repositories/soccer_repository.dart';

class TeamsUseCase implements UseCase<List<TeamListItemDTO>, int> {
  final TeamsRepository teamsRepository;

  TeamsUseCase({required this.teamsRepository});
  
  @override
  Future<Either<Failure, List<TeamListItemDTO>>> call(int leagueId) async {
    return await teamsRepository.getTeams(leagueId);
  }
}