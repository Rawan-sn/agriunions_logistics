import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:agriunions_logistics/Localization/AppLocal.dart';
import 'package:agriunions_logistics/blocs/media_profile_bloc.dart';
import 'package:agriunions_logistics/helper/AppColors.dart';
import 'package:agriunions_logistics/models/attachment_model.dart';
import 'package:agriunions_logistics/user_interfaces/pages/general/image_view.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AddMediaProfilePage extends StatefulWidget {
  final _AddMediaProfilePageState addMediaState = _AddMediaProfilePageState();

  @override
  _AddMediaProfilePageState createState() => addMediaState;
}

class _AddMediaProfilePageState extends State<AddMediaProfilePage> {
  final mB = MediaProfileBloc();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Attachment?>(
      stream: mB.mediaListStream,
      builder: (context, snapshot) {
        if (!snapshot.hasData ||
            (snapshot.hasData && (snapshot.data!.path == null)))
          return addMediaCard();
        else
          return addMediaCard(mediaData: snapshot.data);
      },
    );
  }

  addMediaCard({Attachment? mediaData}) {
    return new Stack(children: <Widget>[
      InkWell(
        onTap: () {
          if (mediaData != null) {
            Navigator.push(
              context,
              CupertinoPageRoute(
                fullscreenDialog: true,
                builder: (context) => ImageView(imagePath: mediaData.path),
              ),
            );
          } else {
            Fluttertoast.showToast(
              msg: AppLocalizations.of(context)!.trans("choose_image_first")!,
            );
          }
        },
        child: Center(
          child: new Container(
            width: 120.0,
            height: 120.0,
            decoration: new BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: AppColors.Russet.withOpacity(0.5),
                  spreadRadius: 8,
                  blurRadius: 7,
                  offset: Offset(0, 1),
                ),
              ],
              shape: BoxShape.circle,
            ),
            child: mediaData != null
                ? ClipRRect(
                    borderRadius: BorderRadius.circular(80),
                    child: Image.file(
                      File(mediaData.path!),
                      fit: BoxFit.cover,
                      width: double.infinity,
                      height: double.infinity,
                    ),
                  )
                : Image.asset('assets/images/profile.png'),
          ),
        ),
      ),
      Positioned(
        bottom: 13,
        left: MediaQuery.of(context).size.width / 1.7,
        child: InkWell(
          onTap: () {
            showModalBottomSheet(
              context: (context),
              builder: (context1) {
                return SingleChildScrollView(
                    child: Column(
                  children: <Widget>[
                    InkWell(
                        onTap: () {
                          Navigator.pop(context1);
                          mB.chooseImageExplorer(this.context);
                        },
                        child: ListTile(
                          leading: Icon(Icons.perm_media),
                          title: Text(
                              AppLocalizations.of(context1)!.trans("gallery")!),
                        )),
                    InkWell(
                      onTap: () {
                        Navigator.pop(context1);
                        mB.getImageFromCamera();
                      },
                      child: ListTile(
                        leading: Icon(Icons.camera),
                        title: Text(AppLocalizations.of(context1)!
                            .trans("image_from_camera")!),
                      ),
                    ),
                  ],
                ));
              },
            );
          },
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(20)),
              boxShadow: [
                BoxShadow(
                  color: AppColors.Russet.withOpacity(0.5),
                  spreadRadius: 1,
                  blurRadius: 7,
                  offset: Offset(0, 1),
                ),
              ],
            ),
            child: new CircleAvatar(
              backgroundColor: Colors.grey.shade300,
              radius: 20.0,
              child: new Icon(
                Icons.camera_alt,
                size: 18,
                color: Colors.black54,
              ),
            ),
          ),
        ),
      ),
    ]);
  }

  @override
  void dispose() {
    mB.dispose();
    super.dispose();
  }
}
