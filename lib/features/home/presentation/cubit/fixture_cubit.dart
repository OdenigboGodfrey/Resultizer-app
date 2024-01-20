import 'dart:ffi';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/widgets.dart';
import 'package:resultizer_merged/core/error/error_handler.dart';
import 'package:resultizer_merged/features/home/data/models/bet_model_dto.dart';
import 'package:resultizer_merged/features/home/data/models/events_dto.dart';
import 'package:resultizer_merged/features/home/data/models/fixture_model_dto.dart';
import 'package:resultizer_merged/features/home/data/models/lineup_dto.dart';
import 'package:resultizer_merged/features/home/data/models/premier_game_dto.dart';
import 'package:resultizer_merged/features/home/data/models/statistics_dto.dart';
import 'package:resultizer_merged/features/home/domain/use_cases/fixture_detail_usecase.dart';

part 'fixture_state.dart';

class FixtureCubit extends Cubit<FixtureState> {
  final FixtureDetailUseCase fixtureDetailUseCase;

  FixtureCubit({required this.fixtureDetailUseCase}) : super(FixtureInitial());

  List<StatisticsModel> statistics = [];

  void emitFixtureStatisticsLoaded(List<StatisticsModel> data) {
    // manually control the success emit for fixture stats
    emit(FixtureStatisticsLoaded(statistics: data));
  }

  Future<List<StatisticsModel>> getStatistics(int fixtureId) async {
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
          // emit(FixtureStatisticsLoaded(statistics: right[0].statistics!));
        },
      );
    } else {
      // emit(FixtureStatisticsLoaded(statistics: statistics));
    }
    return statistics;
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

  late FullFixtureModel fixture;
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

  void emitChatBar() {
    emit(FixtureChatActive(status: true));
  }

  void emitTeamStats() {
    emit(FixtureTeamStatsActive(status: true));
  }

  void setData(FullFixtureModel payload) {
    fixture = payload;
    if (payload.events != null) events = payload.events!;
    statistics = payload.statistics!;
    lineups = payload.lineups!;
  }

  void reset() {
    events = [];
    statistics = [];
    lineups = [];
  }

  generatePremierGame() {
    var item = PremierGameDTO(
        gameTime: fixture.fixture.date.toString(),
        homeLogo: fixture.teams.home.logo,
        homeTeam: fixture.teams.home.name!,
        awayLogo: fixture.teams.away.logo,
        awayTeam: fixture.teams.away.name!,
        matchStatus: fixture.fixture.status.short!,
        matchTime: DateTime.parse(fixture.fixture.date!),
        fixtureId: fixture.fixture.id,
        gameCurrentTime: fixture.fixture.status.seconds,
        goals: "${fixture.goals!.home ?? 0}:${fixture.goals!.away ?? 0}",
        matchStatusLong: fixture.fixture.status.long,
        homeTeamId: fixture.teams.home.id,
        awayTeamId: fixture.teams.away.id,
    );
    return item;
  }

  Future<void> getTeamStatistics(int homeTeamId, int awayTeamId) async {
    statistics = [];
    if (statistics.isEmpty) {
      emit(FixtureStatisticsLoading());
      // final result = await getData(fixtureId);
      // result.fold(
      //   (left) {
      //     emit(FixtureStatisticsLoadingFailure(message: left.message));
      //   },
      //   (right) {
      //     setData(right[0]);
      //     emit(FixtureStatisticsLoaded(statistics: right[0].statistics!));
      //   },
      // );
    } else {
      emit(FixtureStatisticsLoaded(statistics: statistics));
    }
  }
}
