import 'package:flutter/material.dart';
import 'package:resultizer_merged/core/utils/app_sizes.dart';
import 'package:resultizer_merged/core/utils/convert_mediaQuery.dart';
import 'package:resultizer_merged/features/home/data/models/bet_model_dto.dart';
import 'package:resultizer_merged/features/home/presentation/widget/odd_modal_widget.dart';
import 'package:resultizer_merged/utils/constant/app_color.dart';
import 'package:resultizer_merged/utils/constant/app_string.dart';

class MatchOddsTile extends StatefulWidget {
  // final List<OddsModel> odds;
  final List<OddsModel> odds;

  const MatchOddsTile({required this.odds});

  @override
  _MatchOddsTileState createState() => _MatchOddsTileState();
}

class _MatchOddsTileState extends State<MatchOddsTile> {
  @override
  void initState() {
    super.initState();
    
  }

  bool _isExpanded = false;
  String betName = 'Who Will Win?';
  List<Widget> oddsWidgets = [];
  bool _isLoaded = false;

  @override
  Widget build(BuildContext context) {
    if (!_isLoaded) {
      _isLoaded = true;
      _buildOdds(setState, context);
    }
    return GestureDetector(
      onTap: () {
        setState(() {
          _isExpanded = !_isExpanded;
        });
      },
      child: Container(
        padding: const EdgeInsets.all(AppSize.s2),
        child: Column(
          children: [
            Text(
              betName,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: ConvertToMediaQuery.convertFontSizeToMediaQuery(AppSize.s14, context),
                  color: AppColor.offWhite),
            ),
            SizedBox(height:  ConvertToMediaQuery.convertHeightToMediaQuery(AppSize.s8, context)),
            Wrap(
              spacing: 0,
              runSpacing: 0,
              children: oddsWidgets, //_buildOdds(setState),
            ),
          ],
        ),
      ),
    );
  }

  void _buildOdds(Function setState, BuildContext context) {
    List<Widget> _oddsWidgets = [];
    bool oddsProcessed =
        false; // Flag to check if a relevant set of odds has been processed
    List<OddsModel> odds = widget.odds;
    String drawRepresentation = '🤝';
    for (var row in odds) {
      // for (var odd in bet.odds) {
      if (oddsProcessed) break;
      if (row.name == "1x2" ||
          row.name == "1x2 (1st Half)" ||
          row.name == "To Win 2nd Half") {
        setState(() {
          betName = row.name;
        });

        for (var odd in row.odds) {
          Color cardColor;
          Icon displayIcon;
          String displayText;
          String teamText;

          switch (odd.value.toLowerCase()) {
            case 'home':
              cardColor = AppColor.blackColor;
              displayIcon = Icon(
                Icons.home,
                size:  ConvertToMediaQuery.convertWidthToMediaQuery(AppSize.s20, context),
                color: AppColor.offWhite,
              );
              displayText = '${double.parse(odd.odd).toStringAsFixed(2)}';
              teamText = '1';
              break;
            case 'draw':
              cardColor = AppColor.blackColor;
              displayIcon = Icon(Icons.horizontal_rule,
                  size: ConvertToMediaQuery.convertWidthToMediaQuery(AppSize.s18, context), color: AppColor.offWhite);
              displayText = '${double.parse(odd.odd).toStringAsFixed(2)}';
              teamText = 'X';
              break;
            case 'away':
              cardColor = AppColor.blackColor;
              displayIcon = Icon(Icons.directions_walk,
                  size: ConvertToMediaQuery.convertWidthToMediaQuery(AppSize.s20, context), color: AppColor.offWhite);
              displayText = '${double.parse(odd.odd).toStringAsFixed(2)}';
              teamText = '2';
              break;
            default:
              cardColor = AppColor.blackColor;
              displayIcon = Icon(Icons.help,
                  size: ConvertToMediaQuery.convertWidthToMediaQuery(AppSize.s18, context), color: AppColor.offWhite);
              displayText =
                  'Unknown: ${double.parse(odd.odd).toStringAsFixed(2)}';
              teamText = '';
          }

          //;
          // setState(() {
          _oddsWidgets.add(
            Container(
              height: ConvertToMediaQuery.convertHeightToMediaQuery(50, context),
              width: ConvertToMediaQuery.convertWidthToMediaQuery(60, context),
              color: AppColor.blackColor,
              child: Card(
                color: cardColor,
                child: Padding(
                  padding: const EdgeInsets.all(5),
                  child: Column(
                    children: [
                      odd.value.toLowerCase() != 'draw'
                          ? displayIcon
                          : const Text(
                              AppString.drawRepresentation,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: AppSize.s14,
                                  color: AppColor.offWhite),
                            ),
                      const SizedBox(
                        width: AppSize.s3,
                      ),
                      Text(
                        displayText,
                        style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: AppSize.s12,
                            color: AppColor.offWhite),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        }
        if ((widget.odds.length - 1) > 0) {
          // more button
          _oddsWidgets.add(
            GestureDetector(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return OddModalWidget(
                      text: 'Shown Modal',
                      title: 'Additional odds',
                      odds: odds,
                    );
                  },
                );
              },
              child: Container(
                height: ConvertToMediaQuery.convertHeightToMediaQuery(50, context),
                width: ConvertToMediaQuery.convertWidthToMediaQuery(60, context),
                color: AppColor.blackColor,
                child: Card(
                  color: AppColor.blackColor,
                  child: Padding(
                    padding: const EdgeInsets.all(5),
                    child: Row(
                      children: [
                        const SizedBox(
                          width: AppSize.s5,
                        ),
                        Text(
                          '${widget.odds.length - 1} +',
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: AppSize.s14,
                              color: AppColor.offWhite),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        }
        setState(() {
          betName = row.name;
          oddsWidgets = _oddsWidgets;
        });
        oddsProcessed = true;
      }
    }
  }
}
