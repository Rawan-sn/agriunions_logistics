import 'dart:convert';

import 'package:agriunions_logistics/helper/data_store.dart';

class TripOfferRequestModel {
  String? id;
  String? tripOfferRequestId;
  String? tripOfferRequestStatus;
  int? tripOfferRequestsNumberOfBoxes;
  double? tripOfferRequestsWeight;
  double? tripOfferRequestsPrice;
  String? username;
  String? email;
  String? mobile;
  String? number;
  String? branchId;
  String? branchLocalName;
  String? branchLatinName;
  String? branchName;
  String? vehicleId;
  String? vehicleLocalName;
  String? vehicleLatinName;
  String? vehicleName;
  String? vehicleClassificationId;
  String? vehicleClassificationLocalName;
  String? vehicleClassificationLatinName;
  String? vehicleClassificationName;
  String? departureId;
  String? departureLocalName;
  String? departureLatinName;
  String? departureName;
  String? destinationBranchId;
  String? destinationLocalName;
  String? destinationLatinName;
  String? destinationName;
  String? departureLatitude;
  String? departureLongitude;
  String? destinationLatitude;
  String? destinationLongitude;
  String? departureCityId;
  String? departureCityLocalName;
  String? departureCityLatinName;
  String? departureCityName;
  String? destinationCityId;
  String? destinationCityLocalName;
  String? destinationCityLatinName;
  String? destinationCityName;

  TripOfferRequestModel({
    this.id,
    this.tripOfferRequestId,
    this.tripOfferRequestStatus,
    this.tripOfferRequestsNumberOfBoxes,
    this.tripOfferRequestsWeight,
    this.tripOfferRequestsPrice,
    this.username,
    this.email,
    this.mobile,
    this.number,
    this.branchId,
    this.branchLocalName,
    this.branchLatinName,
    this.vehicleId,
    this.vehicleLocalName,
    this.vehicleLatinName,
    this.vehicleClassificationId,
    this.vehicleClassificationLocalName,
    this.vehicleClassificationLatinName,
    this.departureId,
    this.departureLocalName,
    this.departureLatinName,
    this.destinationBranchId,
    this.destinationLocalName,
    this.destinationLatinName,
    this.departureLatitude,
    this.departureLongitude,
    this.destinationLatitude,
    this.destinationLongitude,
    this.departureCityId,
    this.departureCityLocalName,
    this.departureCityLatinName,
    this.destinationCityId,
    this.destinationCityLocalName,
    this.destinationCityLatinName,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'trip_offer_request_id': tripOfferRequestId,
      'trip_offer_request_status': tripOfferRequestStatus,
      'trip_offer_request_number_of_boxes': tripOfferRequestsNumberOfBoxes,
      'trip_offer_request_weight': tripOfferRequestsWeight,
      'trip_offer_request_price': tripOfferRequestsPrice,
      'username': username,
      'email': email,
      'mobile': mobile,
      'number': number,
      'branch_id': branchId,
      'branch_local_name': branchLocalName,
      'branch_latin_name': branchLatinName,
      'vehicle_id': vehicleId,
      'vehicle_local_name': vehicleLocalName,
      'vehicle_latin_name': vehicleLatinName,
      'vehicle_classification_id': vehicleClassificationId,
      'vehicle_classification_local_Name': vehicleClassificationLocalName,
      'vehicle_classification_latin_Name': vehicleClassificationLatinName,
      'departure_id': departureId,
      'departure_local_name': departureLocalName,
      'departure_latin_name': departureLatinName,
      'destination_branch_id': destinationBranchId,
      'destination_local_name': destinationLocalName,
      'destination_latin_name': destinationLatinName,
      'Departure_Latitude': departureLatitude,
      'Departure_Longitude': departureLongitude,
      'Destination_Latitude': destinationLatitude,
      'Destination_Longitude': destinationLongitude,
      'departure_city_id': departureCityId,
      'departure_city_local_name': departureCityLocalName,
      'departure_city_latin_name': departureCityLatinName,
      'destination_city_id': destinationCityId,
      'destination_city_local_name': destinationCityLocalName,
      'destination_city_latin_name': destinationCityLatinName,
    };
  }

  factory TripOfferRequestModel.fromMap(Map<String, dynamic> map) {
    TripOfferRequestModel model = TripOfferRequestModel(
      id: map['id'],
      tripOfferRequestId: map['trip_offer_request_id'],
      tripOfferRequestStatus: map['trip_offer_request_status'],
      tripOfferRequestsNumberOfBoxes: map['trip_offer_request_number_of_boxes'],
      tripOfferRequestsWeight: map['trip_offer_request_weight'],
      tripOfferRequestsPrice: map['trip_offer_request_price'],
      username: map['username'],
      email: map['email'],
      mobile: map['mobile'],
      number: map['number'],
      branchId: map['branch_id'],
      branchLocalName: map['branch_local_name'],
      branchLatinName: map['branch_latin_name'],
      vehicleId: map['vehicle_id'],
      vehicleLocalName: map['vehicle_local_name'],
      vehicleLatinName: map['vehicle_latin_name'],
      vehicleClassificationId: map['vehicle_classification_id'],
      vehicleClassificationLocalName: map['vehicle_classification_local_Name'],
      vehicleClassificationLatinName: map['vehicle_classification_latin_Name'],
      departureId: map['departure_id'],
      departureLocalName: map['departure_local_name'],
      departureLatinName: map['departure_latin_name'],
      destinationBranchId: map['destination_branch_id'],
      destinationLocalName: map['destination_local_name'],
      destinationLatinName: map['destination_latin_name'],
      departureLatitude: map['Departure_Latitude'],
      departureLongitude: map['Departure_Longitude'],
      destinationLatitude: map['Destination_Latitude'],
      destinationLongitude: map['Destination_Longitude'],
      departureCityId: map['departure_city_id'],
      departureCityLocalName: map['departure_city_local_name'],
      departureCityLatinName: map['departure_city_latin_name'],
      destinationCityId: map['destination_city_id'],
      destinationCityLocalName: map['destination_city_local_name'],
      destinationCityLatinName: map['destination_city_latin_name'],
    );
    if (dataStore.lang == dataStore.localLang) {
      model.branchName = model.branchLocalName;
      model.vehicleName = model.vehicleLocalName;
      model.vehicleClassificationName = model.vehicleClassificationLocalName;
      model.departureName = model.departureLocalName;
      model.destinationName = model.destinationLocalName;
      model.departureCityName = model.departureCityLocalName;
      model.destinationCityName = model.destinationCityLocalName;
    } else {
      model.branchName = model.branchLatinName;
      model.vehicleName = model.vehicleLatinName;
      model.vehicleClassificationName = model.vehicleClassificationLatinName;
      model.departureName = model.departureLatinName;
      model.destinationName = model.destinationLatinName;
      model.departureCityName = model.departureCityLatinName;
      model.destinationCityName = model.destinationCityLatinName;
    }
    return model;
  }

  String toJson() => json.encode(toMap());

  factory TripOfferRequestModel.fromJson(String source) =>
      TripOfferRequestModel.fromMap(json.decode(source));
}
