import 'package:dio/dio.dart';
import 'package:resultizer_merged/core/api/dio_helper.dart';
import 'package:resultizer_merged/core/api/endpoints.dart';
import 'package:resultizer_merged/features/videos/data/model/recent_feeds_dto.dart';

abstract class RecentFeedsDataSource {
  Future<List<RecentFeedsModel>> getRecentFeeds();
}

class RecentFeedsDataSourceImplementation implements RecentFeedsDataSource {
  final DioHelper dioHelper;

  RecentFeedsDataSourceImplementation({required this.dioHelper});
  
  @override
  Future<List<RecentFeedsModel>> getRecentFeeds() async {
    try {
      final response = await dioHelper
          .get(url: '${Endpoints.socreBatV3VideoApi}${Endpoints.scoreBatRecentFeeds}', queryParams: {"token": scoreBatToken}, requestType: REQUESTTYPE.scorebat);

      return prepareResponse(response);
    } catch (error, stackTrace) {
      print(error);
      print(stackTrace);
      rethrow;
    }
  }

  List<RecentFeedsModel> prepareResponse(Response apiResponse) {
    print(apiResponse);
    List<RecentFeedsModel> response = [];
    List<dynamic> result = apiResponse.data["response"];

    for (dynamic item in result) {
      response.add(RecentFeedsModel.fromJson(item));
    }


    return response;
  }
}