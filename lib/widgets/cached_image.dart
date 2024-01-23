import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

Widget cachedImage(String url, {double? height, double? width}) {
  return CachedNetworkImage(
    imageUrl: url,
    fit: BoxFit.contain,
    placeholder: (context, url) {
      return const Center(child: CircularProgressIndicator());
    },
    imageBuilder: (context, imageProvider) => Image(image: imageProvider, fit: BoxFit.contain),
  );
}
