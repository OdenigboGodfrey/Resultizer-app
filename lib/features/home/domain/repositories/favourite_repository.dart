import 'package:dartz/dartz.dart';
import 'package:resultizer_merged/core/dto/response_dto.dart';
import 'package:resultizer_merged/core/error/error_handler.dart';
import 'package:resultizer_merged/features/games/data/model/league_dto.dart';
import 'package:resultizer_merged/features/games/data/model/team_list_item_dto.dart';
import 'package:resultizer_merged/features/home/data/models/league_event_dto.dart';
import 'package:resultizer_merged/features/home/data/models/premier_game_dto.dart';

abstract class FavouriteRepository {

  Future<Either<Failure, bool>> setFavouriteTeam(String uid, Map<int, TeamListItemDTO> item);
  Future<Either<Failure, ResponseDTO<Map<dynamic, dynamic>>>> getFavouriteTeams(String uid);
  Future<Either<Failure, bool>> setFavouriteLeagues(String uid, Map<int, LeagueDTO> item);
  Future<Either<Failure, ResponseDTO<Map<String, dynamic>>>> getFavouriteLeagues(String uid);
  Future<Either<Failure, bool>> removeFavouriteTeam(String uid, int id);
  Future<Either<Failure, bool>> removeFavouriteLeague(String uid, int id);
  Future<Either<Failure, bool>> setFavouriteMatch(String uid, Map<int, LeagueEventDTO> item);
  Future<Either<Failure, ResponseDTO<Map<String, dynamic>>>> getFavouriteMatches(String uid);
  Future<Either<Failure, bool>> removeFavouriteMatch(String uid, int id);
}
