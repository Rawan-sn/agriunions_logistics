import 'dart:convert';

import 'package:agriunions_logistics/helper/data_store.dart';

class TripOfferModel {
  String? id;
  String? number;
  String? startDate;
  String? endData;
  String? startTime;
  String? endTime;
  String? rotationType;
  int? rotationFactor;
  String? description;
  String? branchId;
  String? branchName;
  String? branchLocalName;
  String? branchLatinName;
  String? branchUserId;
  String? branchUsername;
  String? price;
  String? vehicleId;
  String? vehicleName;
  String? vehicleLocalName;
  String? vehicleLatinName;
  String? vehicleUserId;
  String? vehicleUsername;
  String? vehicleClassificationId;
  String? vehicleClassificationName;
  String? vehicleClassificationLocalName;
  String? vehicleClassificationLatinName;
  List<String>? attachments;
  String? departureId;
  String? departureName;
  String? departureLocalName;
  String? departureLatinName;
  String? destinationBranchId;
  String? destinationName;
  String? destinationLocalName;
  String? destinationLatinName;
  String? departureLatitude;
  String? departureLongitude;
  String? destinationLatitude;
  String? destinationLongitude;
  String? departureCityId;
  String? departureCityName;
  String? departureCityLocalName;
  String? departureCityLatinName;
  String? destinationCityId;
  String? destinationCityName;
  String? destinationCityLocalName;
  String? destinationCityLatinName;
  String? numberOfRequests;
  String? numberOfYourRequests;
  String? today;
  bool? canControl;

  TripOfferModel({
    this.id,
    this.number,
    this.branchId,
    this.startDate,
    this.endData,
    this.startTime,
    this.endTime,
    this.rotationType,
    this.rotationFactor,
    this.description,
    this.branchLocalName,
    this.branchLatinName,
    this.branchUserId,
    this.branchUsername,
    this.price,
    this.vehicleId,
    this.vehicleLocalName,
    this.vehicleLatinName,
    this.vehicleUserId,
    this.vehicleUsername,
    this.attachments,
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
    this.numberOfRequests,
    this.numberOfYourRequests,
    this.today,
    this.canControl,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'number': number,
      'start_date': startDate,
      'end_date': endData,
      'start_time': startTime,
      'end_time': endTime,
      'rotation_type': rotationType,
      'rotation_factor': rotationFactor,
      'description': description,
      'branch_id': branchId,
      'branch_local_name': branchLocalName,
      'branch_latin_name': branchLatinName,
      'branch_user_id': branchUserId,
      'branch_username': branchUsername,
      'price': price,
      'vehicle_id': vehicleId,
      'vehicle_local_name': vehicleLocalName,
      'vehicle_latin_name': vehicleLatinName,
      'vehicle_user_id': vehicleUserId,
      'vehicle_username': vehicleUsername,
      'vehicle_attachments': attachments,
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
      'today': today,
      'number_of_requests': numberOfRequests,
      'number_of_your_requests': numberOfYourRequests,
      'can_control': canControl,
    };
  }

  factory TripOfferModel.fromMap(Map<String, dynamic> map) {
    TripOfferModel model = TripOfferModel(
      id: map['id'],
      number: map['number'],
      startDate: map['start_date'],
      endData: map['end_date'],
      startTime: map['start_time'],
      endTime: map['end_time'],
      rotationType: map['rotation_type'],
      rotationFactor: map['rotation_factor'],
      description: map['description'],
      branchId: map['branch_id'],
      branchLocalName: map['branch_local_name'],
      branchLatinName: map['branch_latin_name'],
      branchUserId: map['branch_user_id'],
      branchUsername: map['branch_username'],
      price: double.tryParse(map['price'])?.toStringAsFixed(2) ?? "0.0",
      vehicleId: map['vehicle_id'],
      vehicleLocalName: map['vehicle_local_name'],
      vehicleLatinName: map['vehicle_latin_name'],
      vehicleUserId: map['vehicle_user_id'],
      vehicleUsername: map['vehicle_username'],
      attachments: List<String>.from(map['vehicle_attachments'] ?? const []),
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
      numberOfRequests: map['number_of_requests'],
      numberOfYourRequests: map['number_of_your_requests'],
      today: map['today'],
      canControl: map['can_control'],
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

  factory TripOfferModel.fromJson(String source) =>
      TripOfferModel.fromMap(json.decode(source));
}
