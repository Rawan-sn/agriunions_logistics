import 'package:flutter/cupertino.dart';
import 'package:agriunions_logistics/models/conversation_item_model.dart';
import 'package:agriunions_logistics/providers/api_chat.dart';
import 'package:rxdart/rxdart.dart';

class ConversationsListBloc {
  final _conversationsController =
      PublishSubject<List<ConversationItemModel>?>();
  get conversationsStream => _conversationsController.stream;

  final _isLoadingController = PublishSubject<bool>();
  get isLoadingStream => _isLoadingController.stream;

  clearConversationsList() {
    _conversationsController.sink.add(null);
  }

  getConversationsList(BuildContext context, String? withRoomId) {
    _isLoadingController.sink.add(true);
    ApiChat(context).getListOfConversations(withRoomId).then((webSer) {
      if (webSer != null) {
        if (!_conversationsController.isClosed) {
          _conversationsController.sink.add(List<ConversationItemModel>.from(
              webSer.data.map((x) => ConversationItemModel.fromMap(x))));
        }
      }
      if (!_isLoadingController.isClosed) {
        _isLoadingController.sink.add(false);
      }
    });
  }

  void dispose() {
    _conversationsController.close();
    _isLoadingController.close();
  }
}
