import 'package:flutter/material.dart';
import 'package:resultizer_merged/core/utils/app_sizes.dart';
import 'package:resultizer_merged/core/widgets/custom_image.dart';
import 'package:resultizer_merged/features/match_detail/data/models/fixture_teams_dto.dart';

class ViewTeam extends StatelessWidget {
  final FixtureTeam team;

  const ViewTeam({Key? key, required this.team}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CircleAvatar(
          backgroundColor: Colors.white,
          radius: AppSize.s35,
          child: ImageWithDefault(imageUrl: team.logo.toString(), width: 50, height: 50),
        ),
        const SizedBox(height: AppSize.s10),
        FittedBox(
          child: Text(
            team.name!.split(" ").length >= 3
                ? team.name.toString().split(" ").sublist(0, 2).join(" ")
                : team.name.toString(),
            textAlign: TextAlign.center,
            style: Theme.of(context)
                .textTheme
                .titleMedium
                ?.copyWith(color: Colors.white),
          ),
        ),
      ],
    );
  }
}
