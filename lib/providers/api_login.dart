import 'package:flutter/material.dart';
import 'package:agriunions_logistics/models/web_service_response_model.dart';
import 'package:agriunions_logistics/providers/base_provider/api_constants.dart';
import 'package:agriunions_logistics/providers/base_provider/api_provider.dart';

class ApiLogin extends ApiProvider {
  ApiLogin(BuildContext context) : super(context);

  Future<WebServiceResponse?> login(String? userName, String? password) async {
    var queryParameters = {
      "username": "$userName",
      "password": "$password",
    };
    dynamic response =
        await fetchRequest(uri: getUri(ApiConstants.login, queryParameters));
    return response;
  }
}
