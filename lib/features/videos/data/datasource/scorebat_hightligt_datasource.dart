import 'package:dio/dio.dart';
import 'package:resultizer_merged/core/api/dio_helper.dart';
import 'package:resultizer_merged/core/api/endpoints.dart';
import 'package:resultizer_merged/features/videos/data/model/scorebat_model_dto.dart';

abstract class RecentFeedsDataSource {
  Future<List<ScorebatVideoModel>> getRecentFeeds();

  Future<List<ScorebatVideoModel>> getHighlightsByTeam(String team);
  Future<List<ScorebatVideoModel>> getHighlightsByCompetition(String team);
  Future<List<Map>> getTeams();
  Future<List<Map>> getCompetitions();
}

class RecentFeedsDataSourceImplementation implements RecentFeedsDataSource {
  final DioHelper dioHelper;

  RecentFeedsDataSourceImplementation({required this.dioHelper});

  @override
  Future<List<ScorebatVideoModel>> getRecentFeeds() async {
    try {
      final response = await dioHelper.get(
          url:
              '${Endpoints.socreBatV3VideoApi}${Endpoints.scoreBatRecentFeeds}',
          queryParams: {"token": scoreBatToken},
          requestType: REQUESTTYPE.scorebat);

      return prepareResponse(response);
    } catch (error, stackTrace) {
      print(error);
      print(stackTrace);
      rethrow;
    }
  }

  List<ScorebatVideoModel> prepareResponse(Response apiResponse) {
    print(apiResponse);
    List<ScorebatVideoModel> response = [];
    List<dynamic> result = apiResponse.data["response"];

    for (dynamic item in result) {
      response.add(ScorebatVideoModel.fromJson(item));
    }

    return response;
  }

  @override
  Future<List<ScorebatVideoModel>> getHighlightsByCompetition(
      String competition) async {
    try {
      final response = await dioHelper.get(
          url:
              '${Endpoints.socreBatV3VideoApi}${Endpoints.scoreBatCompetition}$competition',
          queryParams: {"token": scoreBatToken},
          requestType: REQUESTTYPE.scorebat);

      return prepareResponse(response);
    } catch (error, stackTrace) {
      print(error);
      print(stackTrace);
      rethrow;
    }
  }

  @override
  Future<List<ScorebatVideoModel>> getHighlightsByTeam(String team) async {
    try {
      final response = await dioHelper.get(
          url: '${Endpoints.socreBatV3VideoApi}${Endpoints.scoreBatTeam}$team',
          queryParams: {"token": scoreBatToken},
          requestType: REQUESTTYPE.scorebat);

      return prepareResponse(response);
    } catch (error, stackTrace) {
      print(error);
      print(stackTrace);
      rethrow;
    }
  }

  @override
  Future<List<Map>> getCompetitions() async {
    try {
      final response = await dioHelper.get(
          url: Endpoints.scoreBatListCompetitions,
          requestType: REQUESTTYPE.scorebat);

      return prepareListResponse(response);
    } catch (error, stackTrace) {
      print(error);
      print(stackTrace);
      rethrow;
    }
  }

  @override
  Future<List<Map>> getTeams() async {
    try {
      final response = await dioHelper.get(
          url: Endpoints.scoreBatListTeams, requestType: REQUESTTYPE.scorebat);

      return prepareListResponse(response);
    } catch (error, stackTrace) {
      print(error);
      print(stackTrace);
      rethrow;
    }
  }

  // for list competiton and teams
  List<Map> prepareListResponse(Response apiResponse) {
    print(apiResponse);
    List<Map> response = [];
    List<dynamic> result = apiResponse.data["response"];

    for (dynamic item in result) {
      response.add(item);
    }

    return response;
  }
}
