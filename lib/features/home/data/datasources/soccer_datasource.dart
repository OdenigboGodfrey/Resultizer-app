import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:resultizer_merged/core/api/dio_helper.dart';
import 'package:resultizer_merged/core/api/endpoints.dart';
import 'package:resultizer_merged/features/home/data/models/bet_model_dto.dart';
import 'package:resultizer_merged/features/home/data/models/fixture_model_dto.dart';
import 'package:resultizer_merged/features/home/data/models/league_event_dto.dart';
import 'package:resultizer_merged/features/home/data/models/premier_game_dto.dart';
import 'package:resultizer_merged/utils/constant/app_string.dart';

abstract class SoccerDataSource {
  Future<List<dynamic>> getUpcomingFixtures({
    required String date,
  });

  Future<List<dynamic>> getLiveFootballMatches();
  Future<dynamic> getMatchByFixtureId(int fixtureId);
  Future<List<FullFixtureModel>> getMatchInfoByFixtureId(int fixtureId);
  Future<List<LeagueEventDTO>> getMatchByTeam(int teamId);
  Future<List<LeagueEventDTO>> getMatchByCompetition(int competitionId);
  Future<dynamic> getTeamStatistic(int teamId, int leagueId);

  Future<List<dynamic>> getFixturesByDate({
    required String date,
  });

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
  Future<List> getUpcomingFixtures({required String date}) async {
    try {
      final response = await dioHelper
          .get(url: Endpoints.fixtures, queryParams: {"date": date});
      return await _getFixturesResult(response);
    } catch (error, stackTrace) {
      print(stackTrace);
      rethrow;
    }
  }

  @override
  Future<List> getFixturesByDate({required String date}) async {
    try {
      final response = await dioHelper
          .get(url: Endpoints.fixtures, queryParams: {"date": date});
      return await _getFixturesResult(response, onlyFutureGames: false);
    } catch (error, stackTrace) {
      print(stackTrace);
      rethrow;
    }
  }

