import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:agriunions_logistics/helper/AppColors.dart';
import 'package:agriunions_logistics/helper/custom_cache_manager.dart';
import 'package:agriunions_logistics/helper/enums.dart';

class LoadNetworkImage extends StatelessWidget {
  final String? src;
  final bool isCustomCacheManager;
  final LoadingType loadingType;
  final ErrorAssetsType errorAssetsType;
  final BoxFit fit;
  final double width;
  final double height;

  const LoadNetworkImage({
    required this.src,
    this.isCustomCacheManager = true,
    this.loadingType = LoadingType.threeBounce,
    this.errorAssetsType = ErrorAssetsType.vehicle,
    this.fit = BoxFit.cover,
    this.width = double.infinity,
    this.height = double.infinity,
  });

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      cacheManager: isCustomCacheManager ? CustomCacheManager.instance : null,
      fit: fit,
      width: width,
      height: height,
      imageUrl: src ?? "",
      placeholder: (context, url) {
        switch (loadingType) {
          case LoadingType.fadingCube:
            return Center(
              child: SpinKitFadingCube(
                color: Colors.yellow[700],
                size: 20,
              ),
            );
          case LoadingType.circularProgress:
            return CircularProgressIndicator();
          default:
            return Center(
              child: SpinKitThreeBounce(
                color: Colors.yellow[700],
                size: 20,
              ),
            );
        }
      },
      errorWidget: (context, url, error) {
        switch (errorAssetsType) {
          case ErrorAssetsType.vehicle:
            return Image.asset(
              "assets/icons/car.png",
              color: AppColors.Russet,
              fit: fit,
              width: width,
              height: height,
            );
          case ErrorAssetsType.chatImage:
            return Image.asset(
              "assets/images/error_attachment.jpg",
              fit: fit,
              width: width,
              height: height,
            );
          default:
            return Image.asset(
              "assets/images/logo.png",
              fit: fit,
              width: width,
              height: height,
            );
        }
      },
    );
  }
}
