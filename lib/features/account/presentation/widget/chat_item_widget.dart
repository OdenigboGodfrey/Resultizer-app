import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:resultizer_merged/core/utils/show_confirmation_dialog.dart';
import 'package:resultizer_merged/core/widgets/custom_image.dart';
import 'package:resultizer_merged/features/account/data/models/chat_item_dto.dart';
import 'package:resultizer_merged/features/account/presentation/cubit/manage_chat_cubit.dart';
import 'package:resultizer_merged/features/home/data/models/premier_game_dto.dart';
import 'package:resultizer_merged/features/home/presentation/screen/fixture_screen.dart';
import 'package:resultizer_merged/theme/themenotifer.dart';

class ChatItemWidget extends StatefulWidget {
  final ChatMetaDTO item;
  final Function parentHandleDelete;

  const ChatItemWidget({
    super.key,
    required this.item,
    required this.parentHandleDelete,
  });

  @override
  State<ChatItemWidget> createState() => _ChatItemWidgetState();
}

class _ChatItemWidgetState extends State<ChatItemWidget> {
  ColorNotifire notifire = ColorNotifire();
  late int chatCount = 0;
  late ManageChatCubit manageChatCubit;

  @override
  void initState() {
    super.initState();
    getChatCount();
  }

  getChatCount() async {
    manageChatCubit = context.read<ManageChatCubit>();
    chatCount = await manageChatCubit.countChat(widget.item.fixtureId);
    setState(() {});
  }

  deleteChat() async {
    manageChatCubit = context.read<ManageChatCubit>();
    manageChatCubit.deleteChat(widget.item.fixtureId).then((value) {
      if (value) {
        widget.parentHandleDelete(value);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    notifire = Provider.of<ColorNotifire>(context, listen: true);
    var item = widget.item;
    var current = DateTime.now();
    var currentDate = current.day;
    var currentMonth = current.month;
    var matchDate = widget.item.matchTime;

    Size size = MediaQuery.of(context).size;
    double height = size.height;
    double width = size.width;

    var gameTime = DateFormat('hh:mm').format(item.matchTime);
    return Column(
      children: [
        Container(
          height: 80,
          width: width,
          child: ListTile(
            contentPadding: EdgeInsets.symmetric(horizontal: 2),
            leading: SizedBox(
              width: 0.1 * width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // widget.leagueEvent.games[index].gameTime
                  if (!(currentDate == matchDate.day &&
                      currentMonth == matchDate.month))
                    Text(
                        '${DateFormat('dd').format(item.matchTime)} ${DateFormat('MMM').format(item.matchTime)}',
                        style: TextStyle(
                          fontFamily: 'Urbanist_bold',
                          fontSize: 10,
                          fontWeight: FontWeight.w700,
                          color: notifire.textcolore,
                        )),
                  Text(gameTime,
                      style: TextStyle(
                        fontFamily: 'Urbanist_bold',
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        color: notifire.textcolore,
                      ))
                ],
              ),
            ),
            title: Container(
              width: 0.65 * width,
              child: Row(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (item.fixtureId == 0)
                        Row(
                          children: [
                            ImageWithDefault(
                              defaultImageUri: 'assets/images/no_image.png',
                              imageUrl: item.homeTeamLogo,
                              height: 30,
                              width: 30,
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              'General Tips',
                              style: TextStyle(
                                fontFamily: 'Urbanist_bold',
                                fontSize: 13,
                                fontWeight: FontWeight.w700,
                                color: notifire.textcolore,
                              ),
                              maxLines: 2,
                              softWrap: true,
                            ),
                          ],
                        ),
                      if (item.fixtureId != 0)
                        Column(
                          children: [
                            Row(
                              children: [
                                ImageWithDefault(
                                  defaultImageUri: 'assets/images/no_image.png',
                                  imageUrl: item.homeTeamLogo,
                                  height: 30,
                                  width: 30,
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  item.homeTeam,
                                  style: TextStyle(
                                    fontFamily: 'Urbanist_bold',
                                    fontSize: 13,
                                    fontWeight: FontWeight.w700,
                                    color: notifire.textcolore,
                                  ),
                                  maxLines: 2,
                                  softWrap: true,
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Row(
                              children: [
                                ImageWithDefault(
                                  defaultImageUri: 'assets/images/no_image.png',
                                  imageUrl: item.awayTeamLogo,
                                  height: 30,
                                  width: 30,
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  item.awayTeam,
                                  style: TextStyle(
                                    fontFamily: 'Urbanist_bold',
                                    fontSize: 13,
                                    fontWeight: FontWeight.w700,
                                    color: notifire.textcolore,
                                  ),
                                  maxLines: 2,
                                  softWrap: true,
                                ),
                              ],
                            ),
                          ],
                        )
                    ],
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Container(
                    height: 30,
                    width: 50,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(20)),
                      color: notifire.reverseBgColore,
                    ),
                    child: Row(
                      children: [
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          chatCount.toString(),
                          style: TextStyle(
                              color: notifire.reverseTextColore, fontSize: 14),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Icon(
                          Icons.message_outlined,
                          color: notifire.reverseTextColore,
                          size: 14,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            trailing: Container(
              width: 0.2 * width,
              padding: const EdgeInsets.all(5),
              child: Row(children: [
                GestureDetector(
                  child: Icon(
                    Icons.delete_outline,
                    color: notifire.textcolore,
                  ),
                  onTap: () {
                    showConfirmationDialog(context, () => deleteChat());
                  },
                ),
                const SizedBox(
                  width: 5,
                ),
                if (item.fixtureId != 0)
                  GestureDetector(
                    child: Icon(
                      Icons.arrow_forward_ios,
                      color: notifire.textcolore,
                    ),
                    onTap: () {
                      Get.to(FixtureScreen(
                          leagueName: item.leagueName,
                          leagueLogo: item.leagueLogo,
                          leagueSubtitle: item.leagueSubtitle,
                          leagueId: item.leagueId,
                          game: PremierGameDTO(
                              gameTime: gameTime,
                              homeLogo: item.awayTeamLogo,
                              homeTeam: item.awayTeam,
                              awayLogo: item.awayTeamLogo,
                              awayTeam: item.awayTeam,
                              matchStatus: '',
                              matchTime: item.matchTime,
                              fixtureId: item.fixtureId,
                              awayTeamId: item.awayTeamId,
                              homeTeamId: item.homeTeamId,
                          )));
                    },
                  )
              ]),
            ),
          ),
        ),
        Divider(
          color: notifire.textcolore,
          height: 2,
        ),
        const SizedBox(
          height: 10,
        ),
      ],
    );
  }
}
