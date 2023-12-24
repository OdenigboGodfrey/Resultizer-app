import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:resultizer_merged/core/error/error_message_types.dart';
import 'package:resultizer_merged/core/widgets/snackbar.dart';
import 'package:resultizer_merged/features/home/data/models/bet_model_dto.dart';
import 'package:resultizer_merged/features/home/data/models/league_event_dto.dart';
import 'package:resultizer_merged/features/home/presentation/cubit/live_games_cubit.dart';
import 'package:resultizer_merged/features/home/presentation/cubit/soccer_cubit.dart';
import 'package:resultizer_merged/features/home/presentation/widget/live_game_widget.dart';
import 'package:resultizer_merged/theme/themenotifer.dart';
import 'package:resultizer_merged/utils/constant/app_assets.dart';
import 'package:resultizer_merged/utils/constant/app_color.dart';
import 'package:resultizer_merged/view/home_view/detail_screen.dart';
import 'package:resultizer_merged/view/home_view/matchdtails.dart';


class LiveScreenView extends StatefulWidget {
  const LiveScreenView({super.key});

  @override
  State<LiveScreenView> createState() => _LiveScreenState();
}

class _LiveScreenState extends State<LiveScreenView> {
  @override
  void initState() {
    super.initState();
  }

  List<LeagueEventDTO> fixtures = [];
  bool isLoading = false;

  Future getLiveGames() async {
    final cubit = BlocProvider.of<LiveGamesCubit>(context);
    await cubit.getLiveGames().catchError((error) {
      print('error ${error}');
      showSnack(context, ErrorMessageType.exception, Colors.red);
    });
    fixtures = cubit.matches;
  }

  Future<List> fetchData() async {
    await getLiveGames();
    return fixtures;
  }

  ColorNotifire notifire = ColorNotifire();
  int selectIndex = 0;
  List text = [
    'Fixtures',
    'Results',
  ];
  @override
  Widget build(BuildContext context) {
    notifire = Provider.of<ColorNotifire>(context, listen: true);
    return Scaffold(
      backgroundColor: notifire.background,
      appBar: AppBar(
        backgroundColor: notifire.background,
        leading: GestureDetector(
          onTap: () => Get.back(),
          child: Icon(Icons.arrow_back, color: notifire.textcolore),
        ),
        title: Text(
          'LIVE Match',
          style: TextStyle(
              fontFamily: 'Urbanist_bold',
              fontWeight: FontWeight.w700,
              fontSize: 20,
              color: notifire.textcolore),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 20, top: 10),
              child: SizedBox(
                height: 45,
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
                          // getLiveGames();
                        });
                      },
                      child: Container(
                        width: 185,
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
                                fontFamily: "gilroy_medium",
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
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: livematch(selectIndex),
            ),
          ],
        ),
      ),
    );
  }

  Widget livematch(int index) {
    return Column(
      children: [
        // for(var match in fixtures)
        FutureBuilder<List>(
          future: fetchData(),
          builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              // While the Future is still running, show a loading indicator.
              return const SizedBox(
                height: 250,
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            } else if (snapshot.hasError) {
              print('snapshot.error ${snapshot.error}');
              return const Text(
                  'An error occurred, Please restart the application');
            } else {
              // If the Future completes successfully, use the data.
              final data = snapshot.data;
              List<LiveGameWidget> widgets = [];
              for (var item in data!) {
                widgets.add(LiveGameWidget(leagueEvent: item));
              }
              return widgets.isNotEmpty ? Column(children: widgets) : const Text('No Live games at the moment, please check again later.');
              // return Column(children: widgets);
            }
          },
        ),
      ],
    );
  }
}
