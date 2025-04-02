import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:kichikichi/commons/values.dart';

class ImageViewer extends StatelessWidget {
  const ImageViewer(this.url, {super.key, this.fit, this.width, this.height});
  final String? url;
  final BoxFit? fit;
  final double? width, height;
  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: url ?? defaultImage,
      placeholder: (context, url) => const SizedBox(
        height: 50,
        width: 50,
        child: Center(child: CircularProgressIndicator()),
      ),
      width: width,
      height: height,
      errorWidget: (context, url, error) =>
          const Center(child: Icon(Icons.broken_image, size: 50)),
      fit: fit ?? BoxFit.cover,
    );
  }
}
