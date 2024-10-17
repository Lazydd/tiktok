import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:tiktok/common/index.dart';

class ImageWidget extends StatelessWidget {
  final String url;
  final String errUrl;

  final double? width;

  final double? height;

  final BoxFit? fit;

  const ImageWidget(
    this.url, {
    super.key,
    this.errUrl = AssetsImages.avatarPng,
    this.width = double.infinity,
    this.height = double.infinity,
    this.fit = BoxFit.cover,
  });

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: url,
      fit: fit,
      height: height,
      width: width,
      // progressIndicatorBuilder: (context, url, downloadProgress) => Center(
      //   child: CircularProgressIndicator(value: downloadProgress.progress),
      // ),
      errorWidget: (context, url, error) => Image.asset(
        errUrl,
        height: height,
        width: width,
        fit: fit,
      ),
    );
  }
}
