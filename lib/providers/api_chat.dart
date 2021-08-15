import 'package:flutter/cupertino.dart';
import 'package:agriunions_logistics/helper/enums.dart';
import 'package:agriunions_logistics/models/web_service_response_model.dart';
import 'base_provider/api_constants.dart';
import 'base_provider/api_provider.dart';

class ApiChat extends ApiProvider {
  ApiChat(BuildContext context) : super(context);

  Future<WebServiceResponse?> sendChatMessage(var body) async {
    dynamic response = await fetchRequest(
        uri: getUri(
          ApiConstants.sendChatMessage,
        ),
        body: body,
        type: RequestType.post);
    return response;
  }

  Future<WebServiceResponse?> getConversationDetails(
      String? withUserId, String? withRoomId) async {
    var queryParameters = {
      "with_user_id": "$withUserId",
      "with_room_id": "$withRoomId",
    };
    dynamic response = await fetchRequest(
      uri: getUri(ApiConstants.getConversationDetails, queryParameters),
    );
    return response;
  }

  Future<WebServiceResponse?> getListOfConversations(String? withRoomId) async {
    var queryParameters = {
      "with_room_id": "$withRoomId",
    };
    dynamic response = await fetchRequest(
      uri: getUri(ApiConstants.getListOfConversations, queryParameters),
    );
    return response;
  }
}
