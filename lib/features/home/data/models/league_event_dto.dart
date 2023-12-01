import 'dart:convert';

import 'package:resultizer_merged/features/home/data/models/premier_game_dto.dart';

class LeagueEventDTO {
  final String leagueTitle;
  final String flag;
  int fixtureId = 0;
  final String leagueSubTitle;
  final String leagueImage;
  List<PremierGameDTO> games;
  final int leagueId;

  LeagueEventDTO(
      {required this.leagueTitle,
      required this.leagueSubTitle,
      required this.games,
      required this.fixtureId,
      required this.leagueImage,
      required this.leagueId,
      required this.flag});

  String toJson() {
    return jsonEncode({
      'leagueTitle': leagueTitle,
      'fixtureId': fixtureId,
      'leagueSubTitle': leagueSubTitle,
      'games': jsonEncode(games),
      'leagueImage': leagueImage,
      'leagueId': leagueId,
      'flag': flag,
    });
  }

  Map toMap() {
    return {
      'leagueTitle': leagueTitle,
      'fixtureId': fixtureId,
      'leagueSubTitle': leagueSubTitle,
      'games': jsonEncode(games),
      'leagueImage': leagueImage,
      'leagueId': leagueId,
      'flag': flag,
    };
  }

  factory LeagueEventDTO.fromAppDbJson(Map<String, dynamic> json) {
    PremierGameDTO? games;
    if (json['games'] != null) {
      var tempGames = jsonDecode(json['games']);
      games = PremierGameDTO.fromAppDbJson(tempGames[0]);
    }
    return LeagueEventDTO(
        leagueTitle: json['leagueTitle'],
        leagueSubTitle: json['leagueSubTitle'],
        games: games != null ? [games] : [],
        fixtureId: json['fixtureId'],
        leagueImage: json['leagueImage'],
        leagueId: json['leagueId'],
        flag: json['flag']);
  }
}
