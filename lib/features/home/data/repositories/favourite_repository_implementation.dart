import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:resultizer_merged/core/dto/response_dto.dart';
import 'package:resultizer_merged/core/error/error_handler.dart';
import 'package:resultizer_merged/core/error/error_message_types.dart';
import 'package:resultizer_merged/core/network/network_info.dart';
import 'package:resultizer_merged/features/games/data/model/league_dto.dart';
import 'package:resultizer_merged/features/games/data/model/team_list_item_dto.dart';
import 'package:resultizer_merged/features/home/data/datasources/favourites_datasource.dart';
import 'package:resultizer_merged/features/home/data/models/league_event_dto.dart';
import 'package:resultizer_merged/features/home/data/models/premier_game_dto.dart';
import 'package:resultizer_merged/features/home/domain/repositories/favourite_repository.dart';

class FavouriteRepositoryImplementation implements FavouriteRepository {
  final FirebaseFavouriteDatasource favouritesDatasource;
  final NetworkInfo networkInfo;

  FavouriteRepositoryImplementation({required this.favouritesDatasource, required this.networkInfo});

  @override
  Future<Either<Failure, bool>> setFavouriteTeam(String uid, Map<int, TeamListItemDTO> item) async {
    if (!(await networkInfo.isConnected)) {
      return const Left(
          Failure(code: 00, message: ErrorMessageType.networkConnectError));
    }

    try {
      final result = await favouritesDatasource.setFavouriteTeam(uid, item);
      return Right(result);
    } on DioError catch (error) {
      return Left(ErrorHandler.handle(error).failure);
    }
  }
  @override
  Future<Either<Failure, ResponseDTO<Map<dynamic, dynamic>>>> getFavouriteTeams(String uid) async {
    if (!(await networkInfo.isConnected)) {
      return const Left(
          Failure(code: 00, message: ErrorMessageType.networkConnectError));
    }

    try {
      final result = await favouritesDatasource.getFavouriteTeams(uid);
      return Right(result);
    } on DioError catch (error) {
      return Left(ErrorHandler.handle(error).failure);
    }
  }
  @override
  Future<Either<Failure, bool>> setFavouriteLeagues(String uid, Map<int, LeagueDTO> item) async {
    if (!(await networkInfo.isConnected)) {
      return const Left(
          Failure(code: 00, message: ErrorMessageType.networkConnectError));
    }

    try {
      final result = await favouritesDatasource.setFavouriteLeagues(uid, item);
      return Right(result);
    } on DioError catch (error) {
      return Left(ErrorHandler.handle(error).failure);
    }
  }
  @override
  Future<Either<Failure, ResponseDTO<Map<String, dynamic>>>> getFavouriteLeagues(String uid) async {
    if (!(await networkInfo.isConnected)) {
      return const Left(
          Failure(code: 00, message: ErrorMessageType.networkConnectError));
    }

    try {
      final result = await favouritesDatasource.getFavouriteLeagues(uid);
      return Right(result);
    } on DioError catch (error) {
      return Left(ErrorHandler.handle(error).failure);
    }
  }
  
  @override
  Future<Either<Failure, bool>> removeFavouriteLeague(String uid, int leagueId) async {
    if (!(await networkInfo.isConnected)) {
      return const Left(
          Failure(code: 00, message: ErrorMessageType.networkConnectError));
    }

    try {
      final result = await favouritesDatasource.removeFavouriteLeague(uid, leagueId);
      return Right(result);
    } on DioError catch (error) {
      return Left(ErrorHandler.handle(error).failure);
    }
  }
  
  @override
  Future<Either<Failure, bool>> removeFavouriteTeam(String uid, int teamId) async {
    if (!(await networkInfo.isConnected)) {
      return const Left(
          Failure(code: 00, message: ErrorMessageType.networkConnectError));
    }

    try {
      final result = await favouritesDatasource.removeFavouriteTeam(uid, teamId);
      return Right(result);
    } on DioError catch (error) {
      return Left(ErrorHandler.handle(error).failure);
    }
  }

  @override
  Future<Either<Failure, ResponseDTO<Map<String, dynamic>>>> getFavouriteMatches(String uid) async {
    if (!(await networkInfo.isConnected)) {
      return const Left(
          Failure(code: 00, message: ErrorMessageType.networkConnectError));
    }

    try {
      final result = await favouritesDatasource.getFavouriteMatches(uid);
      return Right(result);
    } on DioError catch (error, stackTrace) {
      print(stackTrace);
      return Left(ErrorHandler.handle(error).failure);
    }
  }

  @override
  Future<Either<Failure, bool>> removeFavouriteMatch(String uid, int id) async {
    if (!(await networkInfo.isConnected)) {
      return const Left(
          Failure(code: 00, message: ErrorMessageType.networkConnectError));
    }

    try {
      final result = await favouritesDatasource.removeFavouriteTeam(uid, id);
      return Right(result);
    } on DioError catch (error) {
      return Left(ErrorHandler.handle(error).failure);
    }
  }

  @override
  Future<Either<Failure, bool>> setFavouriteMatch(String uid, Map<int, LeagueEventDTO> item) async {
    if (!(await networkInfo.isConnected)) {
      return const Left(
          Failure(code: 00, message: ErrorMessageType.networkConnectError));
    }

    try {
      final result = await favouritesDatasource.setFavouriteMatch(uid, item);
      return Right(result);
    } on DioError catch (error) {
      return Left(ErrorHandler.handle(error).failure);
    }
  }
}
