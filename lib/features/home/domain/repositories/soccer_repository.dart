import 'package:dartz/dartz.dart';
import 'package:resultizer_merged/core/error/error_handler.dart';
import 'package:resultizer_merged/features/home/data/models/fixture_model_dto.dart';
import 'package:resultizer_merged/features/home/data/models/league_event_dto.dart';

abstract class SoccerRepository {

  Future<Either<Failure, List<dynamic>>> getDayFixtures({
    required String date,
  });

  Future<Either<Failure, List<dynamic>>> getLiveFootballMatches();

  Future<Either<Failure, List<dynamic>>> getMatchByFixtureId({
    required int fixtureId,
  });

  Future<Either<Failure, List<FullFixtureModel>>> getMatchInfoByFixtureId({
    required int fixtureId,
  });
  Future<Either<Failure, List<LeagueEventDTO>>> getMatchByTeam(int teamId);
  Future<Either<Failure, List<LeagueEventDTO>>> getMatchByCompetition(int competitionId);

  

  //Future<Either<Failure, List<SoccerFixture>>> getLiveFixtures();
}
