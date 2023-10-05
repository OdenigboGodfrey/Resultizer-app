import 'package:flutter/material.dart';
import 'package:resultizer_merged/features/home/data/models/bet_model_dto.dart';
import 'package:resultizer_merged/utils/constant/app_color.dart';

class OddModalWidget extends StatelessWidget {
  final String title;
  final String text;
  final List<OddsModel> odds;

  final String homeString = 'home';
  final String drawString = 'draw';
  final String awayString = 'away';
  final String drawRepresentation = '🤝';

  const OddModalWidget(
      {super.key, required this.title, required this.text, required this.odds});
  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
          dialogBackgroundColor: AppColor.blackColor
          //backgroundColor: Colors.black, // Set your desired background color
          ),
      child: AlertDialog(
        backgroundColor: AppColor.blackColor,
        shadowColor: AppColor.blackColor,
        surfaceTintColor: Colors.transparent,
        titleTextStyle: const TextStyle(
            backgroundColor: AppColor.blackColor, color: AppColor.offWhite),
        title: Container(color: AppColor.blackColor, child: Text(title)),
        content: SingleChildScrollView(
          child: Container(
            height: odds.length < 5 ? 300 : MediaQuery.of(context).size.height,
            color: AppColor.blackColor,
            child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
              for (var child in odds) buildOddRow(child),
            ]),
          ),
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text("Close"),
          ),
        ],
      ),
    );
  }

  Widget buildOddRow(OddsModel odd) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // title e.g Full time
        Text(
          odd.name,
          style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: AppColor.offWhite,
              backgroundColor: Colors.transparent),
        ),
        // e.g 1x2/Over Under
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Expanded(
              child: Text(
                odd.odds[0].value.toLowerCase() == homeString
                    ? '1'
                    : odd.odds[0].value,
                textAlign: TextAlign.center,
                style: const TextStyle(
                    fontWeight: FontWeight.w400, color: AppColor.offWhite),
              ),
            ),
            if (odd.odds.length > 2)
              Expanded(
                child: Text(
                  odd.odds[1].value.toLowerCase() == drawString
                      ? 'X'
                      : odd.odds[1].value,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      fontWeight: FontWeight.w400, color: AppColor.offWhite),
                ),
              ),
            Expanded(
              child: Text(
                odd.odds.length > 2
                    ? (odd.odds[2].value.toLowerCase() == awayString
                        ? '2'
                        : odd.odds[2].value)
                    : odd.odds[1].value.toLowerCase() == 'away'
                        ? '2'
                        : odd.odds[1].value,
                //odd.odds.length > 2 ? odd.odds[2].value : odd.odds[1].value,
                textAlign: TextAlign.center,
                style: const TextStyle(
                    fontWeight: FontWeight.w400, color: AppColor.offWhite),
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 1,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Expanded(
              child: buildSingleOdd(odd.odds[0].odd),
            ),
            if (odd.odds.length > 2)
              Expanded(
                child: buildSingleOdd(odd.odds[1].odd),
              ),
            Expanded(
              child: buildSingleOdd(
                odd.odds.length > 2 ? odd.odds[2].odd : odd.odds[1].odd,
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 4,
        ),
      ],
    );
  }

  Widget buildSingleOdd(String odd) {
    return Container(
      margin: const EdgeInsets.only(left: 7, right: 7),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(5)),
        color: AppColor.greyColor,
      ),
      child: Text(
        odd,
        textAlign: TextAlign.center,
        style: const TextStyle(
          fontWeight: FontWeight.w400,
          color: AppColor.blackColor,
        ),
      ),
    );
  }
}
