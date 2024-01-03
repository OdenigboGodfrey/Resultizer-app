import 'package:resultizer_merged/features/home/data/models/bet_model_dto.dart';
import 'package:resultizer_merged/features/home/data/models/events_dto.dart';
import 'package:resultizer_merged/features/home/data/models/lineup_dto.dart';
import 'package:resultizer_merged/features/home/data/models/statistics_dto.dart';
class FixtureModel {
  final int id;
  final Status status;
  final String? date;
  FixtureModel({required this.id,
    required this.status, this.date});

    factory FixtureModel.fromJson(Map<String, dynamic> json) {
    return FixtureModel(
      id: json['id'],
      status: Status.fromJson(json['status']),
      date: json['date']
    );
  }
}

class FullFixtureModel {
  final FixtureModel fixture;
  // final Status status;
  final League league;
  final Teams teams;
  final StatusDetails? statusDetails;
  final DateTime? update;
  final List<OddsModel> odds;
  final List<EventModel>? events;
  List<StatisticsModel>? statistics;
  List<Lineup>? lineups;
  Goals? goals;

  FullFixtureModel({
    // required this.id,
    required this.fixture,
    required this.league,
    required this.teams,
    this.statusDetails,
    this.update,
    required this.odds,
    this.events,
    this.statistics,
    this.lineups,
    this.goals,
  });

  factory FullFixtureModel.fromJson(Map<String, dynamic> json) {
    List<dynamic> dynamicList = [];
    List<OddsModel> odds = [];
    if (json.containsKey('odds')) {
      dynamicList = json['odds'];
      odds = dynamicList.map((value) => OddsModel.fromJson(value)).toList();
    }
    
    // List<OddsModel> odds = oddsList.map((value) => OddsModel.fromJson(value)).toList();
    List<EventModel> eventList = [];
    if (json.containsKey('events')) {
      dynamicList = json['events'];
      eventList = dynamicList.map((e) => EventModel.fromJson(e)).toList();
    }
    
    List<StatisticsModel> statisticsList = [];
    if (json.containsKey('statistics')) {
      dynamicList = json['statistics'];
      statisticsList = dynamicList.map((e) => StatisticsModel.fromJson(e)).toList();
    }

    List<Lineup> lineups = [];
    if (json.containsKey('lineups')) {
      dynamicList = json['lineups'];
      lineups = dynamicList.map((value) => Lineup.fromJson(value)).toList();
    }

    Goals goals = Goals(away: '0', home: '0');
    if (json.containsKey('goals')) goals = Goals.fromJson(json['goals']);
    

    return FullFixtureModel(
      // id: json['id'],
      // status: Status.fromJson(json['status']),
      fixture: FixtureModel.fromJson(json['fixture']),
      league: League.fromJson(json['league']),
      teams: Teams.fromJson(json['teams']),
      statusDetails: json['status'] != null ? StatusDetails.fromJson(json['status']) : null,
      update: json['update'] != null ? DateTime.parse(json['update']) : null,
      odds: odds,
      events: eventList,
      statistics: statisticsList,
      lineups: lineups,
      goals: goals,
    );
  }
}

class Goals {
  final String home;
  final String away;

  Goals({
    required this.home,
    required this.away,
  });

  factory Goals.fromJson(Map<String, dynamic> json) {
    return Goals(
      home: json['home'].toString() ?? '0',
      away: json['away'].toString() ?? '0',
    );
  }
}

class Status {
  final String long;
  final int elapsed;
  final String seconds;
  final String? short;

  Status({
    required this.long,
    required this.elapsed,
    required this.seconds,
    this.short,
  });

  factory Status.fromJson(Map<String, dynamic> json) {
    return Status(
      long: json['long'] ?? '',
      elapsed: json['elapsed'] ?? 0,
      seconds: json['seconds'] ?? '',
      short: json['short'] ?? '',
    );
  }
}

class League {
  final int id;
  final int season;

  League({
    required this.id,
    required this.season,
  });

  factory League.fromJson(Map<String, dynamic> json) {
    return League(
      id: json['id'],
      season: json['season'],
    );
  }
}

class Teams {
  final Team home;
  final Team away;

  Teams({
    required this.home,
    required this.away,
  });

  factory Teams.fromJson(Map<String, dynamic> json) {
    return Teams(
      home: Team.fromJson(json['home']),
      away: Team.fromJson(json['away']),
    );
  }
}

class Team {
  final int id;
  final int goals;

  String? logo;

  String? name;

  Team({
    required this.id,
    required this.goals,
    this.logo,
    this.name,
  });

  factory Team.fromJson(Map<String, dynamic> json) {
    return Team(
      id: json['id'],
      goals: json['goals'] ?? 0,
      logo: json['logo'],
      name: json['name'],
    );
  }
}

class StatusDetails {
  final bool stopped;
  final bool blocked;
  final bool finished;

  StatusDetails({
    required this.stopped,
    required this.blocked,
    required this.finished,
  });

  factory StatusDetails.fromJson(Map<String, dynamic> json) {
    return StatusDetails(
      stopped: json['stopped'] ?? false,
      blocked: json['blocked'] ?? false,
      finished: json['finished'] ?? false,
    );
  }
}

class ApiResponse {
  final String get;
  final Map<String, dynamic> parameters;
  final List<dynamic> errors;
  final int results;
  final Map<String, dynamic> paging;
  // final List<OddsModel> bets;
  final List<FullFixtureModel> response;

  ApiResponse({
    required this.get,
    required this.parameters,
    required this.errors,
    required this.results,
    required this.paging,
    // required this.bets,
    required this.response,
  });

  // factory LiveBetsResponse.fromJson(Map<String, dynamic> json) {
  //   return LiveBetsResponse(
  //     get: json['get'],
  //     parameters: Map<String, dynamic>.from(json['parameters']),
  //     errors: List<String>.from(json['errors'].map((x) => x)),
  //     results: json['results'],
  //     paging: Paging.fromJson(json['paging']),
  //     bets: json['response'] != null
  //         ? (json['response'] as List<dynamic>)
  //         .map((e) => Bet.fromJson(e as Map<String, dynamic>))
  //         .toList()
  //         : [],
  //   );
  // }
}