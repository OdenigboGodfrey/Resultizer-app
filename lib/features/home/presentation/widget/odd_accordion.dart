import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:resultizer_merged/common/common_appbar.dart';
import 'package:resultizer_merged/core/utils/app_sizes.dart';
import 'package:resultizer_merged/features/home/data/models/bet_model_dto.dart';
import 'package:resultizer_merged/theme/themenotifer.dart';
import 'package:resultizer_merged/utils/constant/app_color.dart';
import 'package:resultizer_merged/utils/constant/app_string.dart';

class OddAccordion extends StatefulWidget {
  OddAccordion({super.key, required oddsData}) {
    data = Item.fromOddsModelList(oddsData);
  }
  // final List<OddsModel> oddsData;
  List<Item> data = [];

  @override
  State<OddAccordion> createState() => _OddAccordionState();
}

// List<Item> generateItems(int numberOfItems) {
//   return List<Item>.generate(numberOfItems, (int index) {
//     return Item(
//       headerValue: 'Panel $index',
//       expandedValue: 'This is item number $index',
//     );
//   });
// }

class Item {
  Item({
    required this.headerValue,
    this.isExpanded = false,
    required this.odds,
  });

  String headerValue;
  bool isExpanded;
  List<OddValue> odds;

  static List<Item> fromOddsModelList(List<OddsModel> data) {
    List<Item> result = [];
    for (OddsModel item in data) {
      result.add(Item(headerValue: item.name, odds: item.odds));
    }
    return result;
    // return Item(expandedValue: expandedValue, headerValue: data.name);
  }
}

class _OddAccordionState extends State<OddAccordion> {
  // List<Item> _data = generateItems(8);

  @override
  Widget build(BuildContext context) {
    notifire = Provider.of<ColorNotifire>(context, listen: true);
    return SingleChildScrollView(
      child: Container(
        child: _buildMultiPanels(),
      ),
    );
  }

  Widget _buildMultiPanels() {
    return ExpansionPanelList(
      dividerColor: notifire.bgcolore,
      expansionCallback: (int index, bool isExpanded) {
        setState(() {
          widget.data[index].isExpanded = !widget.data[index].isExpanded;
        });
      },
      children: widget.data.map<ExpansionPanel>((Item item) {
        return ExpansionPanel(
          backgroundColor: notifire.bgcolore,
          headerBuilder: (BuildContext context, bool isExpanded) {
            return Container(
              color: notifire.bgcolore,
              padding: const EdgeInsets.only(top: 10, left: 10),
              child: Text(
                item.headerValue,
                textAlign: TextAlign.justify,
                style: TextStyle(
                    color: notifire.textcolore,
                    fontWeight: FontWeight.bold,
                    fontSize: 18),
              ),
            );
          },
          body: Container(
            // width: 100,
            color: notifire.bgcolore,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                oddWidgdet(
                    AppColor.blackColor,
                    item.odds[0].value.toLowerCase() == AppString.homeString
                        ? '1'
                        : item.odds[0].value,
                    item.odds[0].odd,
                    const Icon(
                      Icons.home,
                      size: AppSize.s20,
                      color: AppColor.offWhite,
                    )),
                if (item.odds.length > 2)
                  oddWidgdet(
                      AppColor.blackColor,
                      item.odds[1].value,
                      item.odds[1].odd,
                      const Icon(
                        Icons.home,
                        size: AppSize.s20,
                        color: AppColor.offWhite,
                      )),
                oddWidgdet(
                    AppColor.blackColor,
                    item.odds.length > 2
                        ? (item.odds[2].value.toLowerCase() ==
                                AppString.awayString
                            ? '2'
                            : item.odds[2].value)
                        : item.odds[1].value.toLowerCase() ==
                                AppString.awayString
                            ? '2'
                            : item.odds[1].value,
                    item.odds.length > 2
                        ? (item.odds[2].odd)
                        : item.odds[1].odd,
                    const Icon(
                      Icons.directions_walk,
                      size: AppSize.s20,
                      color: AppColor.offWhite,
                    )),
              ],
            ),
          ),
          isExpanded: item.isExpanded,
        );
      }).toList(),
    );
  }

  Widget oddWidgdet(
      Color cardColor, String oddValue, String displayText, Icon displayIcon) {
    return Container(
      height: 65,
      width: 65,
      color: Colors.transparent,
      child: Card(
        color: cardColor,
        child: Padding(
          padding: const EdgeInsets.all(3),
          child: Column(
            children: [
              oddValue.toLowerCase() != 'draw'
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
    );
  }
}
