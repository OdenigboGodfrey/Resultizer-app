import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:resultizer_merged/common/common_appbar.dart';
import 'package:resultizer_merged/features/home/data/models/league_event_dto.dart';
import 'package:resultizer_merged/features/home/presentation/cubit/soccer_cubit.dart';
import 'package:resultizer_merged/features/home/presentation/cubit/soccer_state.dart';
import 'package:resultizer_merged/features/home/presentation/widget/premier_widget.dart';
import 'package:resultizer_merged/theme/themenotifer.dart';
import 'package:resultizer_merged/utils/constant/app_assets.dart';

class CompetitionFixtureScreenView extends StatefulWidget {
  const CompetitionFixtureScreenView({Key? key, required this.competitionId}) : super(key: key);
  final int competitionId;
  @override
  State<CompetitionFixtureScreenView> createState() => _CompetitionFixtureScreenViewState();
}

class _CompetitionFixtureScreenViewState extends State<CompetitionFixtureScreenView> {

  int selectIndex = 0;
  int selected = 0;
  dynamic selectedValue;
  ColorNotifire notifire = ColorNotifire();
  int fillstar1 = 0;
  int fillstar2 = 0;
  int fillstar3 = 0;
  late SoccerCubit cubit;

  List<LeagueEventDTO> fixtures = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
  }

  refreshList() {
    // fixtures = [];
    // String date = DateFormat("yyyy-MM-dd").format(selectedDay['dateTime']);
    // cubit.refreshList(date);
    // setState(() {
    //   isLoadingNewDay = true;
    // });
  }

  Future getLists() async {
    // cubit.competitionFixtures = [];
    if (cubit.competitionFixtures.isEmpty) {
      await cubit.getFixturesByCompetition(widget.competitionId);
    }
    fixtures = cubit.competitionFixtures;
  }

  Future<List> fetchData() async {
    await getLists();
    return fixtures;
  }

  @override
  Widget build(BuildContext context) {
    notifire = Provider.of<ColorNotifire>(context, listen: true);
    cubit = BlocProvider.of<SoccerCubit>(context);
    Size size = MediaQuery.of(context).size;
    double height = size.height;
    double width = size.width;
    // print(day);
    return BlocConsumer<SoccerCubit, SoccerStates>(listener: (context, state) {
      if (state is LeagueGamesLoaded) {
        fixtures = state.leagues as List<LeagueEventDTO>;
        setState(() {
          isLoading = false;
        });
      }
      if (state is LeagueGamesLoadFailure) {
        setState(() {
          isLoading = false;
        });
      }
    }, builder: (context, state) {
      return WillPopScope(
        onWillPop: () async {
          cubit.competitionFixtures = [];
          return true;
        },
        child: Scaffold(
          backgroundColor: notifire.background,
          
          drawer: const drawer1(),
          appBar: AppBar(
                actionsIconTheme:
                    IconThemeData(color: notifire.reverseBgColore),
                backgroundColor: notifire.bgcolore,
                leading: GestureDetector(
                  onTap: () {
                    Get.back();
                  },
                  child: Icon(Icons.arrow_back, color: notifire.textcolore),
                ),
                title: Text(
                  "Resultizer",
                  style: TextStyle(color: notifire.textcolore),
                ),
              ),
          body: ListView(
            padding: EdgeInsets.zero,
            children: [
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: Column(
                  children: [
                    // Upcoming
                    FutureBuilder<List>(
                      future: fetchData(),
                      builder:
                          (BuildContext context, AsyncSnapshot<List> snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return const SizedBox(
                            height: 250,
                            child: Center(
                              child: CircularProgressIndicator(),
                            ),
                          );
                        } else if (snapshot.hasError) {
                          print('snapshot.error ${snapshot.error}');
                          return const Text('An error occurred, Please restart the application');
                        } else {
                          // If the Future completes successfully, use the data.
                          final data = snapshot.data;
                          List<PremierWidget> widgets = [];
                          for(var item in data!) {
                            widgets.add(PremierWidget(
                            premierType: 'FIXTURES',
                            notifire: notifire,
                            leagueEvent: item,
                            ));
                          }
                          return Column(children: widgets);
                          // return Container();
                        }
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
