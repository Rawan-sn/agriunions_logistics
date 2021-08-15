import 'package:flutter/cupertino.dart';
import 'package:agriunions_logistics/models/web_service_response_model.dart';
import 'base_provider/api_constants.dart';
import 'base_provider/api_provider.dart';

class ApiGeneralData extends ApiProvider {
  ApiGeneralData(BuildContext context) : super(context);

  Future<WebServiceResponse?> getInitialData() async {
    dynamic response = await fetchRequest(
      uri: getUri(ApiConstants.initialData),
    );
    return response;
  }

  Future<WebServiceResponse?> getProfile() async {
    dynamic response = await fetchRequest(uri: getUri(ApiConstants.profile));
    return response;
  }

  Future<WebServiceResponse?> updateLocation(
      double latitude, double longitude) async {
    var queryParameters = {
      "latitude": "$latitude",
      "longitude": "$longitude",
    };
    dynamic response = await fetchRequest(
        uri: getUri(ApiConstants.updateLocation, queryParameters));
    return response;
  }

  Future<WebServiceResponse?> setOnline(int? value) async {
    var queryParameters = {
      "Status": "${value == 0 ? 'Offline' : 'Online'}",
    };
    print(queryParameters);
    dynamic response = await fetchRequest(
        uri: getUri(ApiConstants.setOnline, queryParameters));
    return response;
  }
}
