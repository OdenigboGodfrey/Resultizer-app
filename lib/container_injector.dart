import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:resultizer_merged/core/api/dio_helper.dart';
import 'package:resultizer_merged/core/network/network_info.dart';
import 'package:resultizer_merged/features/auth/auth_injector.dart';
import 'package:resultizer_merged/features/home/home_injector.dart';
import 'package:resultizer_merged/features/videos/videos_injector.dart';


final sl = GetIt.instance;

void initApp() {
  initCore();
  initAuth();
  initHome();
  initVideos();
}

void initCore() {
  sl.registerLazySingleton<Dio>(() => Dio());
  sl.registerLazySingleton<LogInterceptor>(
    () => LogInterceptor(
      error: true,
      request: true,
      requestBody: true,
      requestHeader: true,
      responseBody: true,
      responseHeader: true,
    ),
  );
  sl.registerLazySingleton<DioHelper>(() => DioHelper(dio: sl<Dio>()));
  sl.registerLazySingleton<InternetConnectionChecker>(
    () => InternetConnectionChecker(),
  );
  sl.registerLazySingleton<NetworkInfoImpl>(
    () => NetworkInfoImpl(connectionChecker: sl<InternetConnectionChecker>()),
  );
}