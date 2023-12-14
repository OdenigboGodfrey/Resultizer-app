import 'package:dio/src/response.dart';
import 'package:flutter/material.dart';

class GlobalDataSource {
  static dynamic userData = {};
  static dynamic settings = {
    'refreshFavouriteTeam': true,
    'refreshFavouriteLeague': true,
    'refreshFavouriteMatches': true,
  };
  static dynamic favouriteTeams = {};
  static dynamic favouriteLeagues = {};
  static List favouriteMatchIds = [];
  static dynamic favouriteLeagueMatches = {};
  static void writeToFavouriteMatches(dynamic data) {
    if (favouriteLeagueMatches[data['leagueId']] != null) {
      // write as existing
      List tmpData = favouriteLeagueMatches[data['leagueId']]['games'];
      tmpData.add(data['games']);
      favouriteLeagueMatches[data['leagueId']]['games'] = tmpData;
    } else {
      // write as new
      favouriteLeagueMatches[data['leagueId']] = data;
    }
  }
  static dynamic allLeagues;
  static dynamic allLeagueTeams = {};
  static GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
}