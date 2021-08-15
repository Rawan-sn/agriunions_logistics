import 'package:flutter/cupertino.dart';
import 'package:agriunions_logistics/helper/enums.dart';
import 'package:agriunions_logistics/models/web_service_response_model.dart';
import 'base_provider/api_constants.dart';
import 'base_provider/api_provider.dart';

class ApiVehicle extends ApiProvider {
  ApiVehicle(BuildContext context) : super(context);

  Future<WebServiceResponse?> createVehicle(var body) async {
    dynamic response = await fetchRequest(
        uri: getUri(
          ApiConstants.createVehicle,
        ),
        body: body,
        type: RequestType.post);
    return response;
  }
  Future<WebServiceResponse?> updateVehicle(var body,String id) async {
    dynamic response = await fetchRequest(
        uri: getUri(
          ApiConstants.updateVehicle+id,
        ),
        body: body,
        type: RequestType.put);
    return response;
  }
  Future<WebServiceResponse?> getVehicles() async {
    dynamic response = await fetchRequest(uri: getUri(ApiConstants.vehicles));
    return response;
  }

  Future<WebServiceResponse?> getVehiclesClassifications() async {
    dynamic response =
        await fetchRequest(uri: getUri(ApiConstants.vehicleClassifications));
    return response;
  }
}
