import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:resultizer_merged/core/error/error_handler.dart';
import 'package:resultizer_merged/core/error/error_message_types.dart';
import 'package:resultizer_merged/core/network/network_info.dart';
import 'package:resultizer_merged/features/games/data/datasource/games_datasource.dart';
import 'package:resultizer_merged/features/games/data/model/team_list_item_dto.dart';
import 'package:resultizer_merged/features/games/domain/repositories/teams_repository.dart';

class TeamsRepositoryImplemenatation implements TeamsRepository {
  final FirebaseGamesDatasource gamesDatasource;
  final NetworkInfo networkInfo;

  TeamsRepositoryImplemenatation({required this.gamesDatasource, required this.networkInfo});
  
  @override
  Future<Either<Failure, List<TeamListItemDTO>>> getTeams(int leagueId) async{
    if (!(await networkInfo.isConnected)) {
      return const Left(
          Failure(code: 00, message: ErrorMessageType.networkConnectError));
    }

    try {
      final result = await gamesDatasource.getAllTeams(leagueId);
      return Right(result);
    } on DioError catch (error) {
      return Left(ErrorHandler.handle(error).failure);
    }
  }
}
