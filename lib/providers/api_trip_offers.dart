import 'package:flutter/cupertino.dart';
import 'package:agriunions_logistics/helper/app_constants.dart';
import 'package:agriunions_logistics/helper/enums.dart';
import 'package:agriunions_logistics/models/create_models/search_filter_model.dart';
import 'package:agriunions_logistics/models/web_service_response_model.dart';
import 'base_provider/api_constants.dart';
import 'base_provider/api_provider.dart';

class ApiTripOffers extends ApiProvider {
  ApiTripOffers(BuildContext context) : super(context);

  Future<WebServiceResponse?> getSchedulesTripOffers(
      int page, SearchFilterModel? filterModel) async {
    var queryParameters = {
      "per_page": "15",
      "page": "$page",
    };
    if (filterModel != null)
      queryParameters.addAll(filterModel.toParameterMap());
    print(queryParameters.toString());
    dynamic response = await fetchRequest(
      uri: getUri(ApiConstants.schedulesTripOffers, queryParameters),
    );
    return response;
  }

  Future<WebServiceResponse?> getMyTripOffers(
      int page, SearchFilterModel? filterModel) async {
    var queryParameters = {
      "per_page": "15",
      "page": "$page",
    };
    if (filterModel != null)
      queryParameters.addAll(filterModel.toParameterMap());
    print(queryParameters.toString());
    dynamic response = await fetchRequest(
      uri: getUri(ApiConstants.myTripOffers, queryParameters),
    );
    return response;
  }

  Future<WebServiceResponse?> createTripOffer(var body) async {
    dynamic response = await fetchRequest(
      uri: getUri(ApiConstants.createTripOffers),
      body: body,
      type: RequestType.post,
    );
    return response;
  }

  Future<WebServiceResponse?> editTripOffer(var body, String tripId) async {
    dynamic response = await fetchRequest(
      uri: getUri(ApiConstants.editTripOffers + tripId),
      body: body,
      type: RequestType.post,
    );
    return response;
  }

  Future<WebServiceResponse?> getTripOfferDetails(String tripId) async {
    dynamic response = await fetchRequest(
      uri: getUri(ApiConstants.tripOfferDetails + tripId),
    );
    return response;
  }

  Future<WebServiceResponse?> getTripOffersRequests(
      int page, SearchFilterModel? filterModel) async {
    var queryParameters = {
      "per_page": "15",
      "page": "$page",
    };
    if (filterModel != null)
      queryParameters.addAll(filterModel.toParameterMap());
    dynamic response = await fetchRequest(
      uri: getUri(ApiConstants.tripOfferRequests, queryParameters),
    );
    return response;
  }

  Future<WebServiceResponse?> createTripOffersRequest(var body) async {
    dynamic response = await fetchRequest(
        uri: getUri(ApiConstants.createTripOfferRequest),
        body: body,
        type: RequestType.post);
    return response;
  }

  Future<WebServiceResponse?> setStatusTripOffersRequest(
    String? tripOfferRequestId,
    bool isAccept,
  ) async {
    var body = {"Trip_Offer_Request_Id": tripOfferRequestId};
    if (isAccept) {
      body['Status'] = 'Received';
    } else {
      body['Status'] = 'Rejected';
    }
    print(body);
    dynamic response = await fetchRequest(
        uri: getUri(ApiConstants.tripOfferRequestsSetStatus),
        body: body,
        type: RequestType.post);
    return response;
  }

  Future<WebServiceResponse?> startTripProcess(
    String tripOfferRequestId,
    DateTime date,
  ) async {
    var queryParameters = {"date": AppConstants.dateFormat1.format(date)};
    dynamic response = await fetchRequest(
      uri: getUri(
        ApiConstants.startTripProcess + tripOfferRequestId,
        queryParameters,
      ),
    );
    return response;
  }

  Future<WebServiceResponse?> updateTripOffersStatus(
      String status, String tripId) async {
    var queryParameters = {
      "Status": status,
    };
    dynamic response = await fetchRequest(
        uri: getUri(
            ApiConstants.updateTripOfferStatus + tripId, queryParameters),
        type: RequestType.post);
    return response;
  }
}
