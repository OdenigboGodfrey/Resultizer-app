import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class ImageWithDefault extends StatefulWidget {
  final String imageUrl;
  String? defaultImage = 'assets/images/no_image.png';
  final double? width;
  final double height;
  BoxFit? fit;

  ImageWithDefault(
      {Key? key, required this.imageUrl, String? defaultImageUri, required this.width, required this.height, this.fit = BoxFit.fill})
    {
      if (defaultImageUri != null) defaultImage = defaultImageUri.toString();
    }

  @override
  State<ImageWithDefault> createState() => _ImageWithDefaultState();
}

class _ImageWithDefaultState extends State<ImageWithDefault> {
  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: widget.imageUrl,
      placeholder: (context, url) => Image.asset(widget.defaultImage.toString()),
      errorWidget: (context, url, error) => Image.asset(widget.defaultImage.toString()),
      width: widget.width,
      height: widget.height,
      fit: widget.fit,

    );
  }
}
