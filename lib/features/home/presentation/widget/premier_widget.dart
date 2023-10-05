import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:resultizer_merged/core/widgets/custom_image.dart';
import 'package:resultizer_merged/features/home/data/models/league_event_dto.dart';
import 'package:resultizer_merged/features/home/data/models/premier_game_dto.dart';
import 'package:resultizer_merged/features/home/data/enum/premier_game_enum.dart';
import 'package:resultizer_merged/features/match_detail/presentation/screens/fixture_screen.dart';
import 'package:resultizer_merged/theme/themenotifer.dart';
import 'package:resultizer_merged/utils/constant/app_assets.dart';
import 'package:resultizer_merged/utils/constant/app_string.dart';
import 'package:resultizer_merged/view/home_view/premierleague.dart';

class PremierWidget extends StatefulWidget {
  PremierWidget(
      {super.key,
      required this.notifire,
      required this.onTap,
      required this.leagueEvent,
      required this.premierType});
  final ColorNotifire notifire;
  final LeagueEventDTO leagueEvent;
  final Function onTap;
  String premierType = 'LIVE';

  @override
  State<PremierWidget> createState() => _PremierWidgetState();
}

class _PremierWidgetState extends State<PremierWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 15),
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Column(
              children: [
                Container(
                  height: null,
                  decoration: BoxDecoration(
                    color: widget.notifire.insidecolor,
                    border: Border.all(
                        color: widget.notifire.borercolour, width: 1),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ListTile(
                        leading: ImageWithDefault(
                          defaultImageUri: 'assets/images/no_image.png',
                          imageUrl: widget.leagueEvent.leagueImage,
                          height: 30,
                          width: 30,
                        ),
                        title: Row(
                          children: [
                            // league title
                            Text(
                              widget.leagueEvent.leagueTitle,
                              style: TextStyle(
                                fontFamily: 'Urbanist_bold',
                                fontSize: 15,
                                fontWeight: FontWeight.w700,
                                color: widget.notifire.textcolore,
                              ),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                              softWrap: true,
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            const Icon(Icons.star,
                                color: Colors.amber, size: 13),
                          ],
                        ),
                        subtitle: Text(widget.leagueEvent.leagueSubTitle,
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              fontFamily: 'Urbanist-medium',
                              color: widget.notifire.textcolore,
                            ),
                            maxLines: 2,
                            softWrap: true),
                        trailing: Icon(
                          Icons.arrow_forward_ios_rounded,
                          size: 16,
                          color: widget.notifire.textcolore,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Divider(
                          height: 10,
                          thickness: 1,
                          color: widget.notifire.borercolour,
                        ),
                      ),
                      ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemCount: widget.leagueEvent.games.length,
                        itemBuilder: (context, index) {
                          if (widget.leagueEvent.games[index].matchStatus ==
                              AppString.ft) return Container();
                          return Column(
                            children: [
                              ListTile(
                                onTap: () {
                                  Get.to(FixtureScreen(leagueLogo: widget.leagueEvent.leagueImage, leagueName: widget.leagueEvent.leagueTitle, leagueSubtitle: widget.leagueEvent.leagueSubTitle, game: widget.leagueEvent.games[index], ));
                                },
                                leading: Text(
                                  widget.leagueEvent.games[index].matchStatus ==
                                          PremierGameStatusEnum.FT.toString()
                                      ? widget
                                          .leagueEvent.games[index].matchStatus
                                          .toString()
                                      : widget
                                          .leagueEvent.games[index].gameTime,
                                  style: TextStyle(
                                    fontFamily: 'Urbanist_bold',
                                    fontSize: 15,
                                    fontWeight: FontWeight.w700,
                                    color: widget.notifire.textcolore,
                                  ),
                                  maxLines: 2,
                                  softWrap: true,
                                ),
                                title: Column(
                                  children: [
                                    Row(
                                      children: [
                                        // Image.network(
                                        //   widget.leagueEvent.games[index].homeLogo,
                                        //   height: 26,
                                        //   width: 26,
                                        // ),
                                        ImageWithDefault(
                                          defaultImageUri:
                                              'assets/images/no_image.png',
                                          imageUrl: widget.leagueEvent
                                              .games[index].homeLogo,
                                          height: 30,
                                          width: 30,
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          widget.leagueEvent.games[index]
                                              .homeTeam,
                                          style: TextStyle(
                                            fontFamily: 'Urbanist_bold',
                                            fontSize: 15,
                                            fontWeight: FontWeight.w700,
                                            color: widget.notifire.textcolore,
                                          ),
                                          maxLines: 2,
                                          softWrap: true,
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      children: [
                                        // Image.asset(
                                        //   widget.leagueEvent.games[index].awayLogo,
                                        //   height: 26,
                                        //   width: 26,
                                        // ),
                                        // Image.network(
                                        //   widget.leagueEvent.games[index]
                                        //       .awayLogo,
                                        //   height: 26,
                                        //   width: 26,
                                        // ),
                                        ImageWithDefault(
                                          defaultImageUri:
                                              'assets/images/no_image.png',
                                          imageUrl: widget.leagueEvent
                                              .games[index].awayLogo,
                                          height: 30,
                                          width: 30,
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          widget.leagueEvent.games[index]
                                              .awayTeam,
                                          style: TextStyle(
                                            fontFamily: 'Urbanist_bold',
                                            fontSize: 15,
                                            fontWeight: FontWeight.w700,
                                            color: widget.notifire.textcolore,
                                          ),
                                          maxLines: 2,
                                          softWrap: true,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                trailing: RatingBar.builder(
                                  itemSize: 24,
                                  initialRating: 0,
                                  direction: Axis.horizontal,
                                  itemCount: 1,
                                  itemPadding: const EdgeInsets.symmetric(
                                      horizontal: 4.0),
                                  itemBuilder: (context, _) => const Image(
                                      image: AssetImage(AppAssets.stare)),
                                  onRatingUpdate: (rating) {},
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                child: Divider(
                                  height: 10,
                                  thickness: 1,
                                  color: widget.notifire.borercolour,
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
              ],
            ),
            Positioned(
              left: Get.width * 0.25,
              top: -18,
              child: Container(
                height: 34,
                width: 150,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color: Colors.deepOrange,
                ),
                child: Center(
                  child: Text(
                    widget.premierType,
                    style: const TextStyle(
                        fontFamily: 'Urbanist_bold',
                        fontWeight: FontWeight.w700,
                        color: Colors.white),
                  ),
                ),
              ),
            ),
          ],
        ),
      );
  }
}
