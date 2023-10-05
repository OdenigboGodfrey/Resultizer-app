import 'package:date_picker_timeline/extra/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:provider/provider.dart';
import 'package:resultizer_merged/features/home/data/models/bet_model_dto.dart';
import 'package:resultizer_merged/features/home/data/models/premier_game_dto.dart';
import 'package:resultizer_merged/features/match_detail/data/models/fixture_teams_dto.dart';
import 'package:resultizer_merged/features/match_detail/presentation/cubit/fixture_cubit.dart';
import 'package:resultizer_merged/features/match_detail/presentation/widgets/fixture_details.dart';
import 'package:resultizer_merged/features/match_detail/presentation/widgets/odd_accordion.dart';
import 'package:resultizer_merged/theme/themenotifer.dart';
import 'package:resultizer_merged/utils/constant/app_color.dart';
import 'package:resultizer_merged/utils/constant/app_string.dart';

class FixtureScreen extends StatefulWidget {
  // final SoccerFixture soccerFixture;

  // const FixtureScreen({Key? key, required this.soccerFixture})
  //     : super(key: key);
  const FixtureScreen(
      {Key? key,
      required this.leagueName,
      required this.leagueLogo,
      required this.leagueSubtitle,
      required this.game})
      : super(key: key);

  final String leagueName;
  final String leagueLogo;
  final String leagueSubtitle;

  final PremierGameDTO game;

  @override
  State<FixtureScreen> createState() => _FixtureScreenState();
}

class _FixtureScreenState extends State<FixtureScreen> {
  ColorNotifire notifire = ColorNotifire();

  @override
  Widget build(BuildContext context) {
    FixtureCubit cubit = context.read<FixtureCubit>();
    notifire = Provider.of<ColorNotifire>(context, listen: true);
    Size size = MediaQuery.of(context).size;
    double height = size.height;
    double width = size.width;
    PremierGameDTO game = widget.game;
    // game.odds = [
    //   OddsModel(id: 0, name: '1x2', odds: [
    //     OddValue(
    //         value: 'home',
    //         odd: '1.5',
    //         handicap: false,
    //         main: false,
    //         suspended: false),
    //     OddValue(
    //         value: 'draw',
    //         odd: '3.5',
    //         handicap: false,
    //         main: false,
    //         suspended: false),
    //     OddValue(
    //         value: 'away',
    //         odd: '2.0',
    //         handicap: false,
    //         main: false,
    //         suspended: false),
    //   ])
    // ];

    List<String> goals =
        game.goals != null ? game.goals.toString().split(":") : ['0', '0'];
    int homeGoals = int.tryParse(goals[0]) ?? 0;
    int awayGoals = int.tryParse(goals[1]) ?? 0;

    int whoIsWinner =
        (homeGoals > awayGoals) ? 1 : ((homeGoals < awayGoals) ? 2 : 0);

    return BlocBuilder<FixtureCubit, FixtureState>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: notifire.bgcolore,
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            actionsIconTheme: IconThemeData(color: notifire.reverseBgColore),
            backgroundColor: notifire.bgcolore,
            leading: GestureDetector(
              onTap: () => Get.back(),
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
                      goals: goals[0],
                      logo: game.homeLogo,
                      name: game.homeTeam,
                      winner: whoIsWinner == 1),
                  awayTeam: FixtureTeam(
                      id: 0,
                      goals: goals[1],
                      logo: game.awayLogo,
                      name: game.awayTeam,
                      winner: whoIsWinner == 2),
                  fixtureStatusElapsed: game.gameCurrentTime.toString()),
              buildTabBar(cubit),
              if (state is FixtureStatisticsLoading ||
                  state is FixtureLineupsLoading ||
                  state is FixtureEventsLoading)
                const SizedBox(
                  width: 100,
                  height: 100,
                ),
              //   LinearProgressIndicator(
              //     color: getColor(soccerFixture),
              //   ),
              if (state is FixtureStatisticsLoaded)
                const SizedBox(
                  width: 100,
                  height: 100,
                ),
              //   StatisticsView(statistics: state.statistics),
              if (state is FixtureLineupsLoaded)
                const SizedBox(
                  width: 100,
                  height: 100,
                ),
              //   LineupsView(lineups: state.lineups),
              if (state is FixtureEventsLoaded)
                const SizedBox(
                  width: 100,
                  height: 100,
                ),
              //   EventsView(
              //     events: state.events,
              //     color: getColor(soccerFixture),
              //   ),
              if (state is FixtureOddsActive && state.status)
                OddAccordion(
                  oddsData: game.odds,
                ),
              // Container()
              // Column(children: [
              // for(var odd in game.odds)
              //     // Text('Odd ${odd.name} - ${odd.odds[0]}: ${odd.odds[1]}...')

              // ],)
            ],
          ),
        );
      },
    );
  }

  Widget buildTabBar(FixtureCubit cubit) => Row(
        children: [
          Expanded(
            child: tabBarButton(
              label: AppString.statistics,
              onPressed: () async {
                notifire.isavalable(!notifire.isDark);
                if (widget.game.matchStatus != "NS") {
                  await cubit.getStatistics(widget.game.fixtureId.toString());
                } else {
                  Fluttertoast.showToast(
                      msg: AppString.noStats,
                      backgroundColor: AppColor.blackColor);
                }
              },
            ),
          ),
          Expanded(
            child: tabBarButton(
              label: AppString.lineups,
              onPressed: () async {
                await cubit.getLineups(widget.game.fixtureId.toString());
              },
            ),
          ),
          Expanded(
            child: tabBarButton(
              label: AppString.events,
              onPressed: () async {
                if (widget.game.matchStatus != "NS") {
                  await cubit.getEvents(widget.game.fixtureId.toString());
                } else {
                  Fluttertoast.showToast(
                      msg: AppString.noEvents,
                      backgroundColor: AppColor.blackColor);
                }
              },
            ),
          ),
          Expanded(
            child: tabBarButton(
              label: AppString.odds,
              onPressed: () async {
                cubit.emitOddsBar();
              },
            ),
          ),
        ],
      );

  Widget tabBarButton(
          {required String label, required void Function()? onPressed}) =>
      MaterialButton(
        onPressed: onPressed,
        color: getColor(1 == 2),
        elevation: 0.0,
        padding: const EdgeInsets.all(16),
        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
        child: Text(label, style: const TextStyle(color: AppColor.offWhite)),
      );
}

// Color getColor(SoccerFixture fixture) {
Color getColor(bool isGoalEqual) {
  Color color = Colors.black;
  if (isGoalEqual) {
    color = Colors.red;
  }
  return color;
}
