import 'dart:convert';

import 'package:resultizer_merged/features/home/data/models/bet_model_dto.dart';
import 'package:resultizer_merged/features/home/data/models/events_dto.dart';

class PremierGameDTO {
    final String gameTime;
    final dynamic homeLogo;
    final String homeTeam;
    final dynamic awayLogo;
    final String awayTeam;
    final String matchStatus;
    final String? goals;
    List<OddsModel> odds = [];
    final String? gameCurrentTime;
    final String? matchStatusLong;
    final int? fixtureId;
    List<EventModel> events = [];

  PremierGameDTO({required this.gameTime, required this.homeLogo, required this.homeTeam, required this.awayLogo, required this.awayTeam, required this.matchStatus, this.goals, this.gameCurrentTime, this.matchStatusLong, this.fixtureId});

  Map<String, dynamic> toJson() {
    return {
      'gameTime': gameTime,
      'homeLogo': homeLogo,
      'homeTeam': homeTeam,
      'awayLogo': awayLogo,
      'awayTeam': awayTeam,
      'goals': goals,
      // 'odds': odds.map((e) => e.toJson()),
      'odds': jsonEncode(odds),
      'gameCurrentTime': gameCurrentTime,
      'matchStatusLong': matchStatusLong,
      'fixtureId': fixtureId,
    };
  }
}