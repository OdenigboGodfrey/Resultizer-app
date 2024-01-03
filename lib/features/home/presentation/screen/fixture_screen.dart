import 'package:date_picker_timeline/extra/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:provider/provider.dart';
import 'package:resultizer_merged/common/common_appbar.dart';
import 'package:resultizer_merged/core/utils/app_sizes.dart';
import 'package:resultizer_merged/features/account/data/models/chat_item_dto.dart';
import 'package:resultizer_merged/features/home/data/models/bet_model_dto.dart';
import 'package:resultizer_merged/features/home/data/models/fixture_teams_dto.dart';
import 'package:resultizer_merged/features/home/data/models/premier_game_dto.dart';
import 'package:resultizer_merged/features/home/presentation/cubit/fixture_cubit.dart';
import 'package:resultizer_merged/features/home/presentation/cubit/soccer_state.dart';
import 'package:resultizer_merged/features/home/presentation/widget/chat/chats_view.dart';
import 'package:resultizer_merged/features/home/presentation/widget/events_view.dart';
import 'package:resultizer_merged/features/home/presentation/widget/fixture_details.dart';
import 'package:resultizer_merged/features/home/presentation/widget/lineups_view.dart';
import 'package:resultizer_merged/features/home/presentation/widget/odd_accordion.dart';
import 'package:resultizer_merged/features/home/presentation/widget/statistics_view.dart';
import 'package:resultizer_merged/features/home/presentation/widget/team_stats_widget.dart';
import 'package:resultizer_merged/theme/themenotifer.dart';
import 'package:resultizer_merged/utils/constant/app_color.dart';
import 'package:resultizer_merged/utils/constant/app_string.dart';

class FixtureScreen extends StatefulWidget {
  // final SoccerFixture soccerFixture;

  // const FixtureScreen({Key? key, required this.soccerFixture})
  //     : super(key: key);
  const FixtureScreen(
      {super.key,
      required this.leagueName,
      required this.leagueLogo,
      required this.leagueSubtitle,
      required this.game,
      required this.leagueId});

  final String leagueName;
  final String leagueLogo;
  final String leagueSubtitle;
  final int leagueId;

  final PremierGameDTO game;

  @override
  State<FixtureScreen> createState() => _FixtureScreenState();
}

class _FixtureScreenState extends State<FixtureScreen> {
  ColorNotifire notifire = ColorNotifire();
  List<String> goals = ['0', '0'];
  int homeGoals = 0;
  int awayGoals = 0;
  int whoIsWinner = 0;
  Color currentColor = Colors.transparent;
  Color activeColor = AppColor.pinkColor;
  late PremierGameDTO _game;
  List<OddsModel> _odds = [];
  int activeTab = 1;

  @override
  void initState() {
    super.initState();
    _game = widget.game;
    fetchData();
  }

  late FixtureCubit cubit;

  Future updateData() async {
    if (_game.matchTime.isBefore(DateTime.now())) {
      // _game.matchStatus =
      cubit.getStatistics(_game.fixtureId!).then((value) {
        _game = cubit.generatePremierGame();
        if (_game.odds.isNotEmpty) _odds = _game.odds;
        setState(() {});
      });
    }
  }

  Future fetchData() async {
    cubit = context.read<FixtureCubit>();
    _odds = _game.odds;
    updateData();
    cubit.emitTeamStats();
  }

  late double width, height;

