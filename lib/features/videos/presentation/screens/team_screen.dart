import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:resultizer_merged/features/videos/presentation/cubic/video_cubit.dart';
import 'package:resultizer_merged/features/videos/presentation/cubic/video_state.dart';
import 'package:resultizer_merged/features/videos/presentation/screens/video_list_screen.dart';
import 'package:resultizer_merged/features/videos/presentation/widgets/customListItem.dart';
import 'package:resultizer_merged/features/videos/presentation/widgets/searchbox.dart';
import 'package:resultizer_merged/theme/themenotifer.dart';

class TeamHighlightsViewScreen extends StatefulWidget {
  const TeamHighlightsViewScreen({super.key});

  @override
  State<TeamHighlightsViewScreen> createState() => _TeamHighlightsViewScreenState();
}

class _TeamHighlightsViewScreenState extends State<TeamHighlightsViewScreen> {
  ColorNotifire notifire = ColorNotifire();
  TextEditingController searchController = TextEditingController();

  List<Map> filteredTeams = [];
  List<Map> teams = [];

  @override
  void initState() {
    super.initState();
    fetchData().then((value) => setState((){ filteredTeams = value; }));
  }

  Future<List<Map>> fetchData() async {
    if (filteredTeams.isEmpty) {
      var cubit = BlocProvider.of<ScorebatCubit>(context);
      teams = await cubit.getTeams().catchError((onError) {
        throw onError;
      });
      filteredTeams = teams;
    }

    return filteredTeams;
  }

  List<Widget> buildWidgets(ScorebatCubit cubit) {
    List<Widget> widgets = [];
    // widgets = [];
    for (int i = 0; i < filteredTeams.length; i++) {
      Map item = filteredTeams[i];
      widgets.add(CustomListItem(
        text: item['name'],
        onTap: () {
          Get.to(VideoListViewScreen(appbarTitle: item['name'], fetchData: () async {
            return await cubit.getHighlightsByTeam(item['slug']);
          }));
        },
      ));
    }
    return widgets;
  }

  void filterTeams(String phrase) {
    if (phrase.isEmpty) {
      filteredTeams = teams;
    } else {
      filteredTeams = [];
      for (int i = 0; i < teams.length; i++) {
        var item = teams[i];
        if (item['name'].toString().toLowerCase().contains(phrase.toLowerCase())) {
          filteredTeams.add(item);
        }
      }
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    notifire = Provider.of<ColorNotifire>(context, listen: true);
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    var cubit = BlocProvider.of<ScorebatCubit>(context);
    return BlocBuilder<ScorebatCubit, ScorebatStates>(
        builder: (context, state) => Scaffold(
              backgroundColor: notifire.bgcolore,
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
                  "Teams",
                  style: TextStyle(color: notifire.textcolore),
                ),
              ),
              body: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SearchBoxWidget(
                      controller: searchController,
                      onChanged: (text) {
                        filterTeams(text);
                      }),
                  const SizedBox(
                    height: 5,
                  ),
                  if (filteredTeams.isEmpty)
                    const SizedBox(
                      height: 250,
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    ),
                  if (filteredTeams.isNotEmpty)
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(children: buildWidgets(cubit)),
                      ),
                    ),
                ],
              ),
            ));
  }
}
