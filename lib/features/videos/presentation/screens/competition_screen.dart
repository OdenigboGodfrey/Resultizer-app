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

class CompetitionHighlightsViewScreen extends StatefulWidget {
  const CompetitionHighlightsViewScreen({super.key});

  @override
  State<CompetitionHighlightsViewScreen> createState() =>
      _CompetitionHighlightsViewScreenState();
  }

class _CompetitionHighlightsViewScreenState
    extends State<CompetitionHighlightsViewScreen> {
  ColorNotifire notifire = ColorNotifire();

  List<Map> competitions = [];
  List<Map> filteredCompetitions = [];
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    fetchData().then((value) => setState((){ filteredCompetitions = value; }));
  }

  Future<List<Map>> fetchData() async {
    if (filteredCompetitions.isEmpty) {
      var cubit = BlocProvider.of<ScorebatCubit>(context);
      competitions = await cubit.getCompetitions().catchError((onError) {
        throw onError;
      });
      filteredCompetitions = competitions;
    }

    return filteredCompetitions;
  }

  void filterCompetitions(String phrase) {
    if (phrase.isEmpty) {
      filteredCompetitions = competitions;
    } else {
      filteredCompetitions = [];
      for (int i = 0; i < competitions.length; i++) {
        var item = competitions[i];
        if (item['name'].toString().toLowerCase().contains(phrase.toLowerCase())) {
          filteredCompetitions.add(item);
        }
      }
    }
    setState(() {});
  }

  
  List<Widget> buildWidgets(ScorebatCubit cubit) {
    List<Widget> widgets = [];
    // widgets = [];
    for (int i = 0; i < filteredCompetitions.length; i++) {
      Map item = filteredCompetitions[i];
      widgets.add(CustomListItem(
        text: item['name'],
        onTap: () {
          Get.to(VideoListViewScreen(appbarTitle: item['name'], fetchData: () async {
            return await cubit.getHighlightsByCompetition(item['slug']);
          }));
        },
        image: item['country']['flag'],
      ));
    }
    return widgets;
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
                  "Competitions",
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
                        filterCompetitions(text);
                      }),
                  const SizedBox(
                    height: 5,
                  ),
                  if (filteredCompetitions.isEmpty)
                    const SizedBox(
                      height: 250,
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    ),
                  if (filteredCompetitions.isNotEmpty)
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
