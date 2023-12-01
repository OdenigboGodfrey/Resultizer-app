import 'dart:async';
import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:resultizer_merged/core/api/dio_helper.dart';
import 'package:resultizer_merged/core/dto/response_dto.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:resultizer_merged/core/utils/app_global.dart';
import 'package:resultizer_merged/features/games/data/model/league_dto.dart';
import 'package:resultizer_merged/features/games/data/model/team_list_item_dto.dart';
import 'package:resultizer_merged/features/home/data/models/league_event_dto.dart';

const String favouriteTeamsDocumentName = 'favourite-teams';
const String favouriteLeaguesDocumentName = 'favourite-leagues';
const String favouriteMatchesDocumentName = 'favourite-matches';

abstract class FavouritesDatasource {
  final FirebaseAuth authInstance = FirebaseAuth.instance;

  Future<bool> setFavouriteTeam(String uid, Map<int, TeamListItemDTO> item);
  Future<ResponseDTO<Map<dynamic, dynamic>>> getFavouriteTeams(String uid);
  Future<bool> setFavouriteLeagues(String uid, Map<int, LeagueDTO> item);
  Future<ResponseDTO<Map<String, dynamic>>> getFavouriteLeagues(String uid);
  Future<bool> removeFavouriteTeam(String uid, int teamId);
  Future<bool> removeFavouriteLeague(String uid, int leagueId);

  Future<bool> setFavouriteMatch(String uid, Map<int, LeagueEventDTO> item);
  Future<ResponseDTO<Map<String, dynamic>>> getFavouriteMatches(String uid);
  Future<bool> removeFavouriteMatch(String uid, int id);
}

class FirebaseFavouriteDatasource implements FavouritesDatasource {
  final DioHelper dioHelper;

  FirebaseFavouriteDatasource({required this.dioHelper});

  Future<dynamic> customPromise(Function action) async {
    Completer<dynamic> completer = Completer<dynamic>();

    // Simulate an asynchronous operation
    action().then((value) {
      completer.complete(true);
    }).catchError((err) {
      completer.complete(false);
    });

    return completer.future;
    // Future.delayed(Duration(seconds: 2), () {
    //   // Resolve the promise with a value
    //   completer.complete(42);
    // });

    // // Return the future associated with the completer
    // return completer.future;
  }

  @override
  final FirebaseAuth authInstance = FirebaseAuth.instance;

  @override
  Future<ResponseDTO<Map<String, dynamic>>> getFavouriteLeagues(
      String uid) async {
    var response = ResponseDTO<Map<String, dynamic>>(data: {});
    try {
      if (!GlobalDataSource.settings['refreshFavouriteLeague']) {
        response.status = true;
        response.data = GlobalDataSource.favouriteLeagues;
        response.code = '200';
        response.message = 'Favourite leagues fetched';
        return response;
      }
      final documentRef = FirebaseFirestore.instance
          .collection(favouriteLeaguesDocumentName)
          .doc(uid);
      // Fetch the data
      DocumentSnapshot documentSnapshot = await documentRef.get();
      Map<String, dynamic> existingData = {};
      if (documentSnapshot.exists) {
        existingData = documentSnapshot.data() as Map<String, dynamic>;
        response.status = true;
        response.data = existingData;
        response.code = '200';
        response.message = 'Favourite leagues fetched';
      } else {
        response.message = 'Favourite leagues not found';
        GlobalDataSource.favouriteLeagues = response.data;
        GlobalDataSource.settings['refreshFavouriteLeague'] = false;
      }
    } catch (exception, stackTrace) {
      print(stackTrace);
      response.message = 'An error occurred while fetching favourite leagues';
      response.code = '500';
    }
    return response;
  }