  @override
  Widget build(BuildContext context) {
    FixtureCubit cubit = context.read<FixtureCubit>();
    notifire = Provider.of<ColorNotifire>(context, listen: true);
    Size size = MediaQuery.of(context).size;
    width = size.width;
    height = size.height;

    PremierGameDTO game = _game;

    goals = game.goals != null ? game.goals.toString().split(":") : goals;
    homeGoals = int.tryParse(goals[0]) ?? 0;
    awayGoals = int.tryParse(goals[1]) ?? 0;

    whoIsWinner =
        (homeGoals > awayGoals) ? 1 : ((homeGoals < awayGoals) ? 2 : 0);
    currentColor = getColor();

    return BlocBuilder<FixtureCubit, FixtureState>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: notifire.bgcolore,
          resizeToAvoidBottomInset: true,
          appBar: AppBar(
            actionsIconTheme: IconThemeData(color: notifire.reverseBgColore),
            backgroundColor: notifire.bgcolore,
            leading: GestureDetector(
              onTap: () {
                cubit.reset();
                Get.back();
              },
              child: Icon(Icons.arrow_back, color: notifire.textcolore),
            ),
            title: Text(
              "${game.homeTeam} ${AppString.vs} ${game.awayTeam}",
              style: TextStyle(color: notifire.textcolore),
            ),
          ),
          body: ListView(
            physics: const BouncingScrollPhysics(),
            children: [
              FixtureDetails(
                  fixtureLeagueName: widget.leagueName,
                  fixtureLeagueLogo: widget.leagueLogo,
                  fixtureLeagueSubtitle: widget.leagueSubtitle,
                  fixtureStatusLong: game.matchStatusLong.toString(),
                  fixtureDate: game.gameTime.toString(),
                  homeTeam: FixtureTeam(
                      id: 0,
                      goals: homeGoals.toString(),
                      logo: game.homeLogo,
                      name: game.homeTeam,
                      winner: whoIsWinner == 1),
                  awayTeam: FixtureTeam(
                      id: 0,
                      goals: awayGoals.toString(),
                      logo: game.awayLogo,
                      name: game.awayTeam,
                      winner: whoIsWinner == 2),
                  fixtureStatusElapsed: game.gameCurrentTime.toString()),
              buildTabBar(cubit),
              if (state is FixtureStatisticsLoading ||
                  state is FixtureLineupsLoading ||
                  state is FixtureEventsLoading)
                // const SizedBox(
                //   width: 100,
                //   height: 100,
                // ),
                LinearProgressIndicator(
                  color: currentColor,
                ),
              if (state is FixtureChatActive && state.status)
                SizedBox(
                  height: height * 0.62,
                  child: ChatView(
                      chatMeta: ChatMetaDTO(
                    homeTeam: game.homeTeam,
                    awayTeam: game.awayTeam,
                    homeTeamLogo: game.homeLogo,
                    awayTeamLogo: game.awayLogo,
                    leagueName: widget.leagueName,
                    matchTime: game.matchTime,
                    fixtureId: _game.fixtureId!,
                    leagueLogo: widget.leagueLogo,
                    leagueSubtitle: widget.leagueSubtitle,
                    homeTeamId: game.homeTeamId,
                    awayTeamId: game.awayTeamId,
                    leagueId: widget.leagueId,
                  )),
                ),
              if (state is FixtureStatisticsLoaded &&
                  cubit.statistics.isNotEmpty)
                StatisticsView(statistics: cubit.statistics),
              if (state is FixtureStatisticsLoadingFailure ||
                  (state is FixtureStatisticsLoaded &&
                      cubit.statistics.isEmpty))
                // if (state is FixtureStatisticsLoadingFailure)
                TeamStatsWidget(
                  homeFixtureTeam: FixtureTeam(
                      id: game.homeTeamId,
                      name: game.homeTeam,
                      logo: game.homeLogo),
                  awayFixtureTeam: FixtureTeam(
                      id: game.awayTeamId,
                      name: game.awayTeam,
                      logo: game.awayLogo),
                  leagueId: widget.leagueId,
                ),
              if (state is TeamStatsLoadingFailure)
                SizedBox(
                  height: context.height / 2,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(height: AppSize.s10),
                      Text(
                        AppString.noStats,
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium
                            ?.copyWith(
                                color: notifire.textcolore, letterSpacing: 1.1),
                      ),
                    ],
                  ),
                ),
              // SizedBox(
              //   height: context.height / 2,
              //   child: Column(
              //     mainAxisAlignment: MainAxisAlignment.center,
              //     children: [
              //       const SizedBox(height: AppSize.s10),
              //       Text(
              //         AppString.noStats,
              //         style: Theme.of(context).textTheme.titleMedium?.copyWith(
              //             color: notifire.textcolore, letterSpacing: 1.1),
              //       ),
              //     ],
              //   ),
              // ),
              if (state is FixtureLineupsLoaded)
                LineupsView(lineups: cubit.lineups),
              if (state is FixtureLineupsLoadingFailure)
                SizedBox(
                  height: context.height / 2,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(height: AppSize.s10),
                      Text(
                        AppString.noLineUp,
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium
                            ?.copyWith(
                                color: notifire.textcolore, letterSpacing: 1.1),
                      ),
                    ],
                  ),
                ),
              if (state is FixtureEventsLoaded && cubit.events.isNotEmpty)
                EventsView(
                  events: cubit.events.reversed.toList(),
                  color: currentColor,
                ),
              if (state is FixtureEventsLoadingFailure ||
                  (state is FixtureEventsLoaded && cubit.events.isEmpty))
                SizedBox(
                  height: context.height / 2,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(height: AppSize.s10),
                      Text(
                        AppString.noEvents,
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium
                            ?.copyWith(
                                color: notifire.textcolore, letterSpacing: 1.1),
                      ),
                    ],
                  ),
                ),
              if (state is FixtureOddsActive &&
                  state.status &&
                  _odds.isNotEmpty)
                OddAccordion(
                  oddsData: _odds,
                ),
              if (state is FixtureOddsActive && _odds.isEmpty)
                SizedBox(
                  height: context.height / 2,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(height: AppSize.s10),
                      Text(
                        AppString.noOdds,
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium
                            ?.copyWith(
                                color: notifire.textcolore, letterSpacing: 1.1),
                      ),
                    ],
                  ),
                ),
              if (state is FixtureTeamStatsActive && state.status)
                TeamStatsWidget(
                  homeFixtureTeam: FixtureTeam(
                      id: game.homeTeamId,
                      name: game.homeTeam,
                      logo: game.homeLogo),
                  awayFixtureTeam: FixtureTeam(
                      id: game.awayTeamId,
                      name: game.awayTeam,
                      logo: game.awayLogo),
                  leagueId: widget.leagueId,
                ),
            ],
          ),
        );
      },
    );
  }

  Widget buildTabBar(FixtureCubit cubit) {
    double builderWidth = 150 * 4;
    if (_game.matchStatus != "NS") builderWidth = 150 * 5; 
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Container(
        width: builderWidth,
        child: Row(
          children: [
            tabBarButton(
              label: AppString.chats,
              onPressed: () async {
                setState(() {
                  activeTab = 0;
                });
                cubit.emitChatBar();
              },
              colour: activeTab == 0 ? activeColor : null,
            ),
            // Expanded(
            //   child: tabBarButton(
            //     label: AppString.teamInfo,
            //     onPressed: () async {
            //       setState(() {
            //         activeTab = 1;
            //       });
            //       cubit.emitTeamStats();
            //     },
            //     colour: activeTab == 1 ? activeColor : null,
            //   ),
            // ),
            tabBarButton(
              label: AppString.statistics,
              onPressed: () async {
                setState(() {
                  activeTab = 1;
                });
                await cubit.getStatistics(_game.fixtureId!);
              },
              colour: activeTab == 1 ? activeColor : null,
            ),
            tabBarButton(
              label: AppString.odds,
              onPressed: () async {
                setState(() {
                  activeTab = 2;
                });
                cubit.emitOddsBar();
              },
              colour: activeTab == 2 ? activeColor : null,
            ),
            tabBarButton(
              label: AppString.lineups,
              onPressed: () async {
                setState(() {
                  activeTab = 3;
                });
                await cubit.getLineups(_game.fixtureId!);
              },
              colour: activeTab == 3 ? activeColor : null,
            ),
            if (_game.matchStatus != 'NS')
              tabBarButton(
                label: AppString.events,
                onPressed: () async {
                  setState(() {
                    activeTab = 4;
                  });
                  await cubit.getEvents(_game.fixtureId!);
                },
                colour: activeTab == 4 ? activeColor : null,
              ),
          ],
        ),
      ),
    );
  }

  Widget tabBarButton(
      {required String label,
      required void Function()? onPressed,
      Color? colour}) {
        double width = 150;
    return SizedBox(
      width: width,
      // color: Colors.red,
      child: MaterialButton(
        onPressed: onPressed,
        color: colour ?? currentColor,
        elevation: 0.0,
        padding: const EdgeInsets.all(16),
        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
        minWidth: width,
        child: Text(label, style: const TextStyle(color: AppColor.offWhite)),
      ),
    );
  }
}

// Color getColor(SoccerFixture fixture) {
Color getColor() {
  Color color = Colors.black;
  if (notifire.isDark) {
    color = AppColor.pinkColor;
  }
  return color;
}
