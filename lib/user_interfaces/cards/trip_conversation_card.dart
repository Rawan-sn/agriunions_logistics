import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:agriunions_logistics/helper/AppColors.dart';
import 'package:agriunions_logistics/helper/data_store.dart';
import 'package:agriunions_logistics/helper/enums.dart';
import 'package:agriunions_logistics/models/chat_item_model.dart';
import 'package:agriunions_logistics/user_interfaces/pages/general/image_view.dart';
import 'package:agriunions_logistics/user_interfaces/widget/load_network_image.dart';

class TripConversationCard extends StatefulWidget {
  final ChatItemModel model;
  final withUserId;

  TripConversationCard({required this.model, this.withUserId});

  @override
  _TripConversationCardState createState() => _TripConversationCardState();
}

class _TripConversationCardState extends State<TripConversationCard> {
  bool meIsSender = false;

  @override
  void initState() {
    super.initState();
    if (widget.withUserId == widget.model.toUserId) {
      meIsSender = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Column(
        crossAxisAlignment:
            meIsSender ? CrossAxisAlignment.start : CrossAxisAlignment.end,
        children: [
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: AppColors.lightGray),
              borderRadius: meIsSender
                  ?  dataStore.lang=='ar'?BorderRadius.only(
                      bottomLeft: Radius.circular(20),
                      topLeft: Radius.circular(20)):BorderRadius.only(
                  bottomRight: Radius.circular(20),
                  topRight: Radius.circular(20))
                  : dataStore.lang=='ar'?BorderRadius.only(
                      bottomRight: Radius.circular(20),
                      topRight: Radius.circular(20)):
              BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  topLeft: Radius.circular(20))
                ,
              boxShadow: kElevationToShadow[4],
              color: meIsSender ? Colors.red.shade50 : Colors.white,
                gradient: meIsSender?LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                  colors: [
                    Colors.amber.shade100,
                    Colors.white70,
                  ],
                ):

                LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                  colors: [
                    Colors.grey,
                    Colors.white70,
                  ],
                )

            ),
            child: Padding(
              padding: const EdgeInsets.only(
                  top: 10, left: 10, right: 10, bottom: 10),
              child: Column(
                crossAxisAlignment: meIsSender
                    ? CrossAxisAlignment.start
                    : CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Visibility(
                    visible: widget.model.message!.isNotEmpty,
                    child: Text(
                      widget.model.message!,
                    ),
                  ),
                  Visibility(
                    visible: widget.model.attachments!.isNotEmpty && widget.model.message!.isNotEmpty,
                    child: Container(
                        width: 100,
                        child: Divider()),
                  ),
                  Visibility(
                    visible: widget.model.attachments!.isNotEmpty,
                    child: CustomScrollView(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      slivers: <Widget>[
                        SliverGrid(
                          delegate: SliverChildBuilderDelegate(
                            (context, index) {
                              return AspectRatio(

                                aspectRatio: 1,
                                child: InkWell(
                                  onTap: () {
                                    print(widget.model.attachments!.length);
                                    Navigator.push(
                                      context,
                                      CupertinoPageRoute(
                                        fullscreenDialog: true,
                                        builder: (context) => ImageView(
                                          isChat:true,
                                          imagePath: widget.model.attachments![index],
                                          isNetworkUrl: true,
                                        ),
                                      ),
                                    );
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(6.0),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        border:
                                            Border.all(color: AppColors.Russet),
                                        borderRadius: BorderRadius.circular(20),
                                        boxShadow: kElevationToShadow[4],
                                      ),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(20),
                                        child: LoadNetworkImage(
                                          errorAssetsType: ErrorAssetsType.chatImage,
                                          src: widget.model.attachments![index],
                                          fit: BoxFit.cover,
                                          // width: double.infinity,
                                          height: double.infinity,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                            childCount: widget.model.attachments!.length,
                          ),
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  childAspectRatio: 1,
                                  crossAxisCount: 4,
                                  crossAxisSpacing: 2,
                                  mainAxisSpacing: 2),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
