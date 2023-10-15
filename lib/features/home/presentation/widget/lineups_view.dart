import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:resultizer_merged/common/common_appbar.dart';
import 'package:resultizer_merged/features/home/data/models/lineup_dto.dart';
import 'package:resultizer_merged/features/home/presentation/widget/items_not_available.dart';
import 'package:resultizer_merged/features/home/presentation/widget/teams_lineups.dart';
import 'package:resultizer_merged/theme/themenotifer.dart';
import 'package:resultizer_merged/utils/constant/app_color.dart';
import 'package:resultizer_merged/utils/constant/app_string.dart';



class LineupsView extends StatelessWidget {
  final List<Lineup> lineups;

  LineupsView({Key? key, required this.lineups}) : super(key: key);
  ColorNotifire notifire = ColorNotifire();

  @override
  Widget build(BuildContext context) {
    notifire = Provider.of<ColorNotifire>(context, listen: true);
    return lineups.isNotEmpty
        ? Column(
            children: [
              buildTeamHeader(context: context, lineup: lineups[0]),
              Container(
                width: double.infinity,
                height: 625,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.fill,
                    image: AssetImage('assets/images/fixture/Football_playground.png'),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 15,
                    horizontal: 15,
                  ),
                  child: TeamsLineups(lineups: lineups),
                ),
              ),
              buildTeamHeader(context: context, lineup: lineups[1]),
            ],
          )
        : const ItemsNotAvailable(
            icon: Icons.people,
            message: AppString.noLineUp,
          );
  }

  Widget buildTeamHeader(
      {required BuildContext context, required Lineup lineup}) {
    return Container(
      color: !notifire.isDark ? AppColor.pinkColor : AppColor.blackColor,
      padding: const EdgeInsetsDirectional.all(5),
      child: Row(
        children: [
          Image(
            fit: BoxFit.cover,
            width: 35,
            height: 35,
            image: NetworkImage(lineup.team.logo!),
          ),
          const SizedBox(width: 10),
          Text(
            lineup.team.name!,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(color: AppColor.offWhite),
          ),
          const Spacer(),
          Text(
            lineup.formation,
            style: const TextStyle(
                color: Colors.white, fontSize: 18),
          ),
          const SizedBox(width: 10),
        ],
      ),
    );
  }
}
