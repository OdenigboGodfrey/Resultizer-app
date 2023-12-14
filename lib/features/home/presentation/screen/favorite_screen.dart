import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:resultizer_merged/common/common_appbar.dart';
import 'package:resultizer_merged/core/utils/app_global.dart';
import 'package:resultizer_merged/core/widgets/custom_image.dart';
import 'package:resultizer_merged/core/widgets/snackbar.dart';
import 'package:resultizer_merged/features/games/data/model/league_dto.dart';
import 'package:resultizer_merged/features/games/data/model/team_list_item_dto.dart';
import 'package:resultizer_merged/features/games/presentation/screens/list_leagues.dart';
import 'package:resultizer_merged/features/games/presentation/screens/list_teams.dart';
import 'package:resultizer_merged/features/home/data/models/league_event_dto.dart';
import 'package:resultizer_merged/features/home/presentation/cubit/favourites_cubit.dart';
import 'package:resultizer_merged/features/home/presentation/screen/competition_fixture_view.dart';
import 'package:resultizer_merged/features/home/presentation/screen/team_fixture_view.dart';
import 'package:resultizer_merged/features/home/presentation/widget/premier_widget.dart';
import 'package:resultizer_merged/theme/themenotifer.dart';
import 'package:resultizer_merged/utils/constant/app_assets.dart';
import 'package:resultizer_merged/utils/constant/app_color.dart';
import 'package:resultizer_merged/utils/model/favorite_model.dart';
import 'package:resultizer_merged/view/home_view/premierleague.dart';

class FavoriteScreenView extends StatefulWidget {
  const FavoriteScreenView({super.key});

  @override
  State<FavoriteScreenView> createState() => _FavoriteScreenViewState();
}

