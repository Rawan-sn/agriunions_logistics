import 'package:flutter/cupertino.dart';
import 'package:agriunions_logistics/helper/enums.dart';
import 'package:agriunions_logistics/models/web_service_response_model.dart';
import 'base_provider/api_constants.dart';
import 'base_provider/api_provider.dart';

class ApiBranch extends ApiProvider {
  ApiBranch(BuildContext context) : super(context);

  Future<WebServiceResponse?> createBranch(var body) async {
    dynamic response = await fetchRequest(
        uri: getUri(
          ApiConstants.createBranch,
        ),
        body: body,
        type: RequestType.post);
    return response;
  }
  Future<WebServiceResponse?> updateBranch(var body,String branchId) async {
    dynamic response = await fetchRequest(
        uri: getUri(
          ApiConstants.updateBranch+branchId,
        ),
        body: body,
        type: RequestType.put);
    print(body);
    return response;
  }
  Future<WebServiceResponse?> getBranches() async {
    dynamic response = await fetchRequest(uri: getUri(ApiConstants.branches));
    return response;
  }
}
