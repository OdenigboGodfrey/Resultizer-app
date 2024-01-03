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
import 'package:resultizer_merged/features/games/presentation/cubit/leagues_cubit.dart';
import 'package:resultizer_merged/features/games/presentation/screens/list_teams.dart';
import 'package:resultizer_merged/features/games/presentation/widgets/searchbox.dart';
import 'package:resultizer_merged/features/home/presentation/cubit/favourites_cubit.dart';
import 'package:resultizer_merged/theme/themenotifer.dart';
import 'package:resultizer_merged/utils/constant/app_assets.dart';
import 'package:resultizer_merged/utils/constant/app_color.dart';

class ListLeaguesView extends StatefulWidget {
  const ListLeaguesView({super.key});

  @override
  State<ListLeaguesView> createState() => _ListLeaguesViewState();
}

class _ListLeaguesViewState extends State<ListLeaguesView> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getFavouriteLeagues().then((value) {
      setState(() {});
    });
  }

  late LeagueCubit cubit;

  List<LeagueDTO> leagues = [];
  List<LeagueDTO> filtered = [];
  bool isFiltering = false;
  Map<int, LeagueDTO> favourites = {};
  Future getLists() async {
    if (isFiltering) return filtered;
    if (cubit.leagues.isEmpty) {
      await cubit.getLeagues();
    }
    leagues = cubit.leagues;
    filtered = leagues;
  }

  Future<List> fetchData() async {
    await getLists();
    return filtered;
  }

  void filter(String phrase) {
    if (phrase.isEmpty) {
      filtered = leagues;
      isFiltering = false;
    } else {
      isFiltering = true;
      filtered = [];
      for (int i = 0; i < leagues.length; i++) {
        var item = leagues[i];
        if (item.name.toString().toLowerCase().contains(phrase.toLowerCase())) {
          filtered.add(item);
        }
      }
    }
    setState(() {});
  }

  late FavouritesCubit favouritesCubit;
  Map<dynamic, LeagueDTO> favouritesLeagues = {};

  Future getFavouriteLeagues() async {
    favouritesCubit = BlocProvider.of<FavouritesCubit>(context);
    favouritesLeagues = await favouritesCubit.getLeagues();
  }

  void addToFavouritesLeaguesList(
      BuildContext context, LeagueDTO league) async {
    if (GlobalDataSource.userData.id == '0') {
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

  ColorNotifire notifire = ColorNotifire();
  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    notifire = Provider.of<ColorNotifire>(context, listen: true);
    cubit = BlocProvider.of<LeagueCubit>(context);
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
            "Leagues",
            style: TextStyle(color: notifire.textcolore),
          ),
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
                            for (LeagueDTO item in data) {
                              widgets.add(GestureDetector(
                                onTap: () {
                                  Get.to(ListTeamsView(league: item));
                                  // print('clicked');
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
                                            addToFavouritesLeaguesList(
                                                context, item);
                                          },
                                          initialRating:
                                              favouritesLeagues.containsKey(
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
