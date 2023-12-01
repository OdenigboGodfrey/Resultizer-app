import 'package:firebase_auth/firebase_auth.dart';
import 'package:resultizer_merged/core/api/dio_helper.dart';
import 'package:resultizer_merged/core/api/endpoints.dart';
import 'package:resultizer_merged/core/error/firebase_error_handler.dart';
import 'package:resultizer_merged/core/utils/app_global.dart';
import 'package:resultizer_merged/features/auth/data/models/user_model.dart';
import 'package:dio/src/response.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:resultizer_merged/features/games/data/model/league_dto.dart';
import 'package:resultizer_merged/features/games/data/model/team_list_item_dto.dart';

const String documentName = 'favourites';
Future<bool> setFavouriteTeam(
    String uid, Map<int, TeamListItemDTO> item) async {
  try {
    var key = item.keys.first;
    // if (key == null) return false;
    final documentRef =
        FirebaseFirestore.instance.collection(documentName).doc(uid);
    // Fetch the data
    DocumentSnapshot documentSnapshot = await documentRef.get();
    Map<String, TeamListItemDTO> existingData = {};
    if (documentSnapshot.exists) {
      existingData = documentSnapshot.data() as Map<String, TeamListItemDTO>;
    }
    existingData[key.toString()] = item[key]!;

    // Set the field in Firestore
    await documentRef.set(existingData);
    return true;
  } catch (exception, stackTrace) {
    print(stackTrace);
  }
  return false;
}

abstract class GamesDatasource {
  final FirebaseAuth authInstance = FirebaseAuth.instance;

  Future<UserModel> fetchFromFirestore(
      {required String email, required String password});
  Future<UserModel> saveToFirestore({
    required String email,
    required String password,
    required String username,
    required String firstName,
    required String lastName,
  });

  Future<List<LeagueDTO>> getAllLeagues();
  Future<List<TeamListItemDTO>> getAllTeams(int leagueId);
}

class FirebaseGamesDatasource implements GamesDatasource {
  final DioHelper dioHelper;

  FirebaseGamesDatasource({required this.dioHelper});

  @override
  final FirebaseAuth authInstance = FirebaseAuth.instance;

  @override
  Future<UserModel> fetchFromFirestore(
      {required String email, required String password}) async {
    UserModel? userModel;
    try {
      final userCred = await authInstance.signInWithEmailAndPassword(
          email: email, password: password);
      var fullName = '...';
      DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(userCred.user!.uid)
          .get();

      if (documentSnapshot.exists) {
        // Retrieve the 'fullname' field from the document
        fullName =
            (documentSnapshot.data() as Map<String, dynamic>)['fullname'];
        fullName = fullName.toString();
      }

      userModel = UserModel(
          id: userCred.user!.uid,
          email: email,
          username: userCred.user!.displayName ?? '',
          fullname: fullName);
    } on FirebaseAuthException catch (e) {
      parseFirebaseException(e.code);
    } catch (e) {
      throw Exception(e);
    }
    return userModel!;
  }

  @override
  Future<UserModel> saveToFirestore({
    required String email,
    required String password,
    required String username,
    required String firstName,
    required String lastName,
  }) async {
    UserModel? userModel;
    try {
      var fullname = '$firstName $lastName';
      final userCred = await authInstance.createUserWithEmailAndPassword(
          email: email, password: password);
      userCred.user!.updateDisplayName(username);
      // setFullName(userCred.user, firstName: firstName, lastName: lastName);
      userModel = UserModel(
          id: userCred.user!.uid,
          email: email,
          username: userCred.user!.displayName ?? username,
          fullname: fullname);
    } on FirebaseAuthException catch (e) {
      parseFirebaseException(e.code);
    } catch (e, stackTrace) {
      print(stackTrace);
      throw Exception(e);
    }
    return userModel!;
  }

  @override
  Future<List<LeagueDTO>> getAllLeagues() async {
    try {
      if (GlobalDataSource.allLeagues != null) {
        return GlobalDataSource.allLeagues;
      }
      final response = await dioHelper.get(url: Endpoints.leagues);
      var result = await getResultForLeague(response);
      GlobalDataSource.allLeagues = result;
      return result;
    } catch (error, stackTrace) {
      print(stackTrace);
      rethrow;
    }
  }

  Future<List<LeagueDTO>> getResultForLeague(Response response) async {
    List<dynamic> result = response.data["response"];
    List<LeagueDTO> leagues = [];

    for (dynamic item in result) {
      var league = item['league'];
      var country = item['country'];

      int leagueId = league['id'];
      String leagueTitle = league['name'];
      String leagueLogo = league['logo'];
      String leagueCountry = country['name'] ?? '';
      String leagueCountryFlag = country['flag'] ?? '';

      leagues.add(LeagueDTO(
          id: leagueId,
          name: leagueTitle,
          logo: leagueLogo,
          country: leagueCountry,
          flag: leagueCountryFlag));
    }
    return leagues;
  }

  @override
  Future<List<TeamListItemDTO>> getAllTeams(int leagueId) async {
    try {
      if (GlobalDataSource.allLeagueTeams != null && GlobalDataSource.allLeagueTeams[leagueId] != null) {
        return GlobalDataSource.allLeagueTeams[leagueId];
      }
      final response = await dioHelper.get(
          url: Endpoints.teams,
          queryParams: {"league": leagueId, "season": DateTime.now().year});
      var result = await getResultForTeams(response);
      GlobalDataSource.allLeagueTeams[leagueId] = result;
      return result;
    } catch (error, stackTrace) {
      print(stackTrace);
      rethrow;
    }
  }

  Future<List<TeamListItemDTO>> getResultForTeams(Response response) async {
    List<dynamic> result = response.data["response"];
    List<TeamListItemDTO> leagues = [];

    for (dynamic item in result) {
      var team = item['team'];

      int teamId = team['id'];
      String teamTitle = team['name'] ?? '';
      String teamLogo = team['logo'] ?? '';
      String teamCountry = team['country'] ?? '';
      String teamCode = team['code'] ?? '';

      leagues.add(TeamListItemDTO(
          id: teamId,
          name: teamTitle,
          logo: teamLogo,
          country: teamCountry,
          code: teamCode));
    }
    return leagues;
  }
}
