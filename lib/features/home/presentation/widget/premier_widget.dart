import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:resultizer_merged/core/utils/app_global.dart';
import 'package:resultizer_merged/core/widgets/custom_image.dart';
import 'package:resultizer_merged/core/widgets/snackbar.dart';
import 'package:resultizer_merged/features/games/data/model/league_dto.dart';
import 'package:resultizer_merged/features/games/presentation/screens/list_teams.dart';
import 'package:resultizer_merged/features/home/data/models/league_event_dto.dart';
import 'package:resultizer_merged/features/home/data/models/premier_game_dto.dart';
import 'package:resultizer_merged/features/home/data/enum/premier_game_enum.dart';
import 'package:resultizer_merged/features/home/presentation/cubit/favourites_cubit.dart';
import 'package:resultizer_merged/features/home/presentation/screen/fixture_screen.dart';
import 'package:resultizer_merged/theme/themenotifer.dart';
import 'package:resultizer_merged/utils/constant/app_assets.dart';
import 'package:resultizer_merged/utils/constant/app_string.dart';
import 'package:resultizer_merged/view/home_view/premierleague.dart';

class PremierWidget extends StatefulWidget {
  PremierWidget(
      {super.key,
      required this.notifire,
      required this.leagueEvent,
      required this.premierType});
  final ColorNotifire notifire;
  final LeagueEventDTO leagueEvent;
  String premierType = 'LIVE';

  @override
  State<PremierWidget> createState() => _PremierWidgetState();
}

class _PremierWidgetState extends State<PremierWidget> {
  late FavouritesCubit favouritesCubit;

  @override
  void initState() {
    super.initState();
    initFn().then((value) {
      setState(() {});
    });
  }

  Future initFn() async {
    await getFavouriteLeagues();
    await getFavouriteMatches();
  }

  Map<dynamic, LeagueDTO> favouritesLeagues = {};
  Map<dynamic, LeagueEventDTO> favouritesMatches = {};

  void addToFavouriteMatch(BuildContext context, PremierGameDTO item) async {
    var leagueEventDTO = LeagueEventDTO(
        leagueTitle: widget.leagueEvent.leagueTitle,
        leagueSubTitle: widget.leagueEvent.leagueSubTitle,
        games: [item],
        fixtureId: item.fixtureId!,
        leagueImage: widget.leagueEvent.leagueImage,
        leagueId: widget.leagueEvent.leagueId,
        flag: widget.leagueEvent.flag);

    if (favouritesMatches.containsKey(item.fixtureId.toString())) {
      favouritesCubit.removeMatch(leagueEventDTO).then((value) {
        showSnack(context, 'Match removed from favourites', Colors.green);
        favouritesMatches.remove(item.fixtureId.toString());
      }).catchError((onError) {
        showSnack(context, 'Failed to complete team removal from favourites',
            Colors.red);
      });
    } else {
      await favouritesCubit.saveMatch(leagueEventDTO).then((value) {
        showSnack(context, 'Match added to favourites', Colors.green);
        favouritesMatches[item.fixtureId.toString()] = leagueEventDTO;
      }).catchError((onError) {
        print(onError);
        showSnack(context, 'Failed to complete adding match to favourites ',
            Colors.red);
      });
    }
  }

  Future getFavouriteLeagues() async {
    favouritesCubit = BlocProvider.of<FavouritesCubit>(context);
    favouritesLeagues = await favouritesCubit.getLeagues();
  }

  List favouriteMatchIds = [];

  Future getFavouriteMatches() async {
    favouritesCubit = BlocProvider.of<FavouritesCubit>(context);
    favouritesMatches = await favouritesCubit.getMatches();
    favouriteMatchIds = GlobalDataSource.favouriteMatchIds;
  }

