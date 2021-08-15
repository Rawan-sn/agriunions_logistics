import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:agriunions_logistics/Localization/AppLocal.dart';
import 'package:agriunions_logistics/blocs/conversation_bloc.dart';
import 'package:agriunions_logistics/helper/AppColors.dart';
import 'package:agriunions_logistics/helper/TextSizes.dart';
import 'package:agriunions_logistics/models/chat_item_model.dart';
import 'package:agriunions_logistics/providers/api_chat.dart';
import 'package:agriunions_logistics/user_interfaces/cards/trip_conversation_card.dart';
import 'package:agriunions_logistics/user_interfaces/pages/general/add_media_page.dart';
import 'package:agriunions_logistics/user_interfaces/widget/general_widget.dart';
import 'package:agriunions_logistics/user_interfaces/widget/progress_dialog.dart';

class TripConversationPage extends StatefulWidget {
  TripConversationPage({
    this.viewAsFullScreen = false,
    required this.withUserId,
    required this.withRoomId,
    this.receiver,
  });

  final bool viewAsFullScreen;
  final String? withUserId;
  final String? withRoomId;
  final String? receiver;

  @override
  _TripConversationPageState createState() => _TripConversationPageState();
}

class _TripConversationPageState extends State<TripConversationPage> {
  ConversationBloc _bloc = ConversationBloc();
  AddMediaPage addMediaPage = AddMediaPage();
  TextEditingController? commentController;
  bool addMedia = false;

  @override
  void initState() {
    super.initState();
    commentController = TextEditingController();
    _bloc.getConversation(context, widget.withUserId, widget.withRoomId);
  }

  @override
  void dispose() {
    _bloc.dispose();
    commentController!.dispose();
    super.dispose();
  }

  Future<Null> _refresh() async {
    _bloc.clearConversation();
    _bloc.getConversation(context, widget.withUserId, widget.withRoomId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: widget.viewAsFullScreen
          ? AppBar(
              backgroundColor: Colors.amber,
              title: Text(
                widget.receiver ?? "",
                style: TextStyle(fontSize: TextSizes.text),
              ),
            )
          : null,
      body: RefreshIndicator(
        onRefresh: _refresh,
        child: Stack(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                      'assets/images/chatB.jpg'),
                  colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.2), BlendMode.dstATop),
                  fit:BoxFit.cover
                ),
              ),
            ),
            Column(
              children: [
                Expanded(
                  child: StreamBuilder<List<ChatItemModel>?>(
                    stream: _bloc.conversationStream,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        if (snapshot.data!.length != 0) {
                          return SingleChildScrollView(
                            child: Column(
                              children: [
                                SizedBox(
                                  height: MediaQuery.of(context).size.height / 23,
                                ),
                                ListView.builder(
                                  padding: EdgeInsets.zero,
                                  shrinkWrap: true,
                                  primary: false,
                                  itemCount: snapshot.data!.length,
                                  itemBuilder: (BuildContext context, int index) {
                                    return Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: TripConversationCard(
                                          model: snapshot.data![index],
                                          withUserId: widget.withUserId),
                                    );
                                  },
                                ),
                              ],
                            ),
                          );
                        } else {
                          return Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Container(
                                  height: 80,
                                  width: 80,
                                  child: Image(
                                      image: AssetImage(
                                          "assets/images/oops_data.png")),
                                ),
                                SizedBox(height: 20),
                                Text(AppLocalizations.of(context)!
                                    .trans('no_data_found')!),
                              ],
                            ),
                          );
                        }
                      }
                      return Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: GeneralWidget.listProgressIndicator(),
                      );
                    },
                  ),
                ),
                Column(
                  children: <Widget>[
                    ConstrainedBox(
                      constraints: BoxConstraints(
                          maxHeight: MediaQuery.of(context).size.height / 4),
                      child: Container(
                        color: Colors.white,
                        width: double.infinity,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                          child: Row(
                            children: <Widget>[
                              SizedBox(width: 5),
                              Expanded(
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.grey[200],
                                    borderRadius: BorderRadius.circular(10.0),
                                    boxShadow: [
                                      BoxShadow(
                                          offset: Offset(0, 1),
                                          blurRadius: 2,
                                          color: Colors.amberAccent)
                                    ],
                                  ),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: TextField(
                                          onChanged: (text) {},
                                          controller: commentController,
                                          decoration: InputDecoration(
                                              border: InputBorder.none,
                                              floatingLabelBehavior:
                                                  FloatingLabelBehavior.never,
                                              hintText:
                                                  AppLocalizations.of(context)!
                                                      .trans("add_message"),
                                              contentPadding:
                                                  EdgeInsetsDirectional.only(
                                                      start: 10)),
                                          autofocus: false,
                                          maxLines: null,
                                        ),
                                      ),
                                      IconButton(
                                        icon: Icon(Icons.attach_file_sharp),
                                        onPressed: () {
                                          setState(() {
                                            addMedia = !addMedia;
                                            addMediaPage = new AddMediaPage();
                                          });
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(width: 5),
                              InkWell(
                                onTap: () {
                                  FocusScope.of(context).unfocus();
                                  ProgressDialog progressDialog =
                                      GeneralWidget.progressDialog(context);
                                  if (commentController!.text.isNotEmpty ||
                                      addMediaPage.addMediaState.mB.attachments
                                          .isNotEmpty) {
                                    progressDialog.show().then((value) {
                                      ApiChat(context).sendChatMessage({
                                        "to_user_id": widget.withUserId,
                                        "to_room_id": widget.withRoomId,
                                        "message": commentController!.text,
                                        "attachments": addMediaPage
                                            .addMediaState.mB.attachments
                                            .map((x) => x.toMap())
                                            .toList(),
                                      }).then((value) {
                                        progressDialog.hide();
                                        if (value != null) {
                                          setState(() {
                                            commentController!.text = "";
                                            addMedia = false;
                                          });
                                          _refresh();
                                        }
                                      });
                                    });
                                  } else {
                                    Fluttertoast.showToast(
                                      msg: AppLocalizations.of(context)!
                                          .trans("noti_add_image_is_required")!,
                                    );
                                  }
                                },
                                child: Container(
                                  padding: EdgeInsets.all(11),
                                  decoration: BoxDecoration(
                                    color: Colors.grey[200],
                                    borderRadius: BorderRadius.circular(10.0),
                                    boxShadow: [
                                      BoxShadow(
                                          offset: Offset(0, 2),
                                          blurRadius: 1,
                                          color: Colors.amberAccent.shade100)
                                    ],
                                  ),
                                  child: Icon(
                                    Icons.send,
                                    color: Colors.amber,
                                    size: 25,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    Visibility(
                      visible: addMedia,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30),
                        child: Container(
                          height: MediaQuery.of(context).size.height / 7,
                          child: addMediaPage,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
