import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:resultizer_merged/core/error/error_handler.dart';
import 'package:resultizer_merged/core/usecase/usecase.dart';
import 'package:resultizer_merged/features/home/domain/repositories/soccer_repository.dart';

class LiveGamesUseCase implements UseCase<List<dynamic>, NoParams> {
  final SoccerRepository soccerRepository;

  LiveGamesUseCase({required this.soccerRepository});
  
  @override
  Future<Either<Failure, List<dynamic>>> call(NoParams params) async {
    return await soccerRepository.getLiveFootballMatches();
  }
}