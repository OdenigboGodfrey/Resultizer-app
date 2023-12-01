import 'package:date_picker_timeline/extra/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:provider/provider.dart';
import 'package:resultizer_merged/common/common_appbar.dart';
import 'package:resultizer_merged/features/home/data/models/bet_model_dto.dart';
import 'package:resultizer_merged/features/home/data/models/fixture_teams_dto.dart';
import 'package:resultizer_merged/features/home/data/models/premier_game_dto.dart';
import 'package:resultizer_merged/features/home/presentation/cubit/fixture_cubit.dart';
import 'package:resultizer_merged/features/home/presentation/widget/events_view.dart';
import 'package:resultizer_merged/features/home/presentation/widget/fixture_details.dart';
import 'package:resultizer_merged/features/home/presentation/widget/lineups_view.dart';
import 'package:resultizer_merged/features/home/presentation/widget/odd_accordion.dart';
import 'package:resultizer_merged/features/home/presentation/widget/statistics_view.dart';
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
      required this.game});

  final String leagueName;
  final String leagueLogo;
  final String leagueSubtitle;

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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchData();
  }

  Future fetchData() async {
      FixtureCubit cubit = context.read<FixtureCubit>();
      if (widget.game.matchStatus != "NS") {
        await cubit.getStatistics(widget.game.fixtureId!);
      }
    }

  @override
  Widget build(BuildContext context) {
    FixtureCubit cubit = context.read<FixtureCubit>();
    notifire = Provider.of<ColorNotifire>(context, listen: true);
    Size size = MediaQuery.of(context).size;
    double height = size.height;
    double width = size.width;

    PremierGameDTO game = widget.game;

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
          resizeToAvoidBottomInset: false,
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
                // const SizedBox(
                //   width: 100,
                //   height: 100,
                // ),
                LinearProgressIndicator(
                  color: currentColor,
                ),
              if (state is FixtureStatisticsLoaded)
                // Container(
                //   width: 100,
                //   height: 100,
                // ),
                StatisticsView(statistics: cubit.statistics),
              if (state is FixtureLineupsLoaded)
                // Container(
                //   width: 100,
                //   height: 100,
                // ),
                LineupsView(lineups: cubit.lineups),
              if (state is FixtureEventsLoaded)
                // const SizedBox(
                //   width: 100,
                //   height: 100,
                // ),
                EventsView(
                  events: cubit.events.isNotEmpty
                      ? cubit.events.reversed.toList()
                      : [],
                  color: currentColor,
                ),
              if (state is FixtureOddsActive && state.status)
                OddAccordion(
                  oddsData: game.odds,
                ),
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
                if (widget.game.matchStatus != "NS") {
                  await cubit.getStatistics(widget.game.fixtureId!);
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
                await cubit.getLineups(widget.game.fixtureId!);
              },
            ),
          ),
          Expanded(
            child: tabBarButton(
              label: AppString.events,
              onPressed: () async {
                if (widget.game.matchStatus != "NS") {
                  await cubit.getEvents(widget.game.fixtureId!);
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
        color: currentColor,
        elevation: 0.0,
        padding: const EdgeInsets.all(16),
        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
        child: Text(label, style: const TextStyle(color: AppColor.offWhite)),
      );
}

// Color getColor(SoccerFixture fixture) {
Color getColor() {
  Color color = Colors.black;
  if (notifire.isDark) {
    color = AppColor.pinkColor;
  }
  return color;
}