  @override
  Future<ResponseDTO<Map<String, dynamic>>> getFavouriteTeams(
      String uid) async {
    var response = ResponseDTO<Map<String, dynamic>>(data: {});
    try {
      if (!GlobalDataSource.settings['refreshFavouriteTeam']) {
        response.status = true;
        response.data = GlobalDataSource.favouriteTeams;
        response.code = '200';
        response.message = 'Favourite teams fetched';
        return response;
      }
      final documentRef = FirebaseFirestore.instance
          .collection(favouriteTeamsDocumentName)
          .doc(uid);
      // Fetch the data
      DocumentSnapshot documentSnapshot = await documentRef.get();
      Map<String, dynamic> existingData = {};
      if (documentSnapshot.exists) {
        existingData = (documentSnapshot.data() as Map<String, dynamic>);
        response.status = true;
        response.data =
            existingData; //existingData as Map<String, TeamListItemDTO>;
        response.code = '200';
        response.message = 'Favourite teams fetched';
        // save in-memory
        GlobalDataSource.favouriteTeams = response.data;
        // turn off to use in memory on next favourite call
        GlobalDataSource.settings['refreshFavouriteTeam'] = false;
      } else {
        response.message = 'Favourite teams not found';
      }
    } catch (exception, stackTrace) {
      print(stackTrace);
      response.message = 'An error occurred while fetching favourite teams';
      response.code = '500';
    }
    return response;
  }

  @override
  Future<bool> setFavouriteLeagues(String uid, Map<int, LeagueDTO> item) async {
    try {
      var key = item.keys.first;
      // if (key == null) return false;
      final documentRef = FirebaseFirestore.instance
          .collection(favouriteLeaguesDocumentName)
          .doc(uid);
      // Fetch the data
      DocumentSnapshot documentSnapshot = await documentRef.get();
      Map<String, dynamic> existingData = {};
      if (documentSnapshot.exists) {
        existingData = documentSnapshot.data() as Map<String, dynamic>;
      }
      existingData[key.toString()] = jsonDecode(item[key]!.toJson());

      // Set the field in Firestore
      var result = await customPromise(() async {
        await documentRef.set(existingData);
      });
      GlobalDataSource.settings['refreshFavouriteLeague'] = result;
      return result;
      // await documentRef.set(existingData);
      // return true;
    } catch (exception, stackTrace) {
      print(stackTrace);
    }
    return false;
  }

  @override
  Future<bool> setFavouriteTeam(
      String uid, Map<int, TeamListItemDTO> item) async {
    try {
      var key = item.keys.first;
      // if (key == null) return false;
      final documentRef = FirebaseFirestore.instance
          .collection(favouriteTeamsDocumentName)
          .doc(uid);
      // Fetch the data
      DocumentSnapshot documentSnapshot = await documentRef.get();
      Map<String, dynamic> existingData = {};
      if (documentSnapshot.exists) {
        existingData = documentSnapshot.data() as Map<String, dynamic>;
      }
      existingData[key.toString()] = jsonDecode(item[key]!.toJson());

      // Set the field in Firestore
      var result = await customPromise(() async {
        await documentRef.set(existingData);
      });
      GlobalDataSource.settings['refreshFavouriteTeam'] = result;
      return result;
    } catch (exception, stackTrace) {
      print(stackTrace);
    }
    return false;
  }

  @override
  Future<bool> removeFavouriteLeague(String uid, int leagueId) async {
    try {
      var league = await getFavouriteLeagues(uid);
      if (league.status) {
        league.data.remove(leagueId.toString());
        // return await setFavouriteLeagues(
        //     uid, league.data!.cast<int, LeagueDTO>());
        // Set the field in Firestore
        var result = await customPromise(() async {
          final documentRef = FirebaseFirestore.instance
              .collection(favouriteLeaguesDocumentName)
              .doc(uid);
          await documentRef.set(league.data);
        });
        GlobalDataSource.settings['refreshFavouriteLeague'] = result;
        return result;
      }
    } catch (exception, stackTrace) {
      print(stackTrace);
    }
    return false;
  }

