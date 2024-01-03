import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:resultizer_merged/core/error/error_handler.dart';
import 'package:resultizer_merged/core/error/error_message_types.dart';
import 'package:resultizer_merged/core/network/network_info.dart';
import 'package:resultizer_merged/features/videos/data/datasource/scorebat_hightligt_datasource.dart';
import 'package:resultizer_merged/features/videos/data/model/scorebat_model_dto.dart';
import 'package:resultizer_merged/features/videos/domain/repositories/recent_feeds_repository.dart';

class ScorebatRepositoryImplementation implements ScorebatRepository {
  final RecentFeedsDataSource recentFeedsDataSource;
  final NetworkInfo networkInfo;

  ScorebatRepositoryImplementation({required this.recentFeedsDataSource, required this.networkInfo});

  @override
  Future<Either<Failure, List<ScorebatVideoModel>>> getRecentFeeds() async {
    if (!(await networkInfo.isConnected)) {
      return const Left(
          Failure(code: 00, message: ErrorMessageType.networkConnectError));
    }

    try {
      final result = await recentFeedsDataSource.getRecentFeeds();
      return Right(result);
    } on DioError catch (error) {
      return Left(ErrorHandler.handle(error).failure);
    }
  }
  
  @override
  Future<Either<Failure, List<ScorebatVideoModel>>> getHighlightsByCompetition(String competition) async {
    if (!(await networkInfo.isConnected)) {
      return const Left(
          Failure(code: 00, message: ErrorMessageType.networkConnectError));
    }

    try {
      final result = await recentFeedsDataSource.getHighlightsByCompetition(competition);
      return Right(result);
    } on DioError catch (error) {
      return Left(ErrorHandler.handle(error).failure);
    }
  }
  
  @override
  Future<Either<Failure, List<ScorebatVideoModel>>> getHighlightsByTeam(String team) async {
    if (!(await networkInfo.isConnected)) {
      return const Left(
          Failure(code: 00, message: ErrorMessageType.networkConnectError));
    }

    try {
      final result = await recentFeedsDataSource.getHighlightsByTeam(team);
      return Right(result);
    } on DioError catch (error) {
      return Left(ErrorHandler.handle(error).failure);
    }
  }
  
  @override
  Future<Either<Failure, List<Map>>> getCompetitions() async {
    if (!(await networkInfo.isConnected)) {
      return const Left(
          Failure(code: 00, message: ErrorMessageType.networkConnectError));
    }

    try {
      final result = await recentFeedsDataSource.getCompetitions();
      return Right(result);
    } on DioError catch (error) {
      return Left(ErrorHandler.handle(error).failure);
    }
  }
  
  @override
  Future<Either<Failure, List<Map>>> getTeams() async {
    if (!(await networkInfo.isConnected)) {
      return const Left(
          Failure(code: 00, message: ErrorMessageType.networkConnectError));
    }

    try {
      final result = await recentFeedsDataSource.getTeams();
      return Right(result);
    } on DioError catch (error) {
      return Left(ErrorHandler.handle(error).failure);
    }
  }
}