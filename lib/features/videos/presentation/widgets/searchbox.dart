import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:resultizer_merged/theme/themenotifer.dart';

class SearchBoxWidget extends StatelessWidget {
  final TextEditingController controller;
  final ValueChanged<String>? onChanged;
  ColorNotifire notifire = ColorNotifire();

  SearchBoxWidget({super.key, required this.controller, this.onChanged});

  @override
  Widget build(BuildContext context) {
    notifire = Provider.of<ColorNotifire>(context, listen: true);
    return TextField(
      controller: controller,
      onChanged: onChanged,
      style: TextStyle(height: 1, color: notifire.textcolore, ),
      decoration: InputDecoration(
        labelText: 'Filter',
        labelStyle: TextStyle(color: notifire.textcolore),
        prefixIcon: Icon(Icons.search, color: notifire.textcolore,),
      ),
    );
  }
}
