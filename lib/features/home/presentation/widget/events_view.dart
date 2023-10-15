import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:resultizer_merged/core/widgets/custom_image.dart';
import 'package:resultizer_merged/features/home/data/models/events_dto.dart';
import 'package:resultizer_merged/theme/themenotifer.dart';
import 'package:resultizer_merged/utils/constant/app_color.dart';
import 'package:resultizer_merged/utils/constant/app_string.dart';

class EventsView extends StatelessWidget {
  final List<EventModel> events;
  final Color color;

  EventsView({Key? key, required this.events, required this.color})
      : super(key: key);
  ColorNotifire notifire = ColorNotifire();

  @override
  Widget build(BuildContext context) {
    notifire = Provider.of<ColorNotifire>(context, listen: true);
    return events.isNotEmpty
        ? Padding(
            padding: const EdgeInsets.all(2),
            child: ListView.builder(
              shrinkWrap: true,
              physics: const BouncingScrollPhysics(),
              scrollDirection: Axis.vertical,
              itemBuilder: (context, index) => Card(
                color: notifire.bgcolore,
                child: Padding(
                  padding: const EdgeInsetsDirectional.all(20),
                  child: Column(
                    children: [
                      eventTeam(events[index], context),
                      const SizedBox(height: 10),
                      eventDetails(events[index], context),
                    ],
                  ),
                ),
              ),
              itemCount: events.length,
            ),
          )
        : const Text(
            AppString.noEvents,
            // icon: Icons.event_busy,
          );
  }

  Widget eventDetails(EventModel event, BuildContext context) => Row(
        children: [
          CircleAvatar(
            radius: 15,
            backgroundColor: color,
            child: Text(
              event.time.elapsed.toString(),
              style: Theme.of(context)
                          .textTheme
                          .bodySmall
                          ?.copyWith(color: AppColor.offWhite),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      event.type,
                      textAlign: TextAlign.start,
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium
                          ?.copyWith(color: notifire.textcolore),
                    ),
                    Text(
                      event.detail,
                      textAlign: TextAlign.end,
                      style: Theme.of(context)
                          .textTheme
                          .bodySmall
                          ?.copyWith(color: notifire.textcolore),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                if (event.type == AppString.goal) eventGoal(event, context),
                if (event.type == AppString.card) eventCard(event, context),
                if (event.type == AppString.subst) eventSubset(event, context)
              ],
            ),
          ),
        ],
      );

  Widget eventTeam(EventModel event, BuildContext context) => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ImageWithDefault(
              imageUrl: event.team.logo.toString(), width: 20, height: 20),
          const SizedBox(width: 10),
          Text(
            event.team.name.toString(),
            style: Theme.of(context)
                .textTheme
                .bodyMedium
                ?.copyWith(color: notifire.textcolore),
          ),
        ],
      );

  Widget eventSubset(EventModel event, BuildContext context) => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              event.assist.name ?? '',
              textAlign: TextAlign.start,
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium
                  ?.copyWith(color: Colors.red),
            ),
          ),
          const Image(
            width: 40,
            height: 40,
            image: AssetImage('assets/images/fixture/substitute.jpg'),
          ),
          Expanded(
            child: Text(
              event.player.name!,
              textAlign: TextAlign.end,
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium
                  ?.copyWith(color: Colors.green),
            ),
          ),
        ],
      );

  Widget eventCard(EventModel event, BuildContext context) => Row(
        children: [
          Expanded(
            child: Text(
              event.player.name ?? '',
              textAlign: TextAlign.start,
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium
                  ?.copyWith(color: notifire.textcolore),
            ),
          ),
          Container(
            color: event.detail == AppString.yellowCard
                ? AppColor.yellow
                : Colors.red,
            width: 20,
            height: 30,
          ),
          Expanded(child: Container()),
        ],
      );

  Widget eventGoal(EventModel event, BuildContext context) => Row(
        children: [
          Expanded(
            child: Text(
              event.player.name ?? '',
              textAlign: TextAlign.start,
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium
                  ?.copyWith(color: Colors.green),
            ),
          ),
          event.detail != AppString.missedPenalty
              ? Icon(Icons.sports_soccer, size: 30, color: notifire.textcolore,)
              : penaltyMissed(),
          Expanded(
            child: Column(
              children: [
                if (event.assist.name != null)
                  Text(
                    "${AppString.assist}: ${event.assist.name?.split(" ").last}",
                    textAlign: TextAlign.end,
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium
                        ?.copyWith(color: Colors.red),
                  ),
              ],
            ),
          ),
        ],
      );

  Widget penaltyMissed() => Stack(
        alignment: AlignmentDirectional.bottomEnd,
        children: const [
          Icon(Icons.sports_soccer, size: 30),
          CircleAvatar(
            radius: 8,
            backgroundColor: Colors.red,
            child: Icon(Icons.close, color: Colors.white, size: 10),
          ),
        ],
      );
}
