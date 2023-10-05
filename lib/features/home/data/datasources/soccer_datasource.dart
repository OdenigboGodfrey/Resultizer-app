import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:resultizer_merged/core/api/dio_helper.dart';
import 'package:resultizer_merged/core/api/endpoints.dart';
import 'package:resultizer_merged/features/home/data/models/bet_model_dto.dart';
import 'package:resultizer_merged/features/home/data/models/fixture_model_dto.dart';
import 'package:resultizer_merged/features/home/data/models/league_event_dto.dart';
import 'package:resultizer_merged/features/home/data/enum/premier_game_enum.dart';
import 'package:resultizer_merged/features/home/data/models/premier_game_dto.dart';
import 'package:resultizer_merged/utils/constant/app_string.dart';

abstract class SoccerDataSource {
  Future<List<dynamic>> getDayFixtures({
    required String date,
  });

  Future<List<dynamic>> getLiveFootballMatches();
  Future<dynamic> getMatchByFixtureId(int fixtureId);

  // Future<List<dynamic>> getLiveFixtures();
}

class SoccerDataSourceImplementation implements SoccerDataSource {
  final DioHelper dioHelper;

  SoccerDataSourceImplementation({required this.dioHelper});

  String formatString(int number) {
    return number.toString().padLeft(2, '0');
  }

  bool isMatchTimeInFuture(DateTime matchTime) {
    DateTime currentDateTime = DateTime.now();
    return matchTime.isAfter(currentDateTime);
  }

  @override
  Future<List> getDayFixtures({required String date}) async {
    try {
      final response = await dioHelper
          .get(url: Endpoints.fixtures, queryParams: {"date": date});
      return await _getResult(response);
    } catch (error, stackTrace) {
      print(stackTrace);
      rethrow;
    }
  }

  Future<List<LeagueEventDTO>> _getResult(Response response) async {
    List<dynamic> result = response.data["response"];
    Map<int, LeagueEventDTO> leagueMatches = {};

    for (dynamic item in result) {
      if (item['fixture'] == null) continue;
      int fixtureId = item['fixture']['id'];
      int leagueId = item['league']['id'];
      String leagueTitle = item['league']['name'];
      String leagueSubTitle = item['league']['country'];
      String leagueImage = item['league']['logo'] ?? '';
      DateTime matchTime = DateTime.parse(item['fixture']['date']);
      String homeLogo = item['teams']['home']['logo'] ?? '';
      String awayLogo = item['teams']['away']['logo'] ?? '';
      String homeTeam = item['teams']['home']['name'];
      String awayTeam = item['teams']['away']['name'];
      String matchStatus = item['fixture']['status']['short'];
      String matchStatusLong = item['fixture']['status']['long'];
      String goals =
          '${item['goals']['home'] ?? 0} : ${item['goals']['away'] ?? 0}';
      if (matchStatus != AppString.ns) continue;
      if (!isMatchTimeInFuture(matchTime)) continue;

      PremierGameDTO premierGame = PremierGameDTO(
          gameTime:
              '${formatString(matchTime.hour)}:${formatString(matchTime.minute)}',
          homeLogo: homeLogo,
          homeTeam: homeTeam,
          awayLogo: awayLogo,
          awayTeam: awayTeam,
          matchStatus: matchStatus,
          goals: goals,
          matchStatusLong: matchStatusLong,
          fixtureId: fixtureId,
          );

      if (leagueMatches.keys.contains(leagueId)) {
        leagueMatches[leagueId]?.games.add(premierGame);
      } else {
        leagueMatches[leagueId] = LeagueEventDTO(
            leagueTitle: leagueTitle,
            leagueSubTitle: leagueSubTitle,
            games: [premierGame],
            fixtureId: fixtureId,
            leagueImage: leagueImage);
        ;
      }
    }
    return leagueMatches.values.toList();
  }

  @override
  Future<List> getLiveFootballMatches() async {
    try {
      final response = await dioHelper
          .get(url: Endpoints.fixtures, queryParams: {"live": 'all'});

      var matches = await _prepareLiveResult(response);
      return matches;
    } catch (error, stackTrace) {
      print(error);
      print(stackTrace);
      rethrow;
    }
  }

  Future<List<LeagueEventDTO>> _prepareLiveResult(Response response) async {
    List<dynamic> result = response.data["response"];
    Map<int, LeagueEventDTO> leagueMatches = {};

    for (dynamic item in result) {
      if (item['fixture'] == null) continue;
      int fixtureId = item['fixture']['id'];
      int leagueId = item['league']['id'];
      String leagueTitle = item['league']['name'];
      String leagueSubTitle = item['league']['country'];
      String leagueImage = item['league']['logo'] ?? '';
      DateTime matchTime = DateTime.parse(item['fixture']['date']);
      String homeLogo = item['teams']['home']['logo'] ?? '';
      String awayLogo = item['teams']['away']['logo'] ?? '';
      String homeTeam = item['teams']['home']['name'];
      String awayTeam = item['teams']['away']['name'];
      String matchStatus = item['fixture']['status']['short'];
      String matchStatusLong = item['fixture']['status']['long'];
      String goals =
          '${item['goals']['home'] ?? 0} : ${item['goals']['away'] ?? 0}';
      var oddsRequest = await getMatchByFixtureId(fixtureId);
      if (oddsRequest.response.isEmpty) continue;
      String matchCurrentTime = oddsRequest.response[0].fixture.status.seconds;

      PremierGameDTO premierGame = PremierGameDTO(
        gameTime:
            '${formatString(matchTime.hour)}:${formatString(matchTime.minute)}',
        homeLogo: homeLogo,
        homeTeam: homeTeam,
        awayLogo: awayLogo,
        awayTeam: awayTeam,
        matchStatus: matchStatus,
        goals: goals,
        gameCurrentTime: matchCurrentTime,
        matchStatusLong: matchStatusLong,
        fixtureId: fixtureId,
      );

      List<OddsModel> odds = oddsRequest.response[0].odds;

      premierGame.odds = odds;

      if (leagueMatches.keys.contains(leagueId)) {
        leagueMatches[leagueId]?.games.add(premierGame);
      } else {
        leagueMatches[leagueId] = LeagueEventDTO(
            leagueTitle: leagueTitle,
            leagueSubTitle: leagueSubTitle,
            games: [premierGame],
            fixtureId: fixtureId,
            leagueImage: leagueImage);
        ;
      }
    }
    return leagueMatches.values.toList();
  }

  @override
  Future<LiveBetsResponse> getMatchByFixtureId(int fixtureId) async {
    try {
      final response = await dioHelper.get(
          url: Endpoints.odds, queryParams: {"fixture": fixtureId.toString()});
      List<dynamic> responseData = response.data['response'];

      List<FullFixtureModel> responseData0 = responseData
          .map((dynamic item) => FullFixtureModel.fromJson(item))
          .toList();

      LiveBetsResponse data = LiveBetsResponse(
        errors: response.data['errors'],
        results: response.data['results'],
        parameters: response.data['parameters'],
        get: response.data['get'],
        paging: response.data['paging'],
        response: responseData0,
      );

      return data;
      // return null;
    } catch (error, stackTrace) {
      print(stackTrace);
      rethrow;
    }
  }
}