  @override
  Future<bool> removeFavouriteTeam(String uid, int teamId) async {
    try {
      var team = await getFavouriteTeams(uid);
      if (team.status) {
        var data = team.data;
        data.remove(teamId.toString());
        // Set the field in Firestore
        var result = await customPromise(() async {
          final documentRef = FirebaseFirestore.instance
              .collection(favouriteTeamsDocumentName)
              .doc(uid);
          await documentRef.set(data);
        });
        GlobalDataSource.settings['refreshFavouriteTeam'] = result;
        return result;
      }
    } catch (exception, stackTrace) {
      print(stackTrace);
    }
    return false;
  }

  @override
  Future<bool> setFavouriteMatch(
      String uid, Map<int, LeagueEventDTO> item) async {
    try {
      var firstItemKey = item.keys.first;
      var key = item[firstItemKey]!.fixtureId;
      // if (key == null) return false;
      final documentRef = FirebaseFirestore.instance
          .collection(favouriteMatchesDocumentName)
          .doc(uid);
      // Fetch the data
      DocumentSnapshot documentSnapshot = await documentRef.get();
      Map<String, dynamic> existingData = {};
      if (documentSnapshot.exists) {
        existingData = documentSnapshot.data() as Map<String, dynamic>;
      }
      existingData[key.toString()] = item[firstItemKey]!.toMap();

      // Set the field in Firestore
      var result = await customPromise(() async {
        await documentRef.set(existingData);
      });
      GlobalDataSource.settings['refreshFavouriteMatches'] = result;
      return result;
    } catch (exception, stackTrace) {
      print(stackTrace);
    }
    return false;
  }

  @override
  Future<bool> removeFavouriteMatch(String uid, int id) async {
    try {
      var matches = await getFavouriteMatches(uid);
      if (matches.status) {
        var data = matches.data;
        data.remove(id.toString());
        // Set the field in Firestore
        var result = await customPromise(() async {
          final documentRef = FirebaseFirestore.instance
              .collection(favouriteMatchesDocumentName)
              .doc(uid);
          await documentRef.set(data);
        });
        GlobalDataSource.settings['refreshFavouriteMatches'] = result;
        return result;
      }
    } catch (exception, stackTrace) {
      print(stackTrace);
    }
    return false;
  }

  @override
  Future<ResponseDTO<Map<String, dynamic>>> getFavouriteMatches(
      String uid) async {
    var response = ResponseDTO<Map<String, dynamic>>(data: {});
    try {
      if (!GlobalDataSource.settings['refreshFavouriteMatches']) {
        response.status = true;
        response.data = GlobalDataSource.favouriteLeagueMatches;
        response.code = '200';
        response.message = 'Favourite matches fetched';
        return response;
      }
      final documentRef = FirebaseFirestore.instance
          .collection(favouriteMatchesDocumentName)
          .doc(uid);
      // Fetch the data
      DocumentSnapshot documentSnapshot = await documentRef.get();
      Map<String, dynamic> existingData = {};
      if (documentSnapshot.exists) {
        existingData = (documentSnapshot.data() as Map<String, dynamic>);
        existingData.values.map((item){
          item['games'] = jsonDecode(item['games']);
        });
        response.status = true;
        response.data =
            existingData;
        response.code = '200';
        response.message = 'Favourite matches fetched';
        // save in-memory
        GlobalDataSource.favouriteLeagueMatches = existingData;
        GlobalDataSource.favouriteMatchIds = existingData.keys.toList();
        // GlobalDataSource.writeToFavouriteMatches(response.data);
        // turn off to use in memory on next favourite call
        GlobalDataSource.settings['refreshFavouriteMatches'] = false;
      } else {
        response.message = 'Favourite matches not found';
      }
    } catch (exception, stackTrace) {
      print(stackTrace);
      response.message = 'An error occurred while fetching favourite matches';
      response.code = '500';
    }
    return response;
  }
}
