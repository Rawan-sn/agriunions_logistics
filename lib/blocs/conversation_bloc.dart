import 'package:flutter/cupertino.dart';
import 'package:agriunions_logistics/models/chat_item_model.dart';
import 'package:agriunions_logistics/providers/api_chat.dart';
import 'package:rxdart/rxdart.dart';

class ConversationBloc {
  final _conversationController = PublishSubject<List<ChatItemModel>?>();
  get conversationStream => _conversationController.stream;

  final _isLoadingController = PublishSubject<bool>();
  get isLoadingStream => _isLoadingController.stream;

  clearConversation() {
    _conversationController.sink.add(null);
  }

  getConversation(
      BuildContext context, String? withUserId, String? withRoomId) {
    _isLoadingController.sink.add(true);
    ApiChat(context)
        .getConversationDetails(withUserId, withRoomId)
        .then((webSer) {
      if (webSer != null) {
        if (!_conversationController.isClosed) {
          _conversationController.sink.add(List<ChatItemModel>.from(
              webSer.data.map((x) => ChatItemModel.fromMap(x))));
        }
      }
      if (!_isLoadingController.isClosed) {
        _isLoadingController.sink.add(false);
      }
    });
  }

  void dispose() {
    _conversationController.close();
    _isLoadingController.close();
  }
}
