import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:resultizer_merged/common/common_appbar.dart';
import 'package:resultizer_merged/core/widgets/custom_image.dart';
import 'package:resultizer_merged/features/home/data/models/fixture_teams_dto.dart';
import 'package:resultizer_merged/features/home/presentation/widget/view_team.dart';
import 'package:resultizer_merged/utils/constant/app_color.dart';


class FixtureDetails extends StatelessWidget {
  final String fixtureStatusLong;
  
  final String fixtureDate;
  
  final String fixtureLeagueSubtitle;
  
  final FixtureTeam homeTeam;
  
  final FixtureTeam awayTeam;
  
  final String fixtureStatusElapsed;

  const FixtureDetails({Key? key, required this.fixtureLeagueName, required this.fixtureStatusLong, required this.fixtureDate, required this.fixtureLeagueSubtitle, required this.homeTeam, required this.awayTeam, required this.fixtureLeagueLogo, required this.fixtureStatusElapsed})
      : super(key: key);

  final String fixtureLeagueName;
  final String fixtureLeagueLogo;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20),
      color: AppColor.pinkColor,
      // decoration: BoxDecoration(gradient: getGradientColor(soccerFixture)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ImageWithDefault(imageUrl: fixtureLeagueLogo, width: 20, height: 20),
              const SizedBox(width: 5),
              Text(
                fixtureLeagueName,
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge
                    ?.copyWith(color: AppColor.offWhite),
                textAlign: TextAlign.center,
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                child: ViewTeam(team: homeTeam),
              ),
              (fixtureStatusElapsed != null)
                  ? Expanded(child: buildFixtureResult(context))
                  : Expanded(child: buildFixtureTime(context)),
              Expanded(
                child: ViewTeam(team: awayTeam),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Container(
            padding: const EdgeInsets.symmetric(
                horizontal: 20, vertical: 5),
            decoration: BoxDecoration(
              color: notifire.bgcolore,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              fixtureStatusLong,
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium
                  ?.copyWith(color: notifire.isDark ? AppColor.offWhite : AppColor.pinkColor),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildFixtureResult(BuildContext context) {
    TextStyle? displaySmall = Theme.of(context)
        .textTheme
        .displaySmall
        ?.copyWith(color: AppColor.offWhite);

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              homeTeam.goals.toString(),
              style: displaySmall,
            ),
            const SizedBox(width: 10),
            Text(
              ":",
              style: displaySmall,
            ),
            const SizedBox(width: 10),
            Text(
              awayTeam.goals.toString(),
              style: displaySmall,
            ),
          ],
        ),
        const SizedBox(height: 5),
        buildFixtureRound(context),
      ],
    );
  }

  Widget buildFixtureTime(BuildContext context) {
    String fixtureTime = fixtureDate;
    final localTime = DateTime.parse(fixtureTime).toLocal();
    final formattedTime = DateFormat("h:mm a").format(localTime);
    return Column(
      children: [
        Text(
          formattedTime,
          style: Theme.of(context)
              .textTheme
              .headlineSmall
              ?.copyWith(color: AppColor.offWhite),
        ),
        const SizedBox(height: 5),
        buildFixtureRound(context),
      ],
    );
  }

  Widget buildFixtureRound(BuildContext context) => Text(
        fixtureLeagueSubtitle,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: AppColor.offWhite.withOpacity(0.9),
            ),
      );
}
