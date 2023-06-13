

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ImageWidget extends StatelessWidget {
  const ImageWidget(
      {super.key,
      required this.imageUrl,
      this.width = 0.0,
      this.height = 0.0,
      this.iconSize = 14,
      this.assetImagePath});

  final String? imageUrl;
  final double width;
  final double height;
  final String? assetImagePath;
  final double iconSize;

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
        placeholder: (context, url) => const Center(
              child: CircularProgressIndicator(),
            ),
        imageUrl: imageUrl ?? '',
        fit: BoxFit.cover,
        width: width != 0.0 ? width : null,
        height: height != 0.0 ? height : null,
        errorWidget: (context, url, error) => Icon(Icons.error_outline_outlined,size: iconSize,),);
  }
}