  Future<List<LeagueEventDTO>> _getFixturesResult(Response response,
      {bool onlyFutureGames = true}) async {
    List<dynamic> result = response.data["response"];
    Map<int, LeagueEventDTO> leagueMatches = {};

    for (dynamic item in result) {
      if (item['fixture'] == null) continue;
      int fixtureId = item['fixture']['id'];
      int leagueId = item['league']['id'];
      String leagueTitle = item['league']['name'];
      String leagueSubTitle = item['league']['country'];
      String leagueCountryFlag = item['league']['flag'] ?? '';
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
      int homeTeamId = item['teams']['home']['id'];
      int awayTeamId = item['teams']['away']['id'];
      if (onlyFutureGames && matchStatus != AppString.ns) continue;
      if (onlyFutureGames && !isMatchTimeInFuture(matchTime)) continue;

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
        matchTime: matchTime,
        homeTeamId: homeTeamId,
        awayTeamId: awayTeamId,
      );

      if (leagueMatches.keys.contains(leagueId)) {
        leagueMatches[leagueId]?.games.add(premierGame);
      } else {
        leagueMatches[leagueId] = LeagueEventDTO(
          leagueTitle: leagueTitle,
          leagueSubTitle: leagueSubTitle,
          games: [premierGame],
          fixtureId: fixtureId,
          leagueImage: leagueImage,
          leagueId: leagueId,
          flag: leagueCountryFlag,
        );
        ;
      }
    }
    var data = leagueMatches.values.toList();
    return sortFixturesAlphabetically(data);
  }

  List<LeagueEventDTO> sortFixturesAlphabetically(List<LeagueEventDTO> data) {
    // leagues.sort((a, b) =>
    //   (a.leagueTitle + '-' + a.leagueSubTitle)
    //       .compareTo(b.leagueTitle + '-' + b.leagueSubTitle));

    data.sort((a, b) {
      // sorty and return;
      return ('${a.leagueTitle}-${a.leagueSubTitle}')
          .compareTo('${b.leagueTitle}-${b.leagueSubTitle}');
    });
    return data;
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
      String leagueCountryFlag = item['league']['flag'] ?? '';
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
      int homeTeamId = item['teams']['home']['id'];
      int awayTeamId = item['teams']['away']['id'];
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
        matchTime: matchTime,
        homeTeamId: homeTeamId,
        awayTeamId: awayTeamId,
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
          leagueImage: leagueImage,
          leagueId: leagueId,
          flag: leagueCountryFlag,
        );
        ;
      }
    }
    var data = leagueMatches.values.toList();
    return sortFixturesAlphabetically(data);
  }

  @override
  Future<ApiResponse> getMatchByFixtureId(int fixtureId) async {
    try {
      final response = await dioHelper.get(
          url: Endpoints.odds, queryParams: {"fixture": fixtureId.toString()});
      List<dynamic> responseData = response.data['response'];

      List<FullFixtureModel> responseData0 = responseData
          .map((dynamic item) => FullFixtureModel.fromJson(item))
          .toList();

      ApiResponse data = ApiResponse(
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

  @override
  Future<List<FullFixtureModel>> getMatchInfoByFixtureId(int fixtureId) async {
    try {
      final response = await dioHelper.get(
          url: Endpoints.fixtures, queryParams: {"id": fixtureId.toString()});
      List<dynamic> responseData = response.data['response'];

      List<FullFixtureModel> responseData0 = responseData
          .map((dynamic item) => FullFixtureModel.fromJson(item))
          .toList();

      return responseData0;
    } catch (error, stackTrace) {
      print(stackTrace);
      rethrow;
    }
  }

  @override
  Future<List<LeagueEventDTO>> getMatchByCompetition(int competitionId) async {
    try {
      final response = await dioHelper.get(
          url: Endpoints.fixtures,
          queryParams: {
            "league": competitionId,
            "season": DateTime.now().year
          });
      return await getResultForTeamAndCompetition(response);
    } catch (error, stackTrace) {
      print(stackTrace);
      rethrow;
    }
  }

  @override
  Future<List<LeagueEventDTO>> getMatchByTeam(int teamId) async {
    try {
      final response = await dioHelper.get(
          url: Endpoints.fixtures,
          queryParams: {"team": teamId, "season": DateTime.now().year});
      var apiResponse = await getResultForTeamAndCompetition(response);
      return apiResponse;
    } catch (error, stackTrace) {
      print(stackTrace);
      rethrow;
    }
  }

  Future<List<LeagueEventDTO>> getResultForTeamAndCompetition(
      Response response) async {
    List<dynamic> result = response.data["response"];
    Map<int, LeagueEventDTO> leagueMatches = {};

    for (dynamic item in result) {
      if (item['fixture'] == null) continue;
      int fixtureId = item['fixture']['id'];
      int leagueId = item['league']['id'];
      String leagueTitle = item['league']['name'];
      String leagueSubTitle = item['league']['country'];
      String leagueCountryFlag = item['league']['flag'] ?? '';
      String leagueImage = item['league']['logo'] ?? '';
      DateTime matchTime = DateTime.parse(item['fixture']['date']);
      String homeLogo = item['teams']['home']['logo'] ?? '';
      String awayLogo = item['teams']['away']['logo'] ?? '';
      String homeTeam = item['teams']['home']['name'];
      String awayTeam = item['teams']['away']['name'];
      String matchStatus = item['fixture']['status']['short'];
      String matchStatusLong = item['fixture']['status']['long'];
      int homeTeamId = item['teams']['home']['id'];
      int awayTeamId = item['teams']['away']['id'];
      String goals =
          '${item['goals']['home'] ?? 0} : ${item['goals']['away'] ?? 0}';

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
        matchTime: matchTime,
        homeTeamId: homeTeamId,
        awayTeamId: awayTeamId,
      );

      if (leagueMatches.keys.contains(leagueId)) {
        leagueMatches[leagueId]?.games.add(premierGame);
      } else {
        leagueMatches[leagueId] = LeagueEventDTO(
          leagueTitle: leagueTitle,
          leagueSubTitle: leagueSubTitle,
          games: [premierGame],
          fixtureId: fixtureId,
          leagueImage: leagueImage,
          leagueId: leagueId,
          flag: leagueCountryFlag,
        );
        ;
      }
    }
    return leagueMatches.values.toList();
  }

  int teamStatsRetryCounter = 0;
  @override
  Future<dynamic> getTeamStatistic(int teamId, int leagueId,
      {DateTime? season}) async {
    try {
      season ??= DateTime.now();
      final response = await dioHelper.get(
          url: Endpoints.teamStatistics,
          queryParams: {
            "team": teamId,
            "season": season.year,
            "league": leagueId
          });
      dynamic result = response.data["response"];
      // var apiResponse = await getResultForTeamAndCompetition(response);
      if (result['fixtures']!['played']!['home'] == 0 && teamStatsRetryCounter < 2) {
        teamStatsRetryCounter++;
        var previousYear = season.subtract(Duration(days: 365));
        return getTeamStatistic(teamId, leagueId, season: previousYear);
      } else {
        teamStatsRetryCounter = 0;
        return result;
      }
    } catch (error, stackTrace) {
      print(stackTrace);
      rethrow;
    }
  }
}
