import 'package:dartz/dartz.dart';
import 'package:resultizer_merged/core/error/error_handler.dart';
import 'package:resultizer_merged/core/usecase/usecase.dart';
import 'package:resultizer_merged/features/games/data/model/league_dto.dart';
import 'package:resultizer_merged/features/games/domain/repositories/leagues_repository.dart';
import 'package:resultizer_merged/features/home/data/models/league_event_dto.dart';
import 'package:resultizer_merged/features/home/domain/repositories/soccer_repository.dart';

class LeagueUseCase implements UseCase<List<LeagueDTO>, NoParams> {
  final LeaguesRepository leaguesRepository;

  LeagueUseCase({required this.leaguesRepository});
  
  @override
  Future<Either<Failure, List<LeagueDTO>>> call(NoParams noParams) async {
    return await leaguesRepository.getLeagues();
  }
}