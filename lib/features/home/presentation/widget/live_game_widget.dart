import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:resultizer_merged/core/utils/app_sizes.dart';
import 'package:resultizer_merged/core/utils/random_colour.dart';
import 'package:resultizer_merged/core/widgets/custom_image.dart';
import 'package:resultizer_merged/features/home/data/models/bet_model_dto.dart';
import 'package:resultizer_merged/features/home/data/models/league_event_dto.dart';
import 'package:resultizer_merged/features/home/data/models/premier_game_dto.dart';
import 'package:resultizer_merged/features/home/presentation/widget/match_odds_tile.dart';
import 'package:resultizer_merged/features/home/presentation/screen/fixture_screen.dart';
import 'package:resultizer_merged/utils/constant/app_assets.dart';
import 'package:resultizer_merged/utils/constant/app_color.dart';
import 'package:resultizer_merged/view/home_view/matchdtails.dart';

class LiveGameWidget extends StatefulWidget {
  LiveGameWidget({super.key, required this.leagueEvent});
  final LeagueEventDTO leagueEvent;

  @override
  State<LiveGameWidget> createState() =>
      _LiveGameWidgetState(leagueEvent: leagueEvent);
}

class _LiveGameWidgetState extends State<LiveGameWidget> {
  @override
  void initState() {
    super.initState();
    games = leagueEvent.games;
  }

  // widget values
  final double containerHeight = 380;
  final LeagueEventDTO leagueEvent;

  final double containerBorderRadius = 24;
  List<PremierGameDTO> games = [];

  _LiveGameWidgetState({required this.leagueEvent});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemCount: games.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              Get.to(FixtureScreen(
                  leagueName: widget.leagueEvent.leagueTitle,
                  leagueLogo: widget.leagueEvent.leagueImage,
                  leagueSubtitle: widget.leagueEvent.leagueSubTitle,
                  game: games[index]));
              // widget.onTap();
            },
            child: Stack(
              children: [
                Column(
                  children: [
                    Container(
                      // height: containerHeight,
                      padding: EdgeInsets.only(bottom: 10),
                      decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.circular(containerBorderRadius),
                        color: generateRandomDarkColor(),
                      ),
                      child: Column(
                        children: [
                          Stack(
                            children: [
                              // Center(child: Image.asset(AppAssets.union)),
                              Container(
                                height: containerHeight,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(
                                      containerBorderRadius),
                                ),
                                child: Center(
                                  child: Image.asset(AppAssets.union),
                                ),
                              ),
                              Container(
                                // height: containerHeight,
                                color: Colors.transparent,
                                // color: AppColor.yellow,
                                child: Center(
                                  child: Column(
                                    children: [
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      Text(
                                        widget.leagueEvent.leagueTitle,
                                        style: const TextStyle(
                                            fontFamily: 'Urbanist_bold',
                                            fontWeight: FontWeight.w700,
                                            fontSize: 24,
                                            color: Colors.white),
                                      ),
                                      Text(
                                        widget.leagueEvent.leagueSubTitle,
                                        style: const TextStyle(
                                            fontFamily: 'Urbanist_medium',
                                            fontWeight: FontWeight.w500,
                                            fontSize: 16,
                                            color: AppColor.greyColor),
                                      ),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          SizedBox(
                                            width: 120,
                                            child: Column(
                                              children: [
                                                // Image.asset(AppAssets.team3, height: 80,),
                                                ImageWithDefault(
                                                  defaultImageUri:
                                                      'assets/images/no_image.png',
                                                  imageUrl:
                                                      games[index].homeLogo,
                                                  height: 80,
                                                  width: null,
                                                ),
                                                Text(
                                                  games[index].homeTeam,
                                                  style: const TextStyle(
                                                      fontFamily:
                                                          'Urbanist_bold',
                                                      fontWeight:
                                                          FontWeight.w700,
                                                      fontSize: 18,
                                                      color: Colors.white),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Container(
                                            width: 120,
                                            child: Column(
                                              children: [
                                                Text(
                                                  games[index].goals.toString(),
                                                  style: const TextStyle(
                                                      fontFamily:
                                                          'Urbanist_bold',
                                                      fontWeight:
                                                          FontWeight.w700,
                                                      fontSize: 40,
                                                      color: Colors.white),
                                                ),
                                                Container(
                                                  height: 26,
                                                  width: 66,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            16),
                                                    border: Border.all(
                                                        color: Colors.white,
                                                        width: 2),
                                                  ),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Text(
                                                        games[index]
                                                                .gameCurrentTime ??
                                                            games[index]
                                                                .matchStatus, // widget.leagueEvent.liveGameTime,
                                                        style: const TextStyle(
                                                            fontFamily:
                                                                'Urbanist_bold',
                                                            fontWeight:
                                                                FontWeight.w700,
                                                            fontSize: 12,
                                                            color:
                                                                Colors.white),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Container(
                                            width: 120,
                                            child: Column(
                                              children: [
                                                // Image.asset(
                                                //   AppAssets.chelsea,
                                                //   height: 80,
                                                // ),
                                                ImageWithDefault(
                                                  defaultImageUri:
                                                      'assets/images/no_image.png',
                                                  imageUrl:
                                                      games[index].awayLogo,
                                                  height: 80,
                                                  width: null,
                                                ),
                                                Text(
                                                  games[index].awayTeam,
                                                  style: const TextStyle(
                                                      fontFamily:
                                                          'Urbanist_bold',
                                                      fontWeight:
                                                          FontWeight.w700,
                                                      fontSize: 18,
                                                      color: Colors.white),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                      if (games[index].odds.isNotEmpty)
                                        const Padding(
                                          padding: EdgeInsets.only(top: 5),
                                          child: Divider(
                                              color: AppColor.offWhite,
                                              thickness: 1.0),
                                        ),
                                      if (games[index].odds.isNotEmpty)
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(top: 5),
                                          child: MatchOddsTile(
                                              odds: games[index].odds),
                                        ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ],
            ),

            // ],
            // ),
          );
        });
  }
}
