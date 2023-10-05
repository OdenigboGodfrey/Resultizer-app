import 'dart:convert';

import 'package:resultizer_merged/features/home/data/models/bet_model_dto.dart';
import 'package:resultizer_merged/features/home/data/models/premier_game_dto.dart';

class LeagueEventDTO {
  final String leagueTitle;
  final int fixtureId = 0;
  final String leagueSubTitle;
  final String leagueImage;
  List<PremierGameDTO> games;

  LeagueEventDTO({required this.leagueTitle, required this.leagueSubTitle, required this.games, required fixtureId, required this.leagueImage});

  Map<String, dynamic> toJson() {
    return {
      'leagueTitle': leagueTitle,
      'fixtureId': fixtureId,
      'leagueSubTitle': leagueSubTitle,
      'games': jsonEncode(games),
      'leagueImage': leagueImage,
    };
  }
}