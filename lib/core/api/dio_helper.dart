import 'package:dio/dio.dart';
import 'package:resultizer_merged/container_injector.dart';
import 'package:resultizer_merged/core/api/endpoints.dart';
import 'package:resultizer_merged/core/utils/app_constants.dart';

//import '../../container_injector.dart';
//import '../utils/app_constants.dart';

const String _contentType = "Content-Type";
const String _applicationJson = "application/json";
const String _apiKey =
    "ac2de663a4msh31a3aaa3a5e8808p122883jsnb520db3c2e87"; // Add your api key here
const int _timeOut = 20000;
const String _host = 'api-football-v1.p.rapidapi.com';
const String scoreBatToken = 'MTA2MjAyXzE2OTc0MzM0NjFfYmQ1ZWExN2NhNDZmODhiNjRiMTkwZjljNjMxZWQ3NzY5ZWE0MzQzYg';

const String oneSignalRestApiToken = 'YmI5ZDFkMmMtMTUxNS00MWIyLTg4NTYtZDJiNGQ2MTU4YWY3';
const String oneSignalAppId = 'db1bd7a7-9029-465b-b8cf-a15311196e3a';

enum REQUESTTYPE {
  app,
  scorebat,
}

class DioHelper {
  final Dio dio;
  Map<String, dynamic> headers = {};

  DioHelper({required this.dio}) {
    headers = {
      _contentType: _applicationJson,
      'x-rapidapi-host': _host,
      'x-rapidapi-key': _apiKey,
    };
    dio.options = BaseOptions(
      baseUrl: AppConstants.baseUrl,
      receiveDataWhenStatusError: true,
      receiveTimeout: _timeOut,
      connectTimeout: _timeOut,
      // headers: headers,
    );
    dio.interceptors.add(sl<LogInterceptor>());
    //dio.interceptors.add(sl<AppInterceptors>());
  }

  Future<Response> get({
    required String url,
    Map<String, dynamic>? queryParams,
    REQUESTTYPE? requestType = REQUESTTYPE.app,
    String? baseUrl = '',
  }) async {
    if (requestType != REQUESTTYPE.app) {
      if (requestType == REQUESTTYPE.scorebat) baseUrl = Endpoints.scoreBatBaseUrl;
      dio.options.baseUrl = baseUrl.toString();
      dio.options.headers = {_contentType: _applicationJson,};
    } else {
      dio.options.baseUrl = AppConstants.baseUrl;
      dio.options.headers = headers;
    }

    return await dio.get(url, queryParameters: queryParams);
  }
}
