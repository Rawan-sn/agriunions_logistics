import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:agriunions_logistics/Localization/AppLocal.dart';
import 'package:agriunions_logistics/blocs/conversations_list_bloc.dart';
import 'package:agriunions_logistics/models/conversation_item_model.dart';
import 'package:agriunions_logistics/user_interfaces/cards/trip_conversations_list_card.dart';
import 'package:agriunions_logistics/user_interfaces/pages/trip_conversation.dart';
import 'package:agriunions_logistics/user_interfaces/widget/general_widget.dart';

class TripConversationsListPage extends StatefulWidget {
  TripConversationsListPage({
    required this.withUserId,
    required this.withRoomId,
  });

  final String? withUserId;
  final String? withRoomId;

  @override
  _TripConversationsListPageState createState() =>
      _TripConversationsListPageState();
}

class _TripConversationsListPageState extends State<TripConversationsListPage> {
  ConversationsListBloc _bloc = ConversationsListBloc();

  @override
  void initState() {
    super.initState();
    _bloc.getConversationsList(context, widget.withRoomId);
  }

  @override
  void dispose() {
    _bloc.dispose();
    super.dispose();
  }

  Future<Null> _refresh() async {
    _bloc.clearConversationsList();
    _bloc.getConversationsList(context, widget.withRoomId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: _refresh,
        child: Column(
          children: [
            Expanded(
              child: StreamBuilder<List<ConversationItemModel>?>(
                stream: _bloc.conversationsStream,
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
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              primary: false,
                              itemCount: snapshot.data!.length,
                              itemBuilder: (BuildContext context, int index) {
                                return InkWell(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            TripConversationPage(
                                          viewAsFullScreen: true,
                                          withUserId:
                                              snapshot.data![index].withUserId,
                                          withRoomId:
                                              snapshot.data![index].withRoomId,
                                          receiver:
                                              snapshot.data![index].withUserName,
                                        ),
                                      ),
                                    );
                                  },
                                  child: TripConversationListCard(
                                      model: snapshot.data![index]),
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
          ],
        ),
      ),
    );
  }
}
