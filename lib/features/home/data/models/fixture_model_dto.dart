import 'package:resultizer_merged/features/home/data/models/bet_model_dto.dart';
class FixtureModel {
  final int id;
  final Status status;
  FixtureModel({required this.id,
    required this.status,});

    factory FixtureModel.fromJson(Map<String, dynamic> json) {
    return FixtureModel(
      id: json['id'],
      status: Status.fromJson(json['status']),
    );
  }
}

class FullFixtureModel {
  final FixtureModel fixture;
  // final Status status;
  final League league;
  final Teams teams;
  final StatusDetails statusDetails;
  final DateTime update;
  final List<OddsModel> odds;

  FullFixtureModel({
    // required this.id,
    required this.fixture,
    required this.league,
    required this.teams,
    required this.statusDetails,
    required this.update,
    required this.odds,
  });

  factory FullFixtureModel.fromJson(Map<String, dynamic> json) {
    List<dynamic> oddsList = json['odds'];
    List<OddsModel> odds = oddsList.map((value) => OddsModel.fromJson(value)).toList();
    print('odds json');
    print('${odds[0].toJson()}');

    return FullFixtureModel(
      // id: json['id'],
      // status: Status.fromJson(json['status']),
      fixture: FixtureModel.fromJson(json['fixture']),
      league: League.fromJson(json['league']),
      teams: Teams.fromJson(json['teams']),
      statusDetails: StatusDetails.fromJson(json['status']),
      update: DateTime.parse(json['update']),
      odds: odds,
    );
  }
}

class Status {
  final String long;
  final int elapsed;
  final String seconds;

  Status({
    required this.long,
    required this.elapsed,
    required this.seconds,
  });

  factory Status.fromJson(Map<String, dynamic> json) {
    return Status(
      long: json['long'],
      elapsed: json['elapsed'],
      seconds: json['seconds'],
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
      goals: json['goals'],
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
      stopped: json['stopped'],
      blocked: json['blocked'],
      finished: json['finished'],
    );
  }
}

class LiveBetsResponse {
  final String get;
  final Map<String, dynamic> parameters;
  final List<dynamic> errors;
  final int results;
  final Map<String, dynamic> paging;
  // final List<OddsModel> bets;
  final List<FullFixtureModel> response;

  LiveBetsResponse({
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