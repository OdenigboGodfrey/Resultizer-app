import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../common/common_appbar.dart';
import '../../theme/themenotifer.dart';
import '../../utils/constant/app_assets.dart';

class NewsviewScreen extends StatefulWidget {
  const NewsviewScreen({super.key});

  @override
  State<NewsviewScreen> createState() => _NewsviewScreenState();
}

class _NewsviewScreenState extends State<NewsviewScreen> {

  final PageController controller = PageController();
  int selectIndex = 0;
  ColorNotifire notifire = ColorNotifire();
  List text = [
    'All',
    'Football',
    'World Cup 2022',
    'Premier League',
  ];
  List img = [
    AppAssets.news,
    AppAssets.news1,
    AppAssets.news2,
    AppAssets.news3,
  ];
  List title = [
    'Ronaldo holds the records for most in Champions League',
    'He has also had a successful international win the 2016',
    'Ronaldo holds the records for most in Champions League',
    'He has also had a successful international win the 2016',
  ];
  List subtitle = [
    '12 hours ago',
    '1 days ago',
    '4 days ago',
    '1 months ago',
  ];
  @override
  Widget build(BuildContext context) {
    notifire = Provider.of<ColorNotifire>(context, listen: true);
    return Scaffold(
      backgroundColor: notifire.background,
      key: key,
      drawer: const drawer1(),
      appBar: commonappbar(title: 'News', image: AppAssets.search, context: context),
      body: const SingleChildScrollView(

      ),
    );
  }
}
