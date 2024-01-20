import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:resultizer_merged/core/utils/app_global.dart';
import 'package:resultizer_merged/core/widgets/custom_image.dart';
import 'package:resultizer_merged/core/widgets/snackbar.dart';
import 'package:resultizer_merged/features/games/data/model/league_dto.dart';
import 'package:resultizer_merged/features/games/data/model/team_list_item_dto.dart';
import 'package:resultizer_merged/features/games/presentation/cubit/teams_cubit.dart';
import 'package:resultizer_merged/features/games/presentation/widgets/searchbox.dart';
import 'package:resultizer_merged/features/home/presentation/cubit/favourites_cubit.dart';
import 'package:resultizer_merged/features/home/presentation/screen/team_fixture_view.dart';
import 'package:resultizer_merged/theme/themenotifer.dart';
import 'package:resultizer_merged/utils/constant/app_assets.dart';
import 'package:resultizer_merged/utils/constant/app_string.dart';

class ListTeamsView extends StatefulWidget {
  const ListTeamsView({super.key, required this.league});
  final LeagueDTO league;

  @override
  State<ListTeamsView> createState() => _ListTeamsViewState();
}

class _ListTeamsViewState extends State<ListTeamsView> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getFavouriteLeagues().then((value) {
      setState(() {});
    });
  }

  late TeamsCubit cubit;
  late FavouritesCubit favouritesCubit;

  List<TeamListItemDTO> teamList = [];
  List<TeamListItemDTO> filtered = [];
  bool isFiltering = false;
  Map<dynamic, TeamListItemDTO> favouritesTeams = {};
  Map<dynamic, LeagueDTO> favouritesLeagues = {};
  Future getLists() async {
    if (isFiltering) return filtered;
    await cubit.getTeams(widget.league.id);
    teamList = cubit.teamList;
    filtered = teamList;
  }

  Future getFavouriteTeams() async {
    favouritesTeams = await favouritesCubit.getTeams();
  }

  Future getFavouriteLeagues() async {
    favouritesCubit = BlocProvider.of<FavouritesCubit>(context);
    favouritesLeagues = await favouritesCubit.getLeagues();
  }

  Future<List> fetchData() async {
    await getFavouriteTeams();
    await getLists();
    return filtered;
  }

  void addToFavouritesTeamsList(
      BuildContext context, TeamListItemDTO teamListItem) async {
    if (GlobalDataSource.userData.id == AppString.guestUid) {
      return showSnack(context, 'Invalid Action', Colors.red);
    }
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
    
    if (GlobalDataSource.userData.id == AppString.guestUid) {
      return showSnack(context, 'Invalid Action', Colors.red);
    }
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

  void filter(String phrase) {
    if (phrase.isEmpty) {
      filtered = teamList;
      isFiltering = false;
    } else {
      isFiltering = true;
      filtered = [];
      for (int i = 0; i < teamList.length; i++) {
        var item = teamList[i];
        if (item.name.toString().toLowerCase().contains(phrase.toLowerCase())) {
          filtered.add(item);
        }
      }
    }
    setState(() {});
  }

  ColorNotifire notifire = ColorNotifire();
  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    notifire = Provider.of<ColorNotifire>(context, listen: true);
    cubit = BlocProvider.of<TeamsCubit>(context);
    favouritesCubit = BlocProvider.of<FavouritesCubit>(context);
    return Scaffold(
        backgroundColor: notifire.background,
        appBar: AppBar(
          actionsIconTheme: IconThemeData(color: notifire.reverseBgColore),
          backgroundColor: notifire.bgcolore,
          leading: GestureDetector(
            onTap: () {
              Get.back();
            },
            child: Icon(Icons.arrow_back, color: notifire.textcolore),
          ),
          title: Text(
            widget.league.name,
            style: TextStyle(color: notifire.textcolore),
          ),
          actions: [
            Container(
              margin: const EdgeInsets.all(15),
              child: star(
                  onTap: (rating) {
                    // run logic to handle favourite add/remove
                    addToFavouritesLeaguesList(context, widget.league);
                  },
                  initialRating:
                      favouritesLeagues.containsKey(widget.league.id.toString())
                          ? 1
                          : 0),
            ),
          ],
        ),
        body: Column(
          children: [
            SearchBoxWidget(
              controller: searchController,
              onChanged: (text) {
                filter(text);
              },
            ),
            Expanded(
                child: SingleChildScrollView(
                    child: FutureBuilder<List>(
                        future: fetchData(),
                        builder: (BuildContext context,
                            AsyncSnapshot<List> snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const SizedBox(
                              height: 250,
                              child: Center(
                                child: CircularProgressIndicator(),
                              ),
                            );
                          } else if (snapshot.hasError) {
                            print('snapshot.error ${snapshot.error}');
                            return const Text(
                                'An error occurred, Please try again later');
                          } else {
                            List<Widget> widgets = [];
                            List data = snapshot.data!;
                            for (TeamListItemDTO item in data) {
                              widgets.add(GestureDetector(
                                onTap: () {
                                  Get.to(
                                      TeamFixtureScreenView(teamId: item.id));
                                  print('clicked');
                                },
                                child: Container(
                                  height: 88,
                                  margin:
                                      const EdgeInsets.symmetric(vertical: 10),
                                  decoration: BoxDecoration(
                                    color: notifire.insidecolor,
                                    borderRadius: BorderRadius.circular(16),
                                    border: Border.all(
                                        color: notifire.borercolour, width: 1),
                                  ),
                                  child: Center(
                                    child: ListTile(
                                      leading: ImageWithDefault(
                                          imageUrl: item.logo,
                                          width: 40,
                                          height: 40),
                                      title: Text(
                                        item.name.toString(),
                                        style: TextStyle(
                                            fontFamily: 'Urbanist_bold',
                                            fontWeight: FontWeight.w700,
                                            fontSize: 20,
                                            color: notifire.textcolore),
                                      ),
                                      subtitle: Text(
                                        item.country.toString(),
                                        style: TextStyle(
                                            fontFamily: 'Urbanist_medium',
                                            fontWeight: FontWeight.w500,
                                            fontSize: 14,
                                            color: notifire.textcolore),
                                      ),
                                      trailing: star(
                                          onTap: (rating) {
                                            // run logic to handle favourite add/remove
                                            addToFavouritesTeamsList(
                                                context, item);
                                          },
                                          initialRating:
                                              favouritesTeams.containsKey(
                                                      item.id.toString())
                                                  ? 1
                                                  : 0),
                                    ),
                                  ),
                                ),
                              ));
                            }

                            return Column(
                              children: widgets,
                            );
                          }
                        }))),
            const SizedBox(
              height: 10,
            ),
            // ElevatedButton(
            //   onPressed: () {
            //     // save to fire store all selected
            //   },
            //   child: const Row(
            //     mainAxisAlignment: MainAxisAlignment.center,
            //     children: [
            //       Icon(
            //         Icons.add,
            //         color: AppColor.pinkColor,
            //       ),
            //       SizedBox(
            //         width: 10,
            //       ),
            //       Text(
            //         'Done',
            //         style: TextStyle(
            //             fontFamily: 'Urbanist_bold',
            //             fontSize: 16,
            //             fontWeight: FontWeight.w700),
            //       )
            //     ],
            //   ),
            // ),
          ],
        ));
  }

  Widget star(
      {required Function(double) onTap, required double initialRating}) {
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