  @override
  Widget build(BuildContext context) {
    favouritesCubit = BlocProvider.of<FavouritesCubit>(context);
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
                  border:
                      Border.all(color: widget.notifire.borercolour, width: 1),
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
                          Icon(Icons.star,
                              color: (favouritesLeagues.containsKey(
                                      widget.leagueEvent.leagueId.toString())
                                  ? Colors.amber
                                  : Colors.grey),
                              size: 13),
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
                      trailing: GestureDetector(
                        onTap: () {
                          Get.to(ListTeamsView(
                            league: LeagueDTO(
                                id: widget.leagueEvent.leagueId,
                                name: widget.leagueEvent.leagueTitle,
                                logo: widget.leagueEvent.leagueImage,
                                country: widget.leagueEvent.leagueSubTitle,
                                flag: widget.leagueEvent.flag),
                          ));
                        },
                        child: Icon(
                          Icons.arrow_forward_ios_rounded,
                          size: 16,
                          color: widget.notifire.textcolore,
                        ),
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
                        var current = DateTime.now();
                        var currentDate = current.day;
                        var currentMonth = current.month;
                        var matchDate = widget.leagueEvent.games[index].matchTime;
                        
                        return Column(
                          children: [
                            ListTile(
                              onTap: () {
                                Get.to(FixtureScreen(
                                  leagueLogo: widget.leagueEvent.leagueImage,
                                  leagueName: widget.leagueEvent.leagueTitle,
                                  leagueSubtitle:
                                      widget.leagueEvent.leagueSubTitle,
                                  game: widget.leagueEvent.games[index],
                                ));
                              },
                              leading: widget.leagueEvent.games[index].matchStatus ==
                                      AppString.ft
                                  ? Text(
                                      widget
                                          .leagueEvent.games[index].matchStatus
                                          .toString(),
                                      style: TextStyle(
                                        fontFamily: 'Urbanist_bold',
                                        fontSize: 15,
                                        fontWeight: FontWeight.w700,
                                        color: widget.notifire.textcolore,
                                      ))
                                  : Column(
                                      children: [
                                        // widget.leagueEvent.games[index].gameTime
                                        if (!(currentDate == matchDate.day && currentMonth == matchDate.month))
                                          Text(
                                              '${DateFormat('dd').format(widget.leagueEvent.games[index].matchTime)} ${DateFormat('MMM').format(widget.leagueEvent.games[index].matchTime)}',
                                              style: TextStyle(
                                                fontFamily: 'Urbanist_bold',
                                                fontSize: 15,
                                                fontWeight: FontWeight.w700,
                                                color: widget.notifire.textcolore,
                                              )),
                                        Text(
                                            widget.leagueEvent.games[index]
                                                .gameTime
                                                .toString(),
                                            style: TextStyle(
                                              fontFamily: 'Urbanist_bold',
                                              fontSize: 15,
                                              fontWeight: FontWeight.w700,
                                              color: widget.notifire.textcolore,
                                            ))
                                      ],
                                    ),
                              // leading: Text(
                              //   widget.leagueEvent.games[index].matchStatus ==
                              //           AppString.ft
                              //       ? widget
                              //           .leagueEvent.games[index].matchStatus
                              //           .toString()
                              //       : widget.leagueEvent.games[index].gameTime,
                              //   style: TextStyle(
                              //     fontFamily: 'Urbanist_bold',
                              //     fontSize: 15,
                              //     fontWeight: FontWeight.w700,
                              //     color: widget.notifire.textcolore,
                              //   ),
                              //   maxLines: 2,
                              //   softWrap: true,
                              // ),
                              title: Column(
                                children: [
                                  Row(
                                    children: [
                                      ImageWithDefault(
                                        defaultImageUri:
                                            'assets/images/no_image.png',
                                        imageUrl: widget
                                            .leagueEvent.games[index].homeLogo,
                                        height: 30,
                                        width: 30,
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        widget
                                            .leagueEvent.games[index].homeTeam,
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
                                      ImageWithDefault(
                                        defaultImageUri:
                                            'assets/images/no_image.png',
                                        imageUrl: widget
                                            .leagueEvent.games[index].awayLogo,
                                        height: 30,
                                        width: 30,
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        widget
                                            .leagueEvent.games[index].awayTeam,
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
                                initialRating: favouriteMatchIds.contains(widget
                                        .leagueEvent.games[index].fixtureId
                                        .toString())
                                    ? 1
                                    : 0,
                                direction: Axis.horizontal,
                                itemCount: 1,
                                itemPadding:
                                    const EdgeInsets.symmetric(horizontal: 4.0),
                                itemBuilder: (context, _) => const Image(
                                    image: AssetImage(AppAssets.stare)),
                                onRatingUpdate: (rating) {
                                  addToFavouriteMatch(
                                      context, widget.leagueEvent.games[index]);
                                },
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
          if (widget.premierType != "")
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
