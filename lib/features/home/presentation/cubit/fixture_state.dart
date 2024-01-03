part of 'fixture_cubit.dart';

@immutable
abstract class FixtureState {}

class FixtureInitial extends FixtureState {}

class FixtureChangeBar extends FixtureState {}

class FixtureStatisticsLoading extends FixtureState {}

class FixtureStatisticsLoaded extends FixtureState {
  // final List<Statistics> statistics;
  final List<dynamic> statistics;

  FixtureStatisticsLoaded({required this.statistics});
}

class FixtureStatisticsLoadingFailure extends FixtureState {
  final String message;

  FixtureStatisticsLoadingFailure({required this.message});
}

class FixtureLineupsLoading extends FixtureState {}

class FixtureLineupsLoaded extends FixtureState {
  // final List<Lineup> lineups;
  final List<dynamic> lineups;

  FixtureLineupsLoaded({required this.lineups});
}

class FixtureLineupsLoadingFailure extends FixtureState {
  final String message;

  FixtureLineupsLoadingFailure({required this.message});
}

class FixtureEventsLoading extends FixtureState {}

class FixtureEventsLoaded extends FixtureState {
  // final List<Event> events;
  final List<dynamic> events;

  FixtureEventsLoaded({required this.events});
}

class FixtureEventsLoadingFailure extends FixtureState {
  final String message;

  FixtureEventsLoadingFailure({required this.message});
}


class FixtureOddsLoading extends FixtureState {}

class FixtureOddsActive extends FixtureState {
  final bool status;

  FixtureOddsActive({required this.status});
}

class FixtureOddsLoaded extends FixtureState {
  final List<OddsModel> odds;
  // final List<dynamic> events;

  FixtureOddsLoaded({required this.odds});
}

class FixtureOddsLoadingFailure extends FixtureState {
  final String message;

  FixtureOddsLoadingFailure({required this.message});
}


class FixtureChatLoading extends FixtureState {}

class FixtureChatActive extends FixtureState {
  final bool status;

  FixtureChatActive({required this.status});
}
class FixtureChatLoaded extends FixtureState {
  final List<OddsModel> odds;
  // final List<dynamic> events;

  FixtureChatLoaded({required this.odds});
}
class FixtureChatLoadingFailure extends FixtureState {
  final String message;

  FixtureChatLoadingFailure({required this.message});
}

class FixtureTeamStatsActive extends FixtureState {
  final bool status;

  FixtureTeamStatsActive({required this.status});
}