import 'package:dartz/dartz.dart';
import 'package:resultizer_merged/core/error/error_handler.dart';
import 'package:resultizer_merged/core/error/error_message_types.dart';
import 'package:resultizer_merged/core/error/response_status.dart';
import 'package:resultizer_merged/core/network/network_info.dart';
import 'package:resultizer_merged/features/home/data/datasources/soccer_datasource.dart';
import 'package:resultizer_merged/features/home/data/models/fixture_model_dto.dart';
import 'package:resultizer_merged/features/home/domain/repositories/soccer_repository.dart';
import 'package:dio/src/dio_error.dart';

class SoccerRepositoryImplementation implements SoccerRepository {
  final SoccerDataSource soccerDataSource;
  final NetworkInfo networkInfo;

  SoccerRepositoryImplementation(
      {required this.soccerDataSource, required this.networkInfo});

  @override
  Future<Either<Failure, List>> getDayFixtures({required String date}) async {
    if (!(await networkInfo.isConnected)) {
      return const Left(
          Failure(code: 00, message: ErrorMessageType.networkConnectError));
    }

    try {
      final result = await soccerDataSource.getDayFixtures(date: date);
      return Right(result);
    } on DioError catch (error) {
      return Left(ErrorHandler.handle(error).failure);
    }
  }

  @override
  Future<Either<Failure, List>> getLiveFootballMatches() async {
    if (!(await networkInfo.isConnected)) {
      return const Left(
          Failure(code: 00, message: ErrorMessageType.networkConnectError));
    }
    try {
      final result = await soccerDataSource.getLiveFootballMatches();

      return Right(result);
    } catch (error, stackTrace) {
      print(stackTrace);
      return Left(ErrorHandler.handle(error).failure);
    }
  }

  @override
  Future<Either<Failure, List>> getMatchByFixtureId(
      {required int fixtureId}) async {
    if (!(await networkInfo.isConnected)) {
      return const Left(
          Failure(code: 00, message: ErrorMessageType.networkConnectError));
    }
    try {
      final result = await soccerDataSource.getMatchByFixtureId(fixtureId);
      if (result != null) return Right(result);
      return const Left(
          Failure(code: 00, message: ErrorMessageType.noDataFound));
    } catch (error, stackTrace) {
      print(stackTrace);
      return Left(ErrorHandler.handle(error).failure);
    }
  }

  @override
  Future<Either<Failure, List<FullFixtureModel>>> getMatchInfoByFixtureId(
      {required int fixtureId}) async {
    if (!(await networkInfo.isConnected)) {
      return const Left(
          Failure(code: 00, message: ErrorMessageType.networkConnectError));
    }
    try {
      final result = await soccerDataSource.getMatchInfoByFixtureId(fixtureId);
      if (result.isNotEmpty) {
        return Right(result);
      }
      return const Left(
          Failure(code: 00, message: ErrorMessageType.noDataFound));
    } catch (error, stackTrace) {
      print(stackTrace);
      return Left(ErrorHandler.handle(error).failure);
    }
  }
}
