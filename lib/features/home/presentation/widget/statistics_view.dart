import 'package:flutter/material.dart';
import 'package:get/utils.dart';
import 'package:provider/provider.dart';
import 'package:resultizer_merged/core/utils/app_sizes.dart';
import 'package:resultizer_merged/features/home/data/models/statistics_dto.dart';
import 'package:resultizer_merged/theme/themenotifer.dart';
import 'package:resultizer_merged/utils/constant/app_color.dart';
import 'package:resultizer_merged/utils/constant/app_string.dart';

class StatisticsView extends StatelessWidget {
  final List<StatisticsModel> statistics;

  StatisticsView({Key? key, required this.statistics}) : super(key: key);
  ColorNotifire notifire = ColorNotifire();

  @override
  Widget build(BuildContext context) {
    notifire = Provider.of<ColorNotifire>(context, listen: true);
    return statistics.isNotEmpty
        ? Column(
            children: [
              buildStatsHeader(),
              ListView.separated(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.all(20),
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                itemBuilder: (context, index) => buildStatsRow(
                  statisticHome: statistics[0].statistics[index],
                  statisticAway: statistics[1].statistics[index],
                ),
                separatorBuilder: (context, index) => const Divider(
                  height: AppSize.s20,
                ),
                itemCount: statistics[0].statistics.length,
              ),
            ],
          )
        : showNoStats(context);
  }

  Widget showNoStats(BuildContext context) => SizedBox(
        height: context.height / 2,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // const Image(
            //   image: AssetImage(AppAssets.noStats),
            //   width: AppSize.s200,
            //   height: AppSize.s200,
            // ),
            const SizedBox(height: AppSize.s10),
            Text(
              AppString.noStats,
              style: Theme.of(context)
                  .textTheme
                  .titleMedium
                  ?.copyWith(color: notifire.textcolore, letterSpacing: 1.1),
            ),
          ],
        ),
      );

  Padding buildStatsHeader() {
    return Padding(
      padding: const EdgeInsets.only(
          left: 10, right: 10, top: 10),
      child: Row(
        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            // flex: 3,
            child: Row(
              children: [
                Image(
                  width: AppSize.s20,
                  height: AppSize.s20,
                  image: NetworkImage(statistics[0].team.logo.toString()),
                ),
                const SizedBox(width: AppSize.s5),
                Text(statistics[0].team.name.toString(), textAlign: TextAlign.center, style: TextStyle(color: notifire.textcolore),),
              ],
            ),
          ),
          Expanded(
            // flex: 4,
            child: Row(
              children: [
                const SizedBox(width: AppSize.s10),
                Text('Match Stats', textAlign: TextAlign.center, style: TextStyle(color: notifire.textcolore),),
              ],
            ),
          ),
          Expanded(
            // flex: 3,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image(
                  width: AppSize.s20,
                  height: AppSize.s20,
                  image: NetworkImage(statistics[1].team.logo.toString()),
                ),
                const SizedBox(width: AppSize.s5),
                Text(statistics[1].team.name.toString(), textAlign: TextAlign.center, style: TextStyle(color: notifire.textcolore),),
              ],
            ),
          ),
        ],
      ),
    );
  }


Widget buildStatsRow(
        {required StatisticItemModel statisticHome, required StatisticItemModel statisticAway}) =>
    Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Expanded(
          child: Text(statisticHome.value, textAlign: TextAlign.center, style: TextStyle(color: notifire.textcolore),),
        ),
        Expanded(
          child: Text(
            statisticHome.type,
            textAlign: TextAlign.center,
            maxLines: 1, style: TextStyle(color: notifire.textcolore),
          ),
        ),
        Expanded(
          child: Text(statisticAway.value, textAlign: TextAlign.center, style: TextStyle(color: notifire.textcolore),),
        ),
      ],
    );
}