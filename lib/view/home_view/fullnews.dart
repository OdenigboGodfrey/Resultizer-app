import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:resultizer_merged/utils/constant/app_color.dart';

import '../../theme/themenotifer.dart';
import '../../utils/constant/app_assets.dart';

class FullnewsScreen extends StatefulWidget {
  const FullnewsScreen({super.key});

  @override
  State<FullnewsScreen> createState() => _FullnewsScreenState();
}

class _FullnewsScreenState extends State<FullnewsScreen> {
  ColorNotifire notifire = ColorNotifire();
  List img = [
    AppAssets.news,
    AppAssets.news1,
    AppAssets.news2,
    AppAssets.news3,
    AppAssets.news1,
  ];
  List title = [
    'Ronaldo holds the records for most in Champions League',
    'He has also had a successful international win the 2016',
    'Ronaldo holds the records for most in Champions League',
    'He has also had a successful international win the 2016',
    'He has also had a successful international win the 2016',
  ];
  List subtitle = [
    '1 day ago',
    '2 days ago',
    '12 days ago',
    '1 day ago',
    '1 months ago'
  ];
  @override
  Widget build(BuildContext context) {
    notifire = Provider.of<ColorNotifire>(context, listen: true);
    return Scaffold(
      backgroundColor: notifire.bgcolore,
      appBar: AppBar(
        backgroundColor: notifire.bgcolore,
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
            child: Icon(Icons.arrow_back_outlined, color: notifire.textcolore)),
        actions: [
          Image.asset(AppAssets.send, height: 28, width: 28, color: notifire.textcolore),
          const SizedBox(width: 15,),
          Image.asset(AppAssets.more, height: 28, width: 28, color: notifire.textcolore),
          const SizedBox(width: 15,),
        ],
      ),
      body: Column(
          children: [
            // Top news Photo
            Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(30),
                child: const Image(
                  height: 200,
                  width: 350,
                  fit: BoxFit.cover, image: AssetImage(AppAssets.ronaldo),),
              ),
            ),
            // News Details
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
              child: Text('Ronaldo holds the records for most in Champions League', style: TextStyle(fontFamily: 'Urbanist_bold', fontWeight: FontWeight.w700, fontSize: 24, color: notifire.textcolore),),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15,),
              child: Row(
                children: [
                  Text('10 hours ago   ', style: TextStyle(fontFamily: 'Urbanist_medium', fontWeight: FontWeight.w500, fontSize: 12, color: notifire.textcolore),),
                  const Text('#football  #worldcup  #cristianoronaldo', style: TextStyle(fontFamily: 'Urbanist_medium', fontWeight: FontWeight.w500, fontSize: 12, color: AppColor.pinkColor),),
                ],
              ),
            ),

            // News Subtitle
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
              child: Text('Cristiano Ronaldo denied on Tuesday that he has agreed to join Saudi club Al Nassr after Portugal World Cup adventure.\n\nThe striker became a free agent after being released from his Manchester United contract last month and reports have claimed Ronaldo has agreed an extraordinarily lucrative deal to play in Saudi Arabia.\n\nSuggestions of a bumper contract offer from the Saudi Pro League club emerged last week, with Ronaldo said to be in line to earn well over £100million a year.\n\nHowever, the 37-year-old superstar says reports of him signing a deal with Al Nassr are wrong.\n\nSpeaking after coming off the bench in Portugal 6-1 win over Switzerland at the World Cup, a rare substitute appearance for his country, Ronaldo was asked about the move.\n\n"No, it not true, he told reporters.\n\nRonaldo was allowed to leave United after a television interview with Piers Morgan saw him criticise the club owners and signal his lack of respect for manager Erik ten Hag.\n\nHe said he felt "betrayed" by United, alleging there were efforts being made to force him out, with his second stint at Old Trafford ending less than 18 months after his arrival from Juventus.',
                style: TextStyle(fontFamily: 'Urbanist_medium', fontWeight: FontWeight.w500, fontSize: 16, color: notifire.textcolore),
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(left: 15, right: 15),
              child: Row(
                children: [
                  Text('Related News', style: TextStyle(fontFamily: 'Urbanist_bold', fontWeight: FontWeight.w700, fontSize: 24, color: notifire.textcolore),),
                  const Expanded(child: SizedBox(width: 170,)),
                  Image.asset(AppAssets.right, height: 24, width: 24,),
                ],
              ),
            ),

            // Related News
            ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              itemCount: img.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(top: 15),
                  child: ListTile(
                    leading: Image.asset(img[index]),
                    title: Text(title[index], style:  TextStyle(fontFamily: 'Urbanist_bold', fontWeight: FontWeight.w700, fontSize: 15, color: notifire.textcolore),),
                    subtitle: Text(subtitle[index], style:  TextStyle(fontFamily: 'Urbanist_medium', fontSize: 12, fontWeight: FontWeight.w500, color: notifire.textcolore),),
                    trailing:  Transform.translate(
                        offset: const Offset(0, -15),
                        child: Icon(Icons.more_vert, color: notifire.textcolore,)),
                  ),
                );
              },),
            const SizedBox(height: 10,),
          ],
        ),
      
    );
  }
}
