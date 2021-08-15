import 'package:flutter/material.dart';
import 'package:agriunions_logistics/helper/enums.dart';
import 'package:agriunions_logistics/models/web_service_response_model.dart';
import 'package:agriunions_logistics/providers/base_provider/api_constants.dart';
import 'package:agriunions_logistics/providers/base_provider/api_provider.dart';

class ApiUsers extends ApiProvider {
  ApiUsers(BuildContext context) : super(context);
  Future<WebServiceResponse?> findUser(String keyword, UserTypes? type) async {
    var queryParameters = {
      "keyword": "$keyword",
      "user_type": "${type?.toString().split('.').last ?? UserTypes.all.toString().split('.').last}"
    };
    dynamic response =
        await fetchRequest(uri: getUri(ApiConstants.find, queryParameters));
    return response;
  }

  Future<WebServiceResponse?> getSubUserList(int page) async {
    var queryParameters = {
      "per_page": "15",
      "page": "$page",
    };
    dynamic response = await fetchRequest(
        uri: getUri(ApiConstants.subUserList, queryParameters));
    return response;
  }

  Future<WebServiceResponse?> getLinkRequestsList(int page) async {
    var queryParameters = {
      "per_page": "15",
      "page": "$page",
    };
    dynamic response = await fetchRequest(
        uri: getUri(ApiConstants.linkRequests, queryParameters));
    return response;
  }

  Future<WebServiceResponse?> sendLinkRequest(String? userId) async {
    dynamic response = await fetchRequest(
        uri: getUri(ApiConstants.sendLinkRequest + "/$userId"),
        body: {},
        type: RequestType.post);
    return response;
  }

  Future<WebServiceResponse?> unlinkUser({String? userId}) async {
    String url;
    if (userId == null) {
      url = ApiConstants.unlinkUser;
    } else {
      url = ApiConstants.unlinkUser + "/$userId";
    }
    dynamic response =
        await fetchRequest(uri: getUri(url), body: {}, type: RequestType.post);
    return response;
  }

  Future<WebServiceResponse?> processLinkRequest(
      String? userId, String status) async {
    var body = {"status": status};
    dynamic response = await fetchRequest(
        uri: getUri(ApiConstants.processLinkRequest + "/$userId"),
        body: body,
        type: RequestType.post);
    return response;
  }
}
