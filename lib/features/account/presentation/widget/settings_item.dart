import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:resultizer_merged/theme/themenotifer.dart';

class SettingsItemWidget extends StatelessWidget {
  final String title;
  final bool isSwitch;
  final bool switchValue;
  final Function(bool) onSwitchChanged;
  final VoidCallback onOpenIconPressed;
  ColorNotifire notifire = ColorNotifire();
  IconData buttonIcon;

  SettingsItemWidget({super.key, 
    required this.title,
    this.isSwitch = false,
    this.switchValue = false,
    required this.onSwitchChanged,
    required this.onOpenIconPressed,
    this.buttonIcon = Icons.arrow_forward_ios,
  });

  @override
  Widget build(BuildContext context) {
    notifire = Provider.of<ColorNotifire>(context, listen: true);
    return Column(
      children: [
        ListTile(
          title: Text(title, style: TextStyle(color: notifire.textcolore),),
          trailing: isSwitch
              ? Switch(
                  value: switchValue,
                  onChanged: onSwitchChanged,
                )
              : IconButton(
                  icon: Icon(buttonIcon, color: notifire.textcolore,),
                  onPressed: onOpenIconPressed,
                ),
        ),
        Divider(color: notifire.textcolore, height: 2,),
      ],
    );
  }
}
