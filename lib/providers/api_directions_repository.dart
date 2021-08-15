import 'package:flutter/material.dart';
import 'package:agriunions_logistics/helper/app_constants.dart';
import 'package:agriunions_logistics/providers/base_provider/api_provider.dart';
import 'package:agriunions_logistics/models/dicections_model.dart';
import 'package:place_picker/place_picker.dart';
import 'package:http/http.dart' as http;

class ApiDirectionsRepository extends ApiProvider {
  ApiDirectionsRepository(BuildContext context) : super(context);
  static const String baseUrl =
      'maps.googleapis.com';
  static const String target =
      'maps/api/directions/json';

  Future<DirectionsModel?> getDirections({
    required LatLng origin,
    required LatLng destination,
  }) async {
    var queryParameters = {
      "origin": "${origin.latitude},${origin.longitude}",
      "destination": "${destination.latitude},${destination.longitude}",
      "key": AppConstants.googleMapKey,
    };
    // print("SSS: ${getUri(baseUrl, queryParameters)}");
    // final response = await http.get(getUri(baseUrl, queryParameters));
    final response = await http.get(Uri.https(baseUrl, target, queryParameters));
    // print("SSS: ${response.statusCode}");
    if (response.statusCode == 200) {
      // print("SSS: ${response.body}");
      return DirectionsModel.fromJson(response.body);
    }
    return null;
  }
}
