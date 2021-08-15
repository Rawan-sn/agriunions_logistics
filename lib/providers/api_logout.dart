import 'package:flutter/material.dart';
import 'package:agriunions_logistics/models/web_service_response_model.dart';
import 'package:agriunions_logistics/providers/base_provider/api_constants.dart';
import 'package:agriunions_logistics/providers/base_provider/api_provider.dart';
import 'package:agriunions_logistics/helper/data_store.dart';

class ApiLogout extends ApiProvider {
  ApiLogout(BuildContext context) : super(context);
  Future<WebServiceResponse?> logout() async {
    var queryParameters = {
      "username": "${dataStore.authUser?.user?.name}",
    };
    dynamic response = await fetchRequest(uri: getUri(ApiConstants.logout,queryParameters));
    return response;
  }
}
