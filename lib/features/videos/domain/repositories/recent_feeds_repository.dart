import 'package:dartz/dartz.dart';
import 'package:resultizer_merged/core/error/error_handler.dart';
import 'package:resultizer_merged/features/videos/data/model/scorebat_model_dto.dart';

abstract class ScorebatRepository {
  Future<Either<Failure, List<ScorebatVideoModel>>> getRecentFeeds();
  Future<Either<Failure, List<ScorebatVideoModel>>> getHighlightsByCompetition(String competition);
  Future<Either<Failure, List<ScorebatVideoModel>>> getHighlightsByTeam(String team);
  Future<Either<Failure, List<Map>>> getTeams();
  Future<Either<Failure, List<Map>>> getCompetitions();
}
