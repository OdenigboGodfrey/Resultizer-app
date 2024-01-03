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
  DateTime matchTime;

  final int homeTeamId;
  final int awayTeamId;

  PremierGameDTO( 
      {required this.gameTime,
      required this.homeLogo,
      required this.homeTeam,
      required this.awayLogo,
      required this.awayTeam,
      required this.matchStatus,
      required this.matchTime,
      this.goals,
      this.gameCurrentTime,
      this.matchStatusLong,
      this.fixtureId,
      required this.homeTeamId, required this.awayTeamId,
      });

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
      'matchTime': matchTime.toString(),
      'matchStatus': matchStatus,
      'homeTeamId': homeTeamId,
      'awayTeamId': awayTeamId,
    };
  }

  // factory PremierGameDTO.fromJson(Map<String, dynamic> json) {
  //   return PremierGameDTO(gameTime: gameTime, homeLogo: homeLogo, homeTeam: homeTeam, awayLogo: awayLogo, awayTeam: awayTeam, matchStatus: matchStatus);
  // }

  factory PremierGameDTO.fromAppDbJson(Map<String, dynamic> json) {
    List<dynamic> odds = [];
    
    
    var dto = PremierGameDTO(
        gameTime: json['gameTime'],
        homeLogo: json['homeLogo'],
        homeTeam: json['homeTeam'],
        awayLogo: json['awayLogo'],
        awayTeam: json['awayTeam'],
        matchStatus: json['matchStatus'] ?? '',
        matchTime:  json['matchTime'] != null ? DateTime.parse(json['matchTime']) : DateTime.now(),
        fixtureId:  json['fixtureId'],
        gameCurrentTime:  json['gameCurrentTime'] ?? '',
        goals:  json['goals'] ?? '',
        matchStatusLong:  json['matchStatusLong'] ?? '',
        homeTeamId: json['homeTeamId'],
        awayTeamId: json['awayTeamId'],
    );

    if (json['odds'] != null) {
      odds = jsonDecode(json['odds']);
      dto.odds = odds.map((e) => OddsModel.fromJson(e)).toList();
    }
    
    return dto;
  }
}
