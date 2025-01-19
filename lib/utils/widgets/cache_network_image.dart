import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:video_app/utils/constants/image_path.dart';

class CustomNetworkImage extends StatelessWidget {
  final String imageUrl;
  final BoxFit boxFit;
  final double? height;
  final double? width;
  final String errorImage;
  final Widget? placeHolder;
  final double borderRadius;
  final int? memCacheHeight;
  final int? memCacheWidth;
  const CustomNetworkImage({
    super.key,
    this.borderRadius = 0,
    required this.imageUrl,
    this.boxFit = BoxFit.cover,
    this.height,
    this.width,
    this.errorImage = ImagePath.placeHolder,
    this.placeHolder,
    this.memCacheHeight,
    this.memCacheWidth,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: CachedNetworkImage(
        // memCacheHeight: memCacheHeight ?? 200,
        // memCacheWidth: memCacheWidth ?? 200,
        // // memCacheHeight: 857,
        // memCacheWidth: 568,

        imageUrl: imageUrl,
        fit: boxFit,
        cacheKey: imageUrl,
        height: height,
        width: width,
        errorWidget: (context, url, error) => Image.asset(
          errorImage,
          fit: boxFit,
        ),
      ),
    );
  }
}
