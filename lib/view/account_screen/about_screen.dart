import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:resultizer/utils/constant/app_assets.dart';

import '../../theme/themenotifer.dart';

class AboutScreen extends StatefulWidget {
  const AboutScreen({super.key});

  @override
  State<AboutScreen> createState() => _AboutScreenState();
}

class _AboutScreenState extends State<AboutScreen> {
  ColorNotifire notifire = ColorNotifire();
  List text = [
    'Job Vacancy',
    'Fees',
    'Developer',
    'Partner',
    'Privacy Policy',
    'Accessibility',
    'Feedback',
    'Rate us',
    'Visit Our Website',
    'Follow us on Social Media',
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
            child: Icon(
              Icons.arrow_back_sharp,
              color: notifire.textcolore,
            )),
        title: const Text("About Resultizer"),
        titleTextStyle: TextStyle(
          fontFamily: "Urbanist_bold",
          color: notifire.textcolore,
          fontSize: 20,
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Image.asset(
                AppAssets.logoImage,
                height: 100,
                width: 100,
              ),
              Text(
                'Resultizer v9.4.5',
                style: TextStyle(
                    fontFamily: 'Urbanist_bold',
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                    color: notifire.textcolore),
              ),
              Padding(
                padding: const EdgeInsets.all(18),
                child: Divider(
                  height: 10,
                  thickness: 1,
                  color: notifire.borercolour,
                ),
              ),
              ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: text.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: Text(
                      text[index],
                      style: TextStyle(
                          fontFamily: 'Urbanist_semibold',
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: notifire.textcolore),
                    ),
                    trailing: Icon(
                      Icons.arrow_forward_ios_rounded,
                      size: 15,
                      color: notifire.textcolore,
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
