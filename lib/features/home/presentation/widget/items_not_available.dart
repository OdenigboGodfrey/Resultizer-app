import 'package:flutter/material.dart';
import 'package:resultizer_merged/core/utils/media_query.dart';

class ItemsNotAvailable extends StatelessWidget {
  final IconData icon;
  final String message;

  const ItemsNotAvailable({Key? key, required this.icon, required this.message})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: context.height / 2,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 100),
          const SizedBox(height: 10),
          Text(
            message,
            style: Theme.of(context)
                .textTheme
                .titleMedium
                ?.copyWith(color: Colors.black, letterSpacing: 1.1),
          ),
        ],
      ),
    );
  }
}
