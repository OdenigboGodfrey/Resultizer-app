import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:resultizer_merged/bloc_observer.dart';
import 'package:resultizer_merged/container_injector.dart';
import 'package:resultizer_merged/features/account/domain/usecase/manage_chat_usecase.dart';
import 'package:resultizer_merged/features/account/domain/usecase/user_detail_usecase.dart';
import 'package:resultizer_merged/features/account/presentation/cubit/manage_chat_cubit.dart';
import 'package:resultizer_merged/features/account/presentation/cubit/user_detail_cubit.dart';
import 'package:resultizer_merged/features/auth/domain/use_cases/login_use_case.dart';
import 'package:resultizer_merged/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:resultizer_merged/features/games/domain/usecase/leagues_usercase.dart';
import 'package:resultizer_merged/features/games/domain/usecase/teams_usercase.dart';
import 'package:resultizer_merged/features/games/presentation/cubit/leagues_cubit.dart';
import 'package:resultizer_merged/features/games/presentation/cubit/teams_cubit.dart';
import 'package:resultizer_merged/features/home/domain/use_cases/competition_fixtures_usecase.dart';
import 'package:resultizer_merged/features/home/domain/use_cases/day_fixtures_usecase.dart';
import 'package:resultizer_merged/features/home/domain/use_cases/favourite_league_usecase.dart';
import 'package:resultizer_merged/features/home/domain/use_cases/favourite_matches_usecase.dart';
import 'package:resultizer_merged/features/home/domain/use_cases/favourite_teams_usecase.dart';
import 'package:resultizer_merged/features/home/domain/use_cases/fixture_detail_usecase.dart';
import 'package:resultizer_merged/features/home/domain/use_cases/live_fixtures_usecase.dart';
import 'package:resultizer_merged/features/home/domain/use_cases/team_fixtures_usecase.dart';
import 'package:resultizer_merged/features/home/presentation/cubit/chat_cubit.dart';
import 'package:resultizer_merged/features/home/presentation/cubit/favourites_cubit.dart';
import 'package:resultizer_merged/features/home/presentation/cubit/fixture_cubit.dart';
import 'package:resultizer_merged/features/home/presentation/cubit/live_games_cubit.dart';
import 'package:resultizer_merged/features/home/presentation/cubit/soccer_cubit.dart';
import 'package:resultizer_merged/features/splash_view/splash_view.dart';
import 'package:resultizer_merged/features/videos/domain/usecase/highlights_by_competiton_usecase.dart';
import 'package:resultizer_merged/features/videos/domain/usecase/highlights_by_team_usecase.dart';
import 'package:resultizer_merged/features/videos/domain/usecase/list_competitons_usecase.dart';
import 'package:resultizer_merged/features/videos/domain/usecase/list_teams_usecase.dart';
import 'package:resultizer_merged/features/videos/domain/usecase/recent_feeds_usecase.dart';
import 'package:resultizer_merged/features/videos/presentation/cubic/video_cubit.dart';
import 'package:resultizer_merged/theme/themenotifer.dart';
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
            create: (context) => SoccerCubit(sl<DayFixturesUseCase>(),
                sl<TeamFixturesUseCase>(), sl<CompetitionFixturesUseCase>())),
        BlocProvider<LiveGamesCubit>(
            create: (context) => LiveGamesCubit(sl<LiveGamesUseCase>())),
        BlocProvider<FixtureCubit>(
            create: (context) =>
                FixtureCubit(fixtureDetailUseCase: sl<FixtureDetailUseCase>())),
        BlocProvider<ScorebatCubit>(
            create: (context) => ScorebatCubit(
                  sl<RecentFeedsUseCase>(),
                  sl<HighlightByCompetitionUseCase>(),
                  sl<HighlightByTeamUseCase>(),
                  sl<ListTeamsUseCase>(),
                  sl<ListCompetitionUseCase>(),
                )),
        BlocProvider<LeagueCubit>(
            create: (context) => LeagueCubit(sl<LeagueUseCase>())),
        BlocProvider<TeamsCubit>(
            create: (context) => TeamsCubit(sl<TeamsUseCase>())),
        BlocProvider<FavouritesCubit>(
            create: (context) => FavouritesCubit(
                  setFavouriteTeamsUseCase: sl<SetFavouriteTeamsUseCase>(),
                  getFavouriteTeamsUseCase: sl<GetFavouriteTeamsUseCase>(),
                  setFavouriteLeagueUseCase: sl<SetFavouriteLeagueUseCase>(),
                  getFavouriteLeagueUseCase: sl<GetFavouriteLeagueUseCase>(),
                  removeFavouriteTeamsUseCase:
                      sl<RemoveFavouriteTeamsUseCase>(),
                  removeFavouriteLeagueUseCase:
                      sl<RemoveFavouriteLeagueUseCase>(),
                  setFavouriteMatchesUseCase: sl<SetFavouriteMatchesUseCase>(),
                  getFavouriteMatchesUseCase: sl<GetFavouriteMatchesUseCase>(),
                  removeFavouriteMatchesUseCase:
                      sl<RemoveFavouriteMatchesUseCase>(),
                )),
        BlocProvider<ChatCubit>(create: (context) => ChatCubit()),
        BlocProvider<UserDetailCubit>(
            create: (context) => UserDetailCubit(
                sl<FetchUserDetailUseCase>(), sl<UpdateUserDetailUseCase>())),
        BlocProvider<ManageChatCubit>(
            create: (context) => ManageChatCubit(
                  countChatUseCase: sl<CountChatUseCase>(),
                  getAllChatMetaUseCase: sl<GetAllChatMetaUseCase>(),
                  deleteChatUseCase:  sl<DeleteChatUseCase>(),
                  deleteChatMetaUseCase:  sl<DeleteChatMetaUseCase>(),
                )),
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
        home: SplashScreenView(),
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
