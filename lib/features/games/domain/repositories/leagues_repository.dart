import 'package:dartz/dartz.dart';
import 'package:resultizer_merged/core/error/error_handler.dart';
import 'package:resultizer_merged/features/games/data/model/league_dto.dart';

abstract class LeaguesRepository {
  Future<Either<Failure, List<LeagueDTO>>> getLeagues();
}
