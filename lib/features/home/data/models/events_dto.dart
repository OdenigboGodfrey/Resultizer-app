import 'package:resultizer_merged/features/home/data/models/assist_dto.dart';
import 'package:resultizer_merged/features/home/data/models/fixture_teams_dto.dart';
import 'package:resultizer_merged/features/home/data/models/players_dto.dart';

class EventModel {
  final EventTime time;
  final FixtureTeam team;
  final PlayerModel player;
  final AssistModel assist;
  final String type;
  final String detail;

  const EventModel({
    required this.time,
    required this.team,
    required this.player,
    required this.assist,
    required this.type,
    required this.detail,
  });

  factory EventModel.fromJson(Map<String, dynamic> json) {
    return EventModel(
      time: EventTime.fromJson(json['time']),
      team: FixtureTeam.fromJson(json['team']),
      player: PlayerModel.fromJson(json['player']),
      assist: AssistModel.fromJson(json['assist']),
      type: json['type'], 
      detail: json['detail'],
    );
  }
}

class EventTime {
  final int elapsed;
  final int? extra;

  EventTime({required this.elapsed, required this.extra});

  factory EventTime.fromJson(Map<String, dynamic> json) {
    return EventTime(
      elapsed: json['elapsed'],
      extra: json['extra'],
    );
  }
}
