import 'dart:ffi';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/widgets.dart';
import 'package:resultizer_merged/core/error/error_handler.dart';
import 'package:resultizer_merged/features/home/data/models/bet_model_dto.dart';
import 'package:resultizer_merged/features/home/data/models/events_dto.dart';
import 'package:resultizer_merged/features/home/data/models/fixture_model_dto.dart';
import 'package:resultizer_merged/features/home/data/models/league_event_dto.dart';
import 'package:resultizer_merged/features/home/data/models/lineup_dto.dart';
import 'package:resultizer_merged/features/home/data/models/statistics_dto.dart';
import 'package:resultizer_merged/features/home/domain/use_cases/fixture_detail_usecase.dart';
// import '../../domain/use_cases/events_usecase.dart';
// import '../../domain/use_cases/lineups_usecase.dart';
// import '../../domain/entities/events.dart';
// import '../../domain/entities/lineups.dart';
// import '../../domain/entities/statistics.dart';
// import '../../domain/use_cases/statistics_usecase.dart';

part 'fixture_state.dart';

class FixtureCubit extends Cubit<FixtureState> {
  final FixtureDetailUseCase fixtureDetailUseCase;

  FixtureCubit({required this.fixtureDetailUseCase}) : super(FixtureInitial());

  List<StatisticsModel> statistics = [];

  Future<void> getStatistics(int fixtureId) async {
    statistics = [];
    if (statistics.isEmpty) {
      emit(FixtureStatisticsLoading());
      final result = await getData(fixtureId);
      result.fold(
        (left) {
          emit(FixtureStatisticsLoadingFailure(message: left.message));
        },
        (right) {
          setData(right[0]);
          emit(FixtureStatisticsLoaded(statistics: right[0].statistics!));
        },
      );
    } else {
      emit(FixtureStatisticsLoaded(statistics: statistics));
    }
  }

  List<Lineup> lineups = [];
  // List<dynamic> lineups = [];

  Future<void> getLineups(int fixtureId) async {
    if (lineups.isEmpty) {
      emit(FixtureLineupsLoading());
      final result = await getData(fixtureId);
      result.fold(
        (left) => emit(FixtureLineupsLoadingFailure(message: left.message)),
        (right) {
          // lineups = right;
          setData(right[0]);
          emit(FixtureLineupsLoaded(lineups: right[0].lineups!));
        },
      );
    } else {
      emit(FixtureLineupsLoaded(lineups: lineups));
    }
  }

  // FullFixtureModel? fixture;
  List<EventModel> events = [];

  Future<void> getEvents(int fixtureId) async {
    if (events.isEmpty) {
      emit(FixtureEventsLoading());
      final result = await getData(fixtureId);
      result.fold(
        (left) {
          emit(FixtureEventsLoadingFailure(message: left.message));
        },
        (right) {
          // fixture = right[0];
          setData(right[0]);
          emit(FixtureEventsLoaded(events: right[0].events!));
        },
      );
      
    } else {
      emit(FixtureEventsLoaded(events: events));
    }
  }

  Future<Either<Failure, List<FullFixtureModel>>> getData(int fixtureId) async {
    final result = await fixtureDetailUseCase(fixtureId);
    return result;   
  }

  // bool oddsBarActive = false;
  void emitOddsBar() {
    // oddsBarActive = !oddsBarActive;
    emit(FixtureOddsActive(status: true));
  }

  void setData(FullFixtureModel payload) {
    if (payload.events != null) events = payload.events!;
    statistics = payload.statistics!;
    lineups = payload.lineups!;
  }

  void reset() {
    events = [];
    statistics = [];
    lineups = [];
  }

  
}