class _FavoriteScreenViewState extends State<FavoriteScreenView> {
  late FavouritesCubit cubit;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getFavouriteLeagues().whenComplete(() {
      setState(() {
        selectIndex = 0;
      });
    });
    getFavouriteTeams().then((value) {
      setState(() {});
    });
    getFavouriteMatches().then((value) {
      setState(() {});
    });
  }

  int selectIndex = 0;
  ColorNotifire notifire = ColorNotifire();
  List text = [
    'Matches',
    'Competitions',
    'Teams',
  ];
  List img = [
    'assets/images/folloeImage1.png',
    'assets/images/folloImage2.png',
  ];
  List country = [
    'Burnley',
    'Luton',
  ];
  List img1 = [
    'assets/images/follow4.png',
    'assets/images/folloeImage1.png',
  ];
  List country1 = [
    'Manchester',
    'Fulham',
  ];
  List winner = [
    '1',
    '2',
  ];
  List winner1 = [
    '2',
    '0',
  ];
  List<favoriteModel> competion2 = [
    favoriteModel(
      image: AppAssets.image1,
      title: 'World Cup 2022',
      subTitle: 'FIFA',
    ),
    favoriteModel(
        image: AppAssets.image2, title: 'Premier League', subTitle: 'England'),
    favoriteModel(
      image: AppAssets.chapion,
      title: 'Champions League',
      subTitle: 'UEFA',
    ),
    favoriteModel(
      image: AppAssets.eurpa,
      title: 'Europa League',
      subTitle: 'UEFA',
    ),
    favoriteModel(
      image: AppAssets.luliga,
      title: 'LaLiga Santander',
      subTitle: 'Spain',
    ),
    favoriteModel(
      image: AppAssets.eradivi,
      title: 'Eredivisie',
      subTitle: 'Netherlands',
    ),
  ];

  late FavouritesCubit favouritesCubit;
  Map<dynamic, LeagueDTO> favouritesLeagues = {};
  Map<dynamic, TeamListItemDTO> favouritesTeams = {};
  Map<dynamic, LeagueEventDTO> favouritesMatches = {};

  Future getFavouriteLeagues() async {
    favouritesCubit = BlocProvider.of<FavouritesCubit>(context);
    favouritesLeagues = await favouritesCubit.getLeagues();
  }

  Future getFavouriteTeams() async {
    favouritesTeams = await favouritesCubit.getTeams();
  }

  Future getFavouriteMatches() async {
    favouritesMatches = await favouritesCubit.getMatches();
  }

  void addToFavouritesTeamsList(
      BuildContext context, TeamListItemDTO teamListItem) async {
    if (favouritesTeams.containsKey(teamListItem.id.toString())) {
      favouritesCubit.removeTeam(teamListItem).then((value) {
        showSnack(context, 'Team removed from favourites', Colors.green);
        favouritesTeams.remove(teamListItem.id.toString());
      }).catchError((onError) {
        showSnack(context, 'Failed to complete team removal from favourites',
            Colors.red);
      });
    } else {
      await favouritesCubit.saveTeam(teamListItem).then((value) {
        showSnack(context, 'Team added to favourites', Colors.green);
        favouritesTeams[teamListItem.id.toString()] = teamListItem;
      }).catchError((onError) {
        print(onError);
        showSnack(context, 'Failed to complete adding team to favourites ',
            Colors.red);
      });
    }
  }

  void addToFavouritesLeaguesList(
      BuildContext context, LeagueDTO league) async {
    if (favouritesLeagues.containsKey(league.id.toString())) {
      favouritesCubit.removeLeague(league).then((value) {
        showSnack(context, 'League removed from favourites', Colors.green);
        favouritesLeagues.remove(league.id.toString());
      }).catchError((onError) {
        showSnack(context, 'Failed to complete league removal from favourites',
            Colors.red);
      });
    } else {
      await favouritesCubit.saveLeagues(league).then((value) {
        showSnack(context, 'League added to favourites', Colors.green);
        favouritesLeagues[league.id.toString()] = league;
      }).catchError((onError) {
        print(onError);
        showSnack(context, 'Failed to complete adding league from favourites ',
            Colors.red);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    notifire = Provider.of<ColorNotifire>(context, listen: true);
    cubit = context.read<FavouritesCubit>();
    var favouritesLeagueValues = favouritesLeagues.values.toList();
    var favouritesTeamsValues = favouritesTeams.values.toList();
    var favouriteMatchesValue = favouritesMatches.values.toList();
    return Scaffold(
      backgroundColor: notifire.background,
      // appBar: AppBar(
      //     title: Text('Drawer Example'),
      //     actions: [Text('Action 1')],
      //   ),
      // drawer: Drawer(
      //     child: ListView(
      //       padding: EdgeInsets.zero,
      //       children: <Widget>[
      //         DrawerHeader(
      //           decoration: BoxDecoration(
      //             color: Colors.blue,
      //           ),
      //           child: Text(
      //             'Drawer Header',
      //             style: TextStyle(
      //               color: Colors.white,
      //               fontSize: 24,
      //             ),
      //           ),
      //         ),
      //         ListTile(
      //           leading: Icon(Icons.home),
      //           title: Text('Home'),
      //           onTap: () {
      //             // Add functionality here for Home
      //           },
      //         ),
      //         ListTile(
      //           leading: Icon(Icons.settings),
      //           title: Text('Settings'),
      //           onTap: () {
      //             // Add functionality here for Settings
      //           },
      //         ),
      //         // Add more ListTile widgets for other options
      //       ],
      //     ),
      //   ),
      key: GlobalDataSource.scaffoldKey,
      appBar: commonappbar(
        title: 'Resultizer'.tr,
        image: AppAssets.search,
        context: context,
      ),
      drawer: drawer1(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 15, right: 15),
          child: Column(
            children: [
              // List of Matches
              Padding(
                padding: const EdgeInsets.only(top: 10, bottom: 20),
                child: SizedBox(
                  height: 38,
                  child: ListView.separated(
                    itemCount: text.length,
                    scrollDirection: Axis.horizontal,
                    separatorBuilder: (context, index) {
                      return const SizedBox(
                        width: 10,
                      );
                    },
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            selectIndex = index;
                          });
                        },
                        child: Container(
                          width: index == 0
                              ? 109
                              : index == 1
                                  ? 140
                                  : 109,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                          ),
                          clipBehavior: Clip.antiAlias,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                            color: selectIndex == index
                                ? AppColor.pinkColor
                                : notifire.background,
                            border: Border.all(
                              width: 2,
                              color: selectIndex == index
                                  ? AppColor.pinkColor
                                  : AppColor.pinkColor,
                            ),
                          ),
                          child: Center(
                            child: Text(
                              text[index],
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: "Urbanist_medium",
                                  color: selectIndex == index
                                      ? Colors.white
                                      : AppColor.pinkColor),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
              // matches
              selectIndex == 0
                  ? Column(
                      children: [
                        favouriteMatchesValue.isEmpty
                            ? const Text('No Favourite match yet.')
                            : ListView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                scrollDirection: Axis.vertical,
                                shrinkWrap: true,
                                itemCount: favouriteMatchesValue.length,
                                itemBuilder: (context, index) {
                                  // List<PremierWidget> widgets = [];

                                  return PremierWidget(
                                    premierType: '',
                                    notifire: notifire,
                                    leagueEvent: favouriteMatchesValue[index],
                                  );
                                },
                              ),
                        // GestureDetector(
                        //   onTap: () {
                        //     Get.to(const premierscreen());
                        //   },
                        //   child: ListView.builder(
                        //     padding: const EdgeInsets.only(top: 15),
                        //     physics: const NeverScrollableScrollPhysics(),
                        //     shrinkWrap: true,
                        //     scrollDirection: Axis.vertical,
                        //     itemCount: 1,
                        //     itemBuilder: (context, index) {
                        //       return Column(
                        //         children: [
                        //           Container(
                        //             height: 300,
                        //             decoration: BoxDecoration(
                        //               color: notifire.insidecolor,
                        //               borderRadius: BorderRadius.circular(20),
                        //               border: Border.all(
                        //                   width: 1,
                        //                   color: notifire.borercolour),
                        //             ),
                        //             child: Column(
                        //               children: [
                        //                 ListTile(
                        //                   leading: Image.asset(
                        //                     AppAssets.image1,
                        //                     height: 30,
                        //                     width: 30,
                        //                   ),
                        //                   title: Text(
                        //                     'World Cup 2022',
                        //                     style: TextStyle(
                        //                         fontFamily: 'Urbanist_bold',
                        //                         fontWeight: FontWeight.w700,
                        //                         fontSize: 15,
                        //                         color: notifire.textcolore),
                        //                   ),
                        //                   subtitle: Text(
                        //                     'Group B',
                        //                     style: TextStyle(
                        //                         fontFamily: 'Urbanist_medium',
                        //                         fontWeight: FontWeight.w500,
                        //                         fontSize: 14,
                        //                         color: notifire.textcolore),
                        //                   ),
                        //                   trailing: Icon(
                        //                       Icons.arrow_forward_ios_rounded,
                        //                       size: 16,
                        //                       color: notifire.textcolore),
                        //                 ),
                        //                 Padding(
                        //                   padding: const EdgeInsets.symmetric(
                        //                       horizontal: 15, vertical: 10),
                        //                   child: Divider(
                        //                     height: 10,
                        //                     thickness: 1,
                        //                     color: notifire.borercolour,
                        //                   ),
                        //                 ),
                        //                 Row(
                        //                   children: [
                        //                     const SizedBox(
                        //                       width: 20,
                        //                     ),
                        //                     Text(
                        //                       'FT',
                        //                       style: TextStyle(
                        //                           fontFamily: 'Urbanist_bold',
                        //                           fontWeight: FontWeight.w700,
                        //                           fontSize: 15,
                        //                           color: notifire.textcolore),
                        //                     ),
                        //                     const SizedBox(
                        //                       width: 35,
                        //                     ),
                        //                     Flexible(
                        //                       flex: 2,
                        //                       child: Column(
                        //                         children: [
                        //                           Row(
                        //                             children: [
                        //                               Image.asset(
                        //                                 img1[index],
                        //                                 height: 26,
                        //                                 width: 26,
                        //                               ),
                        //                               const SizedBox(
                        //                                 width: 10,
                        //                               ),
                        //                               Text(
                        //                                 country1[index],
                        //                                 style: TextStyle(
                        //                                     fontFamily:
                        //                                         'Urbanist_bold',
                        //                                     fontWeight:
                        //                                         FontWeight.w700,
                        //                                     fontSize: 15,
                        //                                     color: notifire
                        //                                         .textcolore),
                        //                               ),
                        //                             ],
                        //                           ),
                        //                           const SizedBox(
                        //                             height: 10,
                        //                           ),
                        //                           Row(
                        //                             children: [
                        //                               Image.asset(
                        //                                 img[index],
                        //                                 height: 26,
                        //                                 width: 26,
                        //                               ),
                        //                               const SizedBox(
                        //                                 width: 10,
                        //                               ),
                        //                               Text(
                        //                                 country[index],
                        //                                 style: TextStyle(
                        //                                     fontFamily:
                        //                                         'Urbanist_bold',
                        //                                     fontWeight:
                        //                                         FontWeight.w700,
                        //                                     fontSize: 15,
                        //                                     color: notifire
                        //                                         .textcolore),
                        //                               ),
                        //                             ],
                        //                           ),
                        //                         ],
                        //                       ),
                        //                     ),
                        //                     Column(
                        //                       children: [
                        //                         Text(
                        //                           winner1[index],
                        //                           style: TextStyle(
                        //                               fontFamily:
                        //                                   'Urbanist-bold',
                        //                               fontSize: 20,
                        //                               fontWeight:
                        //                                   FontWeight.w700,
                        //                               color:
                        //                                   notifire.textcolore),
                        //                         ),
                        //                         const SizedBox(
                        //                           height: 10,
                        //                         ),
                        //                         Text(
                        //                           winner[index],
                        //                           style: TextStyle(
                        //                               fontFamily:
                        //                                   'Urbanist-bold',
                        //                               fontSize: 20,
                        //                               fontWeight:
                        //                                   FontWeight.w700,
                        //                               color:
                        //                                   notifire.textcolore),
                        //                         ),
                        //                       ],
                        //                     ),
                        //                     const SizedBox(
                        //                       width: 10,
                        //                     ),
                        //                     Column(
                        //                       children: [
                        //                         star(onTap: (tap){}),
                        //                       ],
                        //                     ),
                        //                     const SizedBox(
                        //                       width: 10,
                        //                     ),
                        //                   ],
                        //                 ),
                        //                 Padding(
                        //                   padding: const EdgeInsets.symmetric(
                        //                       horizontal: 15, vertical: 10),
                        //                   child: Divider(
                        //                     height: 10,
                        //                     thickness: 1,
                        //                     color: notifire.borercolour,
                        //                   ),
                        //                 ),
                        //                 Row(
                        //                   children: [
                        //                     const SizedBox(
                        //                       width: 20,
                        //                     ),
                        //                     Text(
                        //                       'FT',
                        //                       style: TextStyle(
                        //                           fontFamily: 'Urbanist_bold',
                        //                           fontWeight: FontWeight.w700,
                        //                           fontSize: 15,
                        //                           color: notifire.textcolore),
                        //                     ),
                        //                     const SizedBox(
                        //                       width: 35,
                        //                     ),
                        //                     Flexible(
                        //                       flex: 2,
                        //                       child: Column(
                        //                         children: [
                        //                           Row(
                        //                             children: [
                        //                               Image.asset(
                        //                                 img1[1],
                        //                                 height: 26,
                        //                                 width: 26,
                        //                               ),
                        //                               const SizedBox(
                        //                                 width: 10,
                        //                               ),
                        //                               Text(
                        //                                 country1[1],
                        //                                 style: TextStyle(
                        //                                     fontFamily:
                        //                                         'Urbanist_bold',
                        //                                     fontWeight:
                        //                                         FontWeight.w700,
                        //                                     fontSize: 15,
                        //                                     color: notifire
                        //                                         .textcolore),
                        //                               ),
                        //                             ],
                        //                           ),
                        //                           const SizedBox(
                        //                             height: 10,
                        //                           ),
                        //                           Row(
                        //                             children: [
                        //                               Image.asset(
                        //                                 img[1],
                        //                                 height: 26,
                        //                                 width: 26,
                        //                               ),
                        //                               const SizedBox(
                        //                                 width: 10,
                        //                               ),
                        //                               Text(
                        //                                 country[1],
                        //                                 style: TextStyle(
                        //                                     fontFamily:
                        //                                         'Urbanist_bold',
                        //                                     fontWeight:
                        //                                         FontWeight.w700,
                        //                                     fontSize: 15,
                        //                                     color: notifire
                        //                                         .textcolore),
                        //                               ),
                        //                             ],
                        //                           ),
                        //                         ],
                        //                       ),
                        //                     ),
                        //                     Column(
                        //                       children: [
                        //                         Text(
                        //                           winner1[1],
                        //                           style: TextStyle(
                        //                               fontFamily:
                        //                                   'Urbanist-bold',
                        //                               fontSize: 20,
                        //                               fontWeight:
                        //                                   FontWeight.w700,
                        //                               color:
                        //                                   notifire.textcolore),
                        //                         ),
                        //                         const SizedBox(
                        //                           height: 10,
                        //                         ),
                        //                         Text(
                        //                           winner[1],
                        //                           style: TextStyle(
                        //                               fontFamily:
                        //                                   'Urbanist-bold',
                        //                               fontSize: 20,
                        //                               fontWeight:
                        //                                   FontWeight.w700,
                        //                               color:
                        //                                   notifire.textcolore),
                        //                         ),
                        //                       ],
                        //                     ),
                        //                     const SizedBox(
                        //                       width: 10,
                        //                     ),
                        //                     Column(
                        //                       children: [
                        //                         star(onTap: (tap){}),
                        //                       ],
                        //                     ),
                        //                     const SizedBox(
                        //                       width: 10,
                        //                     ),
                        //                   ],
                        //                 ),
                        //               ],
                        //             ),
                        //           ),
                        //           const SizedBox(
                        //             height: 20,
                        //           ),
                        //         ],
                        //       );
                        //     },
                        //   ),
                        // ),
                      ],
                    )
                  // competition
                  : selectIndex == 1
                      ? Column(
                          children: [
                            favouritesLeagueValues.isEmpty
                                ? const Text('No Favourite competitions yet.')
                                : ListView.builder(
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    scrollDirection: Axis.vertical,
                                    // itemCount: competion.length,
                                    itemCount: favouritesLeagueValues.length,
                                    itemBuilder: (context, index) {
                                      return GestureDetector(
                                        onTap: () {
                                          // load fixtures by league
                                          Get.to(CompetitionFixtureScreenView(
                                              competitionId:
                                                  favouritesLeagueValues[index]
                                                      .id));
                                        },
                                        child: Container(
                                          height: 88,
                                          margin: const EdgeInsets.symmetric(
                                              vertical: 10),
                                          decoration: BoxDecoration(
                                            color: notifire.insidecolor,
                                            borderRadius:
                                                BorderRadius.circular(16),
                                            border: Border.all(
                                                color: notifire.borercolour,
                                                width: 1),
                                          ),
                                          child: Center(
                                            child: ListTile(
                                              leading: ImageWithDefault(
                                                  imageUrl:
                                                      favouritesLeagueValues[
                                                              index]
                                                          .logo
                                                          .toString(),
                                                  width: 40,
                                                  height: 40),
                                              title: Text(
                                                favouritesLeagueValues[index]
                                                    .name
                                                    .toString(),
                                                style: TextStyle(
                                                    fontFamily: 'Urbanist_bold',
                                                    fontWeight: FontWeight.w700,
                                                    fontSize: 20,
                                                    color: notifire.textcolore),
                                              ),
                                              subtitle: Text(
                                                favouritesLeagueValues[index]
                                                    .country
                                                    .toString(),
                                                style: TextStyle(
                                                    fontFamily:
                                                        'Urbanist_medium',
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 14,
                                                    color: notifire.textcolore),
                                              ),
                                              trailing: star(
                                                  onTap: (tap) {
                                                    addToFavouritesLeaguesList(
                                                        context,
                                                        favouritesLeagueValues[
                                                            index]);
                                                  },
                                                  initialRating: favouritesLeagues
                                                          .containsKey(
                                                              favouritesLeagueValues[
                                                                      index]
                                                                  .id
                                                                  .toString())
                                                      ? 1
                                                      : 0),
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                            const SizedBox(
                              height: 10,
                            ),
                            ElevatedButton(
                              onPressed: () {
                                Get.to(const ListLeaguesView());
                              },
                              child: const Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.add,
                                    color: AppColor.pinkColor,
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    'Add Competition',
                                    style: TextStyle(
                                        fontFamily: 'Urbanist_bold',
                                        fontSize: 16,
                                        fontWeight: FontWeight.w700),
                                  )
                                ],
                              ),
                            ),
                          ],
                        )
                      : Column(children: [
                          favouritesTeamsValues.isEmpty
                              ? const Text('No Favourite teams yet.')
                              : ListView.builder(
                                  physics: const NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  scrollDirection: Axis.vertical,
                                  // itemCount: competion.length,
                                  itemCount: favouritesTeamsValues.length,
                                  itemBuilder: (context, index) {
                                    return GestureDetector(
                                      onTap: () {
                                        // load up fixtures by team
                                        Get.to(TeamFixtureScreenView(
                                            teamId: favouritesTeamsValues[index]
                                                .id));
                                      },
                                      child: Container(
                                        height: 88,
                                        margin: const EdgeInsets.symmetric(
                                            vertical: 10),
                                        decoration: BoxDecoration(
                                          color: notifire.insidecolor,
                                          borderRadius:
                                              BorderRadius.circular(16),
                                          border: Border.all(
                                              color: notifire.borercolour,
                                              width: 1),
                                        ),
                                        child: Center(
                                          child: ListTile(
                                            leading: ImageWithDefault(
                                                imageUrl:
                                                    favouritesTeamsValues[index]
                                                        .logo
                                                        .toString(),
                                                width: 40,
                                                height: 40),
                                            title: Text(
                                              favouritesTeamsValues[index]
                                                  .name
                                                  .toString(),
                                              style: TextStyle(
                                                  fontFamily: 'Urbanist_bold',
                                                  fontWeight: FontWeight.w700,
                                                  fontSize: 20,
                                                  color: notifire.textcolore),
                                            ),
                                            subtitle: Text(
                                              favouritesTeamsValues[index]
                                                  .country
                                                  .toString(),
                                              style: TextStyle(
                                                  fontFamily: 'Urbanist_medium',
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 14,
                                                  color: notifire.textcolore),
                                            ),
                                            trailing: star(
                                                onTap: (tap) {
                                                  addToFavouritesTeamsList(
                                                      context,
                                                      favouritesTeamsValues[
                                                          index]);
                                                },
                                                initialRating:
                                                    favouritesTeams.containsKey(
                                                            favouritesTeamsValues[
                                                                    index]
                                                                .id
                                                                .toString())
                                                        ? 1
                                                        : 0),
                                          ),
                                        ),
                                      ),
                                    );
                                  }),
                          const SizedBox(
                            height: 10,
                          ),
                          ElevatedButton(
                            onPressed: () {
                              Get.to(const ListLeaguesView());
                            },
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.add,
                                  color: AppColor.pinkColor,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  'Add Team',
                                  style: TextStyle(
                                      fontFamily: 'Urbanist_bold',
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700),
                                )
                              ],
                            ),
                          ),
                        ]),
            ],
          ),
        ),
      ),
    );
  }

  // Widget star() {
  Widget star({required Function(double) onTap, double initialRating = 0}) {
    return RatingBar.builder(
      itemSize: 24,
      initialRating: initialRating,
      direction: Axis.horizontal,
      itemCount: 1,
      itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
      itemBuilder: (context, _) =>
          const Image(image: AssetImage(AppAssets.stare)),
      onRatingUpdate: (rating) {
        onTap(rating);
      },
    );
  }
}
