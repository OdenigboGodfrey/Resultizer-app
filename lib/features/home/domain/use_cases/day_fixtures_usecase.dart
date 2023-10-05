import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:resultizer_merged/core/error/error_handler.dart';
import 'package:resultizer_merged/core/usecase/usecase.dart';
import 'package:resultizer_merged/features/home/domain/repositories/soccer_repository.dart';

class DayFixturesUseCase implements UseCase<List<dynamic>, String> {
  final SoccerRepository soccerRepository;

  DayFixturesUseCase({required this.soccerRepository});
  
  @override
  Future<Either<Failure, List<dynamic>>> call(String date) async {
    return await soccerRepository.getDayFixtures(date: date);
  }
}