
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:resultizer_merged/core/utils/convert_mediaQuery.dart';
import 'package:resultizer_merged/core/utils/random_colour.dart';
import 'package:resultizer_merged/core/widgets/custom_image.dart';
import 'package:resultizer_merged/core/widgets/expandDropDown.widget.dart';
import 'package:resultizer_merged/features/home/data/models/league_event_dto.dart';
import 'package:resultizer_merged/features/home/data/models/premier_game_dto.dart';
import 'package:resultizer_merged/features/home/presentation/widget/match_odds_tile.dart';
import 'package:resultizer_merged/features/home/presentation/screen/fixture_screen.dart';
import 'package:resultizer_merged/theme/colors.dart';
import 'package:resultizer_merged/theme/themenotifer.dart';
import 'package:resultizer_merged/utils/constant/app_assets.dart';
import 'package:resultizer_merged/utils/constant/app_color.dart';

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
  final LeagueEventDTO leagueEvent;

  final double containerBorderRadius = 24;
  List<PremierGameDTO> games = [];
  ColorNotifire notifire = ColorNotifire();

  _LiveGameWidgetState({required this.leagueEvent});

  @override
  Widget build(BuildContext context) {
    double containerHeight = 380;
    notifire = Provider.of<ColorNotifire>(context, listen: true);
    return Column(
      children: [
        ExpandDropDown(
          title: Container(
            padding: const EdgeInsets.all(8.0),
            color: notifire.isDark ? backgroundcolore: Colors.white,
            child: Row(
              children: [
                ImageWithDefault(
                  defaultImageUri: 'assets/images/no_image.png',
                  imageUrl: widget.leagueEvent.leagueImage,
                  height: ConvertToMediaQuery.convertHeightToMediaQuery(20, context),
                  width: null,
                ),
                const SizedBox(width: 20,),
                Text(
                    '${widget.leagueEvent.leagueTitle} ${widget.leagueEvent.leagueSubTitle}', style: TextStyle(color: notifire.textcolore),),
              ],
            ),
          ),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            color: notifire.isDark ? backgroundcolore: Colors.white,
            child: ListView.builder(
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
                          leagueId: widget.leagueEvent.leagueId,
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
                                              Padding(
                                                padding: const EdgeInsets.all(5.0),
                                                child: Text(
                                                  widget.leagueEvent.leagueTitle,
                                                  style: const TextStyle(
                                                      fontFamily: 'Urbanist_bold',
                                                      fontWeight: FontWeight.w700,
                                                      fontSize: 24,
                                                      color: Colors.white),
                                                ),
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
                                              // live child content
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.spaceAround,
                                                children: [
                                                  // home team
                                                  SizedBox(
                                                    width: ConvertToMediaQuery
                                                        .convertWidthToMediaQuery(
                                                            80, context),
                                                    child: Column(
                                                      children: [
                                                        // Image.asset(AppAssets.team3, height: 80,),
                                                        ImageWithDefault(
                                                          defaultImageUri:
                                                              'assets/images/no_image.png',
                                                          imageUrl:
                                                              games[index].homeLogo,
                                                          height: ConvertToMediaQuery
                                                              .convertHeightToMediaQuery(
                                                                  50, context),
                                                          width: null,
                                                        ),
                                                        Text(
                                                          games[index].homeTeam,
                                                          textAlign: TextAlign.center,
                                                          overflow:
                                                              TextOverflow.ellipsis,
                                                          maxLines: 2,
                                                          style: TextStyle(
                                                              fontFamily:
                                                                  'Urbanist_bold',
                                                              fontWeight:
                                                                  FontWeight.w700,
                                                              fontSize:
                                                                  ConvertToMediaQuery
                                                                      .convertFontSizeToMediaQuery(
                                                                          16,
                                                                          context),
                                                              color: Colors.white),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  // game info
                                                  SizedBox(
                                                    width: ConvertToMediaQuery
                                                        .convertWidthToMediaQuery(
                                                            80, context),
                                                    child: Column(
                                                      children: [
                                                        Text(
                                                          games[index]
                                                              .goals
                                                              .toString(),
                                                          style: TextStyle(
                                                              fontFamily:
                                                                  'Urbanist_bold',
                                                              fontWeight:
                                                                  FontWeight.w700,
                                                              fontSize:
                                                                  ConvertToMediaQuery
                                                                      .convertFontSizeToMediaQuery(
                                                                          20,
                                                                          context),
                                                              color: Colors.white),
                                                        ),
                                                        Container(
                                                          height: ConvertToMediaQuery
                                                              .convertHeightToMediaQuery(
                                                                  26, context),
                                                          width: ConvertToMediaQuery
                                                              .convertWidthToMediaQuery(
                                                                  66, context),
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
                                                                style: TextStyle(
                                                                    fontFamily:
                                                                        'Urbanist_bold',
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w700,
                                                                    fontSize: ConvertToMediaQuery
                                                                        .convertHeightToMediaQuery(
                                                                            12,
                                                                            context),
                                                                    color:
                                                                        Colors.white),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  // away team
                                                  SizedBox(
                                                    width: ConvertToMediaQuery
                                                        .convertWidthToMediaQuery(
                                                            80, context),
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
                                                          height: ConvertToMediaQuery
                                                              .convertHeightToMediaQuery(
                                                                  50, context),
                                                          width: null,
                                                        ),
                                                        Text(
                                                          games[index].awayTeam,
                                                          textAlign: TextAlign.center,
                                                          overflow:
                                                              TextOverflow.ellipsis,
                                                          maxLines: 2,
                                                          style: TextStyle(
                                                              fontFamily:
                                                                  'Urbanist_bold',
                                                              fontWeight:
                                                                  FontWeight.w700,
                                                              fontSize:
                                                                  ConvertToMediaQuery
                                                                      .convertFontSizeToMediaQuery(
                                                                          16,
                                                                          context),
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
                            SizedBox(
                              height: ConvertToMediaQuery.convertHeightToMediaQuery(
                                  10, context),
                            ),
                          ],
                        ),
                      ],
                    ),
          
                    // ],
                    // ),
                  );
                }),
          ),
        ),
        const SizedBox(height: 10,),
      ],
    );
  }
}
