import 'package:dartz/dartz.dart';
import 'package:resultizer_merged/core/error/error_handler.dart';
import 'package:resultizer_merged/features/games/data/model/team_list_item_dto.dart';

abstract class TeamsRepository {
  Future<Either<Failure, List<TeamListItemDTO>>> getTeams(int leagueId);
}
