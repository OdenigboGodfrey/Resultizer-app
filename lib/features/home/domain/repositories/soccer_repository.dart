import 'package:dartz/dartz.dart';
import 'package:resultizer_merged/core/error/error_handler.dart';

abstract class SoccerRepository {

  Future<Either<Failure, List<dynamic>>> getDayFixtures({
    required String date,
  });

  Future<Either<Failure, List<dynamic>>> getLiveFootballMatches();

  Future<Either<Failure, List<dynamic>>> getMatchByFixtureId({
    required int fixtureId,
  });

  

  //Future<Either<Failure, List<SoccerFixture>>> getLiveFixtures();
}
