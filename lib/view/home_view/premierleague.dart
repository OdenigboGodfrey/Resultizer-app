// ignore_for_file: camel_case_types, non_constant_identifier_names
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../theme/themenotifer.dart';
import '../../utils/constant/app_assets.dart';

class premierscreen extends StatefulWidget {
  const premierscreen({super.key});

  @override
  State<premierscreen> createState() => _premierscreenState();
}

class _premierscreenState extends State<premierscreen> {
  ColorNotifire notifire = ColorNotifire();
  int selectIndex = 0;
  int selectIndex1 = 0;
  int selectindex1 = 0;
  int selectindex = 0;
  int selectindex2 = 0;
  List text = [
    'Overview',
    'Matches',
    'Table',
    'News',
    'Video',
    'Player Stats',
    'Team Stats',
    'Squad',
  ];
  List time = [
    '10:00',
    '13:00',
    '15:30',
  ];
  List img = [
    'assets/images/folloeImage1.png',
    'assets/images/folloImage2.png',
    'assets/images/follow3.png',
  ];
  List country = [
    'Burnley',
    'Luton',
    'Brighton',
  ];
  List img1 = [
    'assets/images/follow4.png',
    'assets/images/folloeImage1.png',
    'assets/images/Everton.png',
  ];
  List country1 = [
    'Manchester',
    'Fulham',
    'Everton',
  ];
  List num = [
    '1',
    '2',
    '3',
    '4',
    '5',
  ];
  List img2 =[
    'assets/images/folloeImage1.png',
    'assets/images/folloImage2.png',
    'assets/images/follow3.png',
    'assets/images/follow4.png',
    'assets/images/follow3.png',
  ];
  List title = [
    'Messy',
    'Ronald',
    'Kohan roh',
    'fignij',
    'Rajion'
  ];
  List subtitle = [
    'Burnley',
    'Manchester',
    'London',
    'Bournemouth',
    'Everton',
  ];
  List trailing = [
    '18',
    '12',
    '10',
    '05',
    '01',
  ];
  List result = [
    'FT',
    'FT',
  ];
  List winner = [
    '0',
    '4',
  ];
  List winner1 = [
    '2',
    '3',
  ];
  List news = [
    AppAssets.news,
    AppAssets.news1,
    AppAssets.news2,
    AppAssets.news3,
    AppAssets.news4,
    AppAssets.news,
  ];
  List title1 = [
    'Bellingham close to\nthe complete player\nafter England per',
    'Rice claims England\nare starting to\nsilence the critics',
    'Southgate hails\nEngland  young\nlions as France lie',
    'Kane hopes Senegal\nstrike sparks scoring\nrun for England',
    'Kane overtakes\nLineker as England\ntop tournament',
    'Bellingham close to\nthe complete player\nafter England per',
  ];
  List subtitle1 = [
    '1 hour ago',
    '8 hours ago',
    '15 hours ago',
    '1 day ago',
    '2 days ago',
    '4 days ago'
  ];
  List time1 = [
    '01:57',
    '02:35',
    '02:44',
    '01:35',
    '01:43',
    '02:35',
  ];
  List video = [
    '75K views • 10 hours ago',
    '103K views • 18 hours ago',
    '98K views • 1 day ago',
    '146K views • 2 days ago',
    '137K views • 2 days ago',
    '90K views • 3 hours ago',
  ];
  List no = [
    '1',
    '12',
    '23',
  ];
  List goultext = [
    'Dominik',
    'Grbic',
    'Ivica',
  ];
  List defeno = [
    '2',
    '3',
    '5',
    '6',
    '19',
    '21',
    '30',
    '37',
    '45',
  ];
  List defname = [
    'Josip',
    'Born',
    'Marti',
    'Koichi',
    'Joko',
    'Domagoj',
    'Alon',
    'Jatin',
    'lanil',
  ];
  @override
  Widget build(BuildContext context) {
    notifire = Provider.of<ColorNotifire>(context, listen: true);
    return DefaultTabController(
      length: 2,
      initialIndex: 0,
      child: Scaffold(
       backgroundColor: notifire.background,
        appBar: AppBar(
          backgroundColor: notifire.background,
          leading: GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Icon(Icons.arrow_back, color: notifire.textcolore),
          ),
          title: const Text("Premier League"),
          titleTextStyle: TextStyle(fontFamily: "Urbanist_bold", color: notifire.textcolore, fontSize: 20,),
          actions: const [
            Icon(Icons.star, color: Colors.amber,),
            SizedBox(width: 20,),
          ],
        ),

      ),
    );
  }


}