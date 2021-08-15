import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:agriunions_logistics/Localization/AppLocal.dart';
import 'package:agriunions_logistics/blocs/media_bloc.dart';
import 'package:agriunions_logistics/models/attachment_model.dart';
import 'package:agriunions_logistics/user_interfaces/pages/general/image_view.dart';
import 'package:agriunions_logistics/user_interfaces/widget/load_network_image.dart';

class AddMediaPage extends StatefulWidget {
  final _AddMediaPageState addMediaState = _AddMediaPageState();
  final List<String>? attachments;
  final int? maxMediaCount;

  AddMediaPage({this.attachments, this.maxMediaCount});

  @override
  _AddMediaPageState createState() => addMediaState;

  bool isValidInput(BuildContext context) {
    if (addMediaState.mB.attachments.isEmpty) {
      Fluttertoast.showToast(
        msg: AppLocalizations.of(context)!.trans("noti_add_image_is_required")!,
      );
      return false;
    } else {
      return true;
    }
  }
}

class _AddMediaPageState extends State<AddMediaPage> {
  final mB = MediaBloc();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 20, right: 20, top: 10),
      child: StreamBuilder<List<Attachment>?>(
        stream: mB.mediaListStream,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return CustomScrollView(
              slivers: <Widget>[
                SliverGrid(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      if (index == snapshot.data!.length) {
                        return addMediaCard();
                      }
                      return imageCard(snapshot.data![index], () {
                        mB.deleteItem(index);
                      });
                    },
                    childCount: snapshot.data!.length + 1,
                  ),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      childAspectRatio: 1,
                      crossAxisCount: 3,
                      crossAxisSpacing: 2,
                      mainAxisSpacing: 2),
                ),
              ],
            );
          } else {
            if (widget.attachments != null) {
              mB.addImagesForEditing(widget.attachments!);
            }
            return CustomScrollView(
              slivers: <Widget>[
                SliverGrid(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      return addMediaCard();
                    },
                    childCount: 1,
                  ),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      childAspectRatio: 1,
                      crossAxisCount: 3,
                      crossAxisSpacing: 2,
                      mainAxisSpacing: 2),
                ),
              ],
            );
          }
        },
      ),
    );
  }

  imageCard(Attachment mediaData, final onDelete) {
    return AspectRatio(
      aspectRatio: 1,
      child: Stack(
        children: <Widget>[
          InkWell(
            onTap: () {
              Navigator.push(
                context,
                CupertinoPageRoute(
                  fullscreenDialog: true,
                  builder: (context) => ImageView(
                    imagePath: mediaData.path,
                    isNetworkUrl: mediaData.imageFileName == null,
                  ),
                ),
              );
            },
            child: Padding(
              padding: const EdgeInsets.all(6.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  boxShadow: kElevationToShadow[2],
                  borderRadius: BorderRadius.circular(30),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Visibility(
                    visible: mediaData.imageFileName == null,
                    child: LoadNetworkImage(src: mediaData.path),
                    replacement: Image.file(
                      File(mediaData.path!),
                      fit: BoxFit.cover,
                      width: double.infinity,
                      height: double.infinity,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Align(
            alignment: AlignmentDirectional.topEnd,
            child: InkWell(
              onTap: onDelete,
              child: Container(
                margin: EdgeInsets.all(15),
                padding: EdgeInsets.all(1),
                child: Icon(
                  Icons.close,
                  color: Colors.white,
                  size: 25,
                ),
                decoration: BoxDecoration(
                  color: Colors.black.withAlpha(100),
                  shape: BoxShape.circle,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  addMediaCard() {
    return AspectRatio(
      aspectRatio: 1,
      child: InkWell(
        onTap: () {
          if (widget.maxMediaCount == null ||
              (widget.maxMediaCount! > mB.attachments.length)) {
            showModalBottomSheet(
              context: (context),
              builder: (context1) {
                return SingleChildScrollView(
                    child: Column(
                  children: <Widget>[
                    InkWell(
                        onTap: () {
                          Navigator.pop(context1);
                          mB.chosseImageExplorer(this.context);
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
          } else {
            Fluttertoast.showToast(
              msg:
                  "${AppLocalizations.of(context)!.trans("you_cant_add_more_than")} ${widget.maxMediaCount}",
            );
          }
        },
        child: Padding(
          padding: EdgeInsets.all(6),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.grey.shade200,
              boxShadow: kElevationToShadow[2],
              borderRadius: BorderRadius.circular(20),
            ),
            child: Icon(Icons.add_a_photo),
          ),
        ),
        // child: Card(
        //   elevation: 3,
        //   color: Colors.grey.shade200,
        //   child: Column(
        //     mainAxisAlignment: MainAxisAlignment.center,
        //     children: <Widget>[
        //       Icon(
        //         Icons.add_to_photos,
        //         size: 30,
        //         color: AppColors.darkRed,
        //       ),
        //       SizedBox(
        //         height: 10,
        //       ),
        //       Text(
        //         AppLocalizations.of(context).trans("upload_photos"),
        //         style: TextStyle(color: AppColors.darkRed, fontSize: 12),
        //       )
        //     ],
        //   ),
        // ),
      ),
    );
  }

  @override
  void dispose() {
    mB.dispose();
    super.dispose();
  }
}
