import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../theme/themenotifer.dart';

class GeneralScreen extends StatefulWidget {
  const GeneralScreen({super.key});

  @override
  State<GeneralScreen> createState() => _GeneralScreenState();
}

class _GeneralScreenState extends State<GeneralScreen> {
  ColorNotifire notifire = ColorNotifire();
  List text = [
    'Automatic Refresh',
    'Clear Cache',
    'Default Sport',
    'Vibration',
    'Privacy and Cookies',
    'News Publishers',
    'Video Publishers',
    'Consent Preferences',
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
            child: Icon(Icons.arrow_back_sharp, color: notifire.textcolore,)),
        title: const Text("General"),
        titleTextStyle: TextStyle(fontFamily: "Urbanist_bold", color: notifire.textcolore, fontSize: 20,),
      ),
      body: Column(
        children: [
          ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            itemCount: text.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(text[index], style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600, fontFamily: 'Urbanist_semibold', color: notifire.textcolore),),
                    index == 2 ?  Row(
                      children: [
                        Text('Football', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600, fontFamily: 'Urbanist_semibold', color: notifire.textcolore),),
                        const SizedBox(width: 15,),
                        Icon(Icons.arrow_forward_ios_sharp, size: 15, color: notifire.textcolore,),
                      ],
                    ) : Icon(Icons.arrow_forward_ios_sharp, size: 15, color: notifire.textcolore,),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
