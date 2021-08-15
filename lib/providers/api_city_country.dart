import 'package:flutter/cupertino.dart';
import 'package:agriunions_logistics/models/web_service_response_model.dart';
import 'base_provider/api_constants.dart';
import 'base_provider/api_provider.dart';

class ApiCityCountry extends ApiProvider {
  ApiCityCountry(BuildContext context) : super(context);

  Future<WebServiceResponse?> getCities(String? countryId) async {
    var queryParameters = {"country_id": "$countryId"};
    dynamic response = await fetchRequest(
      uri: getUri(ApiConstants.cities, queryParameters),
    );
    return response;
  }

  Future<WebServiceResponse?> getCountries() async {
    dynamic response = await fetchRequest(uri: getUri(ApiConstants.countries));
    return response;
  }
}
