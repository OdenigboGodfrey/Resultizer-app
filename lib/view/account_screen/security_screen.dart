import 'package:flutter/material.dart';
import 'package:getwidget/components/toggle/gf_toggle.dart';
import 'package:getwidget/types/gf_toggle_type.dart';
import 'package:provider/provider.dart';
import 'package:resultizer/common/common_button.dart';

import '../../theme/themenotifer.dart';
import '../../utils/constant/app_color.dart';

class Securityscreen extends StatefulWidget {
  const Securityscreen({super.key});

  @override
  State<Securityscreen> createState() => _SecurityscreenState();
}

class _SecurityscreenState extends State<Securityscreen> {
  ColorNotifire notifire = ColorNotifire();
  @override
  Widget build(BuildContext context) {
    notifire = Provider.of<ColorNotifire>(context, listen: true);
    List text = [
      'Remember me',
      'Biometric ID',
      'Face ID',
    ];
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
        title: const Text("Security"),
        titleTextStyle: TextStyle(
          fontFamily: "Urbanist_bold",
          color: notifire.textcolore,
          fontSize: 20,
        ),
      ),
      body: Column(
        children: [
          ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            itemCount: text.length,
            itemBuilder: (context, index) {
              return ListTile(
                leading: Text(
                  text[index],
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Urbanist_semibold',
                      color: notifire.textcolore),
                ),
                trailing: GFToggle(
                  onChanged: (value) {},
                  value: false,
                  enabledThumbColor: Colors.white,
                  enabledTrackColor: AppColor.pinkColor,
                  type: GFToggleType.ios,
                ),
              );
            },
          ),
          ListTile(
            leading: Text(
              'Two-Factor Authentication',
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'Urbanist_semibold',
                  color: notifire.textcolore),
            ),
            trailing: Icon(
              Icons.arrow_forward_ios_rounded,
              size: 18,
              color: notifire.textcolore,
            ),
          ),
          const Padding(
            padding: EdgeInsets.all(15),
            child: CommonButton(
              height: 58,
              color: AppColor.babyPinkColor,
              buttonName: 'Change Password',
            ),
          ),
        ],
      ),
    );
  }
}
