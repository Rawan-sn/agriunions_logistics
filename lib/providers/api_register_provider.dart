import 'package:flutter/material.dart';
import 'package:agriunions_logistics/models/web_service_response_model.dart';
import 'package:agriunions_logistics/providers/base_provider/api_constants.dart';
import 'package:agriunions_logistics/providers/base_provider/api_provider.dart';
import 'package:agriunions_logistics/helper/enums.dart';

class ApiRegisterProvider extends ApiProvider {
  ApiRegisterProvider(BuildContext context) : super(context);

  Future<WebServiceResponse?> register(var body) async {
    print(body);
    dynamic response = await fetchRequest(
        uri: getUri(ApiConstants.registerProvider),
        body: body,
        type: RequestType.post);
    return response;
  }

  Future<WebServiceResponse?> retrieveServiceProviderRequests() async {
    dynamic response =
        await fetchRequest(uri: getUri(ApiConstants.retrieveProviderRequests));
    return response;
  }
}
