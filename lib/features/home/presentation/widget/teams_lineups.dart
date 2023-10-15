import 'package:flutter/material.dart';
// import 'package:hexcolor/hexcolor.dart';
import 'package:resultizer_merged/features/home/data/models/lineup_dto.dart';
import 'package:resultizer_merged/features/home/data/models/lineup_player.dart';
import 'package:resultizer_merged/utils/constant/app_color.dart';


class TeamsLineups extends StatelessWidget {
  final List<Lineup> lineups;

  const TeamsLineups({Key? key, required this.lineups}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<String> teamOnePlan = lineups[0].formation.split("-");
    Iterable<String> teamTwoPlan = lineups[1].formation.split("-").reversed;
    List<LineUpPlayer> teamOnePlayers = lineups[0].startXI;
    Iterable<LineUpPlayer> teamTwoPlayers = lineups[1].startXI.reversed;

    int lineOneNumber = 0;
    int lineTwoNumber = -1;

    return Column(
      children: [
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                children: [
                  CircleAvatar(
                    radius: 15,
                    backgroundColor: AppColor.offWhite,
                    child: CircleAvatar(
                      radius: 13,
                      backgroundColor:
                          HexColor.fromHex("#${lineups[0].team.colors.player.primary}"),
                      child: Text(
                        teamOnePlayers[0].number.toString(),
                        style: TextStyle(
                            color: HexColor.fromHex(
                                "#${lineups[0].team.colors.player.number}")),
                      ),
                    ),
                  ),
                  Text(
                    teamOnePlayers[0].name,
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium
                        ?.copyWith(color: AppColor.offWhite),
                  ),
                ],
              ),
              ListView.separated(
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                physics: const BouncingScrollPhysics(),
                separatorBuilder: (context, index) =>
                    const SizedBox(height: 10),
                itemBuilder: (context, index) => Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ...List.generate(
                      int.parse(teamOnePlan[index]),
                      (_) {
                        lineOneNumber++;
                        List<String> playerName =
                            teamOnePlayers[lineOneNumber].name.split(" ");
                        return Expanded(
                          child: Column(
                            children: [
                              CircleAvatar(
                                backgroundColor: AppColor.offWhite,
                                radius: 15,
                                child: CircleAvatar(
                                  radius: 13,
                                  backgroundColor: HexColor.fromHex(
                                      "#${lineups[0].team.colors.player.primary}"),
                                  child: Text(
                                    teamOnePlayers[lineOneNumber]
                                        .number
                                        .toString(),
                                    style: TextStyle(
                                      color: HexColor.fromHex(
                                          "#${lineups[0].team.colors.player.number}"),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 2),
                              Text(
                                playerName.length >= 3
                                    ? playerName[1] + playerName[2]
                                    : playerName.length == 2
                                        ? playerName[1]
                                        : playerName[0],
                                textAlign: TextAlign.center,
                                style: Theme.of(context).textTheme.bodySmall,
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ],
                ),
                itemCount: teamOnePlan.length,
              ),
            ],
          ),
        ),
        // const SizedBox(height: 80),
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ListView.separated(
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                physics: const BouncingScrollPhysics(),
                separatorBuilder: (context, index) =>
                    const SizedBox(height: 10),
                itemBuilder: (context, index) => Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ...List.generate(
                      int.parse(teamTwoPlan.elementAt(index)),
                      (_) {
                        lineTwoNumber++;
                        List<String> playerName = teamTwoPlayers
                            .elementAt(lineTwoNumber)
                            .name
                            .split(" ");
                        return Expanded(
                          child: Column(
                            children: [
                              CircleAvatar(
                                radius: 15,
                                backgroundColor: AppColor.offWhite,
                                child: CircleAvatar(
                                  radius: 13,
                                  backgroundColor: HexColor.fromHex(
                                    "#${lineups[1].team.colors.player.primary}",
                                  ),
                                  child: Text(
                                    teamTwoPlayers
                                        .elementAt(lineTwoNumber)
                                        .number
                                        .toString(),
                                    style: TextStyle(
                                        color: HexColor.fromHex(
                                            "#${lineups[1].team.colors.player.number}")),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 2),
                              Text(
                                playerName.length >= 3
                                    ? playerName[1] + playerName[2]
                                    : playerName.length == 2
                                        ? playerName[1]
                                        : playerName[0],
                                textAlign: TextAlign.center,
                                style: Theme.of(context).textTheme.bodySmall,
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ],
                ),
                itemCount: teamTwoPlan.length,
              ),
              Column(
                children: [
                  CircleAvatar(
                    radius: 15,
                    backgroundColor: AppColor.offWhite,
                    child: CircleAvatar(
                      radius: 13,
                      backgroundColor:
                          HexColor.fromHex("#${lineups[1].team.colors.player.primary}"),
                      child: Text(
                        teamTwoPlayers.elementAt(10).number.toString(),
                        style: TextStyle(
                            color: HexColor.fromHex(
                                "#${lineups[1].team.colors.player.number}")),
                      ),
                    ),
                  ),
                  Text(
                    teamTwoPlayers.elementAt(10).name,
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium
                        ?.copyWith(color: AppColor.offWhite),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
