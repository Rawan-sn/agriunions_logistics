import 'dart:io';

import 'package:flutter/material.dart';
import 'package:agriunions_logistics/Localization/AppLocal.dart';
import 'package:agriunions_logistics/helper/enums.dart';
import 'package:agriunions_logistics/user_interfaces/widget/load_network_image.dart';
import 'package:photo_view/photo_view.dart';

class ImageView extends StatelessWidget {
  final String? imagePath;
  final bool isNetworkUrl;
  final bool isChat;
  ImageView({
    Key? key,
    this.imagePath,
    this.isNetworkUrl = false,
    this.isChat=false
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context)!.trans("image_view")!,
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Center(
        child: PhotoView.customChild(
          minScale: PhotoViewComputedScale.contained * 1,
          maxScale: PhotoViewComputedScale.covered * 3,
          backgroundDecoration: BoxDecoration(color: Colors.grey[200]),
          child: Container(
            child: isNetworkUrl
                ? LoadNetworkImage(
                    errorAssetsType: isChat?ErrorAssetsType.chatImage:ErrorAssetsType.vehicle,
                    src: imagePath,
                    fit: BoxFit.contain,
                  )
                : Image.file(
                    File(imagePath!),
                  ),
          ),
        ),
      ),
    );
  }
}
