import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:resultizer_merged/core/utils/app_utils.dart';
import 'package:resultizer_merged/features/home/data/models/fixture_teams_dto.dart';
import 'package:resultizer_merged/features/home/presentation/cubit/soccer_cubit.dart';
import 'package:resultizer_merged/features/home/presentation/cubit/soccer_state.dart';
import 'package:resultizer_merged/theme/themenotifer.dart';

class TeamStatsWidget extends StatefulWidget {
  // final int homeTeamId;
  // final int awayTeamId;
  final FixtureTeam homeFixtureTeam;
  final FixtureTeam awayFixtureTeam;
  final int leagueId;

  const TeamStatsWidget({
    super.key,
    required this.homeFixtureTeam,
    required this.awayFixtureTeam,
    required this.leagueId,
  });

  @override
  State<TeamStatsWidget> createState() => _TeamStatsWidgetState();
}

class _TeamStatsWidgetState extends State<TeamStatsWidget> {
  ColorNotifire notifire = ColorNotifire();
  late FixtureTeam homeFixtureTeam;
  late FixtureTeam awayFixtureTeam;
  late List<Map<String, List<int>>> oldResult = [];
  // late Map<String, List<int>> result = {};
  Map<String, List<String>> teamsForm = {};

  late SoccerCubit cubit;

  @override
  void initState() {
    super.initState();
    getStats();
  }

  getStats() async {
    cubit = context.read<SoccerCubit>();
    homeFixtureTeam = widget.homeFixtureTeam;
    awayFixtureTeam = widget.awayFixtureTeam;
    await cubit.fetchTeamStatistics(
        homeFixtureTeam.id, awayFixtureTeam.id, widget.leagueId);
  }

  @override
  Widget build(BuildContext context) {
    notifire = Provider.of<ColorNotifire>(context, listen: true);
    Size size = MediaQuery.of(context).size;
    double height = size.height;
    double width = size.width;
    cubit = context.read<SoccerCubit>();

    homeFixtureTeam = widget.homeFixtureTeam;
    awayFixtureTeam = widget.awayFixtureTeam;
    return BlocConsumer<SoccerCubit, SoccerStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return Container(
            padding: const EdgeInsets.all(5),
            child: Column(
              children: [
                if (state is TeamStatsLoading)
                  const Padding(padding: EdgeInsets.only(top: 20), child: CircularProgressIndicator()),
                if (state is! TeamStatsLoading)
                  Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.only(top: 2.5, bottom: 2.5),
                        child: Row(
                          children: [
                            const Expanded(flex: 3, child: SizedBox()),
                            Expanded(
                                flex: 4,
                                child: Text(
                                  homeFixtureTeam.name!,
                                  textAlign: TextAlign.center,
                                )),
                            Expanded(
                                flex: 4,
                                child: Text(
                                  awayFixtureTeam.name!,
                                  textAlign: TextAlign.center,
                                )),
                          ],
                        ),
                      ),
                      Divider(
                        color: notifire.textcolore,
                        height: 2,
                      ),
                      // buildTeamFormStats(
                      //     height: height, width: width, item: cubit.teamsForm),
                      for (String key in cubit.teamsStats.keys)
                        buildTeamStatsItem(
                          height: height,
                          width: width,
                          item: {key: cubit.teamsStats[key]!},
                        ),
                      const SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
              ],
            ),
          );
        });
  }

  // , title, int homeValue = 0, int awayValue = 0
  Widget buildTeamStatsItem(
      {width, height, required Map<String, Map<String, List<dynamic>>> item}) {
    var key = '';
    if (item.keys.firstOrNull != null) {
      key = item.keys.first;
    }
    var homeValue = item[key] != null ? item[key]!['data']![0] : 0;
    var awayValue = item[key] != null ? item[key]!['data']![1] : 0;

    var inverseColourType = false;
    if ( item[key]!['inverseColourType'] != null && item[key]!['inverseColourType']![0]) {
       inverseColourType = true;
    }

    var renderGreen = !inverseColourType ? Colors.green[300] : Colors.red[300];
    var renderRed = !inverseColourType ? Colors.red[300] : Colors.green[300];
    

    var homeValueColour = (homeValue == awayValue)
        ? notifire.textcolore
        : (homeValue > awayValue ? renderGreen : renderRed);
    var awayValueColour = (homeValue == awayValue)
        ? notifire.textcolore
        : (homeValue < awayValue ? renderGreen : renderRed);

    return Column(
      children: [
        SizedBox(
          height: 50,
          width: width,
          child: ListTile(
            contentPadding: const EdgeInsets.symmetric(horizontal: 2),
            leading: SizedBox(
              width: 0.3 * width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(key,
                      style: TextStyle(
                        fontFamily: 'Urbanist_bold',
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        color: notifire.textcolore,
                      ))
                ],
              ),
            ),
            title: SizedBox(
              width: 0.8 * width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    flex: 1,
                    child: Text(
                      homeValue.toString(),
                      style: TextStyle(
                        fontFamily: 'Urbanist_bold',
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                        color: homeValueColour,
                      ),
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      softWrap: true,
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Text(
                      awayValue.toString(),
                      style: TextStyle(
                        fontFamily: 'Urbanist_bold',
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                        color: awayValueColour,
                      ),
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      softWrap: true,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        Divider(
          color: notifire.textcolore,
          height: 2,
        ),
      ],
    );
  }

  Widget buildTeamFormStats(
      {width, height, required Map<String, List<String>> item}) {
    if (item.isEmpty) {
      return SizedBox(
        height: 50,
        width: width,
      );
    }
    var key = item.keys.first;
    int homeValueWinCount = countWordOccurrences(
        (item[key] != null ? item[key]![0] : '-').toUpperCase(), 'W');
    int awayValueWinCount = countWordOccurrences(
        (item[key] != null ? item[key]![1] : '-').toUpperCase(), 'W');
    
    var homeValueColour = (homeValueWinCount == awayValueWinCount)
        ? notifire.textcolore
        : (homeValueWinCount > awayValueWinCount ? Colors.green[300] : Colors.red[300]);
    var awayValueColour = (homeValueWinCount == awayValueWinCount)
        ? notifire.textcolore
        : (homeValueWinCount < awayValueWinCount ? Colors.green[300] : Colors.red[300]);

    return Column(
      children: [
        SizedBox(
          height: 50,
          width: width,
          child: ListTile(
            contentPadding: const EdgeInsets.symmetric(horizontal: 2),
            leading: SizedBox(
              width: 0.3 * width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(key,
                      style: TextStyle(
                        fontFamily: 'Urbanist_bold',
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                      ))
                ],
              ),
            ),
            title: SizedBox(
              width: 0.8 * width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    flex: 1,
                    child: Text(
                      item[key]![0],
                      style: TextStyle(
                        fontFamily: 'Urbanist_bold',
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                        // color: notifire.textcolore,
                        color: homeValueColour,
                      ),
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      softWrap: true,
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Text(
                      item[key]![1],
                      style: TextStyle(
                        fontFamily: 'Urbanist_bold',
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                        // color: notifire.textcolore,
                        color: awayValueColour,
                      ),
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      softWrap: true,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        Divider(
          color: notifire.textcolore,
          height: 2,
        ),
      ],
    );
  }
}
