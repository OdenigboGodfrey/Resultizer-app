import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:resultizer_merged/core/widgets/custom_image.dart';
import 'package:resultizer_merged/theme/themenotifer.dart';

class CustomListItem extends StatelessWidget {
  final String? image;
  final String text;
  final Function onTap;
  ColorNotifire notifire = ColorNotifire();

  CustomListItem(
      {super.key, this.image, required this.text, required this.onTap});

  @override
  Widget build(BuildContext context) {
    notifire = Provider.of<ColorNotifire>(context, listen: true);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          if (image != null)
            ImageWithDefault(
              imageUrl: image.toString(),
              height: 30,
              width: 30,
            ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                text,
                style: TextStyle(fontSize: 18.0, color: notifire.textcolore),
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              onTap();
            },
            child: Icon(
              Icons.arrow_forward,
              size: 24.0,
              color: notifire.textcolore,
            ),
          ),
        ],
      ),
    );
  }
}
