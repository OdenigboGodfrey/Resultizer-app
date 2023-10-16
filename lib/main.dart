import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:resultizer_merged/bloc_observer.dart';
import 'package:resultizer_merged/container_injector.dart';
import 'package:resultizer_merged/features/auth/domain/use_cases/login_use_case.dart';
import 'package:resultizer_merged/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:resultizer_merged/features/home/domain/use_cases/day_fixtures_usecase.dart';
import 'package:resultizer_merged/features/home/domain/use_cases/fixture_detail_usecase.dart';
import 'package:resultizer_merged/features/home/domain/use_cases/live_fixtures_usecase.dart';
import 'package:resultizer_merged/features/home/presentation/cubit/fixture_cubit.dart';
import 'package:resultizer_merged/features/home/presentation/cubit/live_games_cubit.dart';
import 'package:resultizer_merged/features/home/presentation/cubit/soccer_cubit.dart';
import 'package:resultizer_merged/features/videos/domain/usecase/recent_feeds_usecase.dart';
import 'package:resultizer_merged/features/videos/presentation/cubic/video_cubit.dart';
import 'package:resultizer_merged/theme/themenotifer.dart';
import 'package:resultizer_merged/view/on_boarding/on_boarding_view.dart';
import 'package:resultizer_merged/view/splash_view/splash_view.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:resultizer_merged/firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  initApp();
  Bloc.observer = MyBlocObserver();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthCubit>(
            create: (context) => AuthCubit(loginUseCase: sl<LoginUseCase>())),
        BlocProvider<SoccerCubit>(
            create: (context) => SoccerCubit(sl<DayFixturesUseCase>())),
        BlocProvider<LiveGamesCubit>(
            create: (context) => LiveGamesCubit(sl<LiveGamesUseCase>())),
        BlocProvider<FixtureCubit>(
            create: (context) => FixtureCubit(fixtureDetailUseCase:  sl<FixtureDetailUseCase>())),
        BlocProvider<RecentFeedsCubit>(
            create: (context) => RecentFeedsCubit(sl<RecentFeedsUseCase>())),
        MultiProvider(providers: [
          ChangeNotifierProvider(
            create: (context) => ColorNotifire(),
          )
        ])
      ],
      child: const GetMaterialApp(
        title: "resultizer",
        debugShowCheckedModeBanner: false,
        // theme: ThemeData(
        //   colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
        //   useMaterial3: true,
        // ),
        home: SplashView(),
      ),
    );

    return MultiProvider(
      providers: [
        MultiProvider(providers: [
          ChangeNotifierProvider(
            create: (context) => ColorNotifire(),
          )
        ])
      ],
      child: GetMaterialApp(
          title: "resultizer",
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
            useMaterial3: true,
          ),
          // home: const SplashView(),
          home: MultiBlocProvider(
            providers: [
              BlocProvider<AuthCubit>(
                  create: (context) =>
                      AuthCubit(loginUseCase: sl<LoginUseCase>())),
            ],
            child: SplashView(),
          )),
    );
  }
}
