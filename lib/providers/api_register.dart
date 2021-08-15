import 'package:flutter/material.dart';
import 'package:agriunions_logistics/models/web_service_response_model.dart';
import 'package:agriunions_logistics/providers/base_provider/api_constants.dart';
import 'package:agriunions_logistics/providers/base_provider/api_provider.dart';
import 'package:agriunions_logistics/helper/enums.dart';

class ApiRegister extends ApiProvider {
  ApiRegister(BuildContext context) : super(context);

  Future<WebServiceResponse?> register(String? userName, String? password,
      String? confirm, String? phoneNumber, String? email) async {
    Map body = {
      "username": userName,
      "password": password,
      "password_confirmation": confirm,
      "mobile": phoneNumber,
      "email": email,
    };
    dynamic response = await fetchRequest(
        uri: getUri(ApiConstants.register), body: body, type: RequestType.post);
    return response;
  }
}
