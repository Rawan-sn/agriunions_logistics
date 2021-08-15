import 'dart:convert';

class CreateTripOfferModel {
  String? price;
  String? branchId;
  String? vehicleId;
  String? startDate;
  String? endDate;
  String? startTime;
  String? endTime;
  String? rotationType;
  int? rotationFactor;
  String? localDescription;
  String? latinDescription;
  String? departureLatitude;
  String? departureLongitude;
  String? destinationLatitude;
  String? destinationLongitude;
  String? departureCityId;
  String? destinationCityId;

  CreateTripOfferModel({
    this.price,
    this.branchId,
    this.vehicleId,
    this.startDate,
    this.endDate,
    this.startTime,
    this.endTime,
    this.rotationType,
    this.rotationFactor = 1,
    this.localDescription,
    this.latinDescription,
    this.departureLatitude,
    this.departureLongitude,
    this.destinationLatitude,
    this.destinationLongitude,
    this.departureCityId,
    this.destinationCityId,
  });

  Map<String, dynamic> toMap() {
    return {
      'price': price,
      'branch_id': branchId,
      'vehicle_id': vehicleId,
      'start_date': startDate,
      'end_date': endDate,
      'start_time': startTime,
      'end_time': endTime,
      'rotation_type': rotationType,
      'rotation_factor': rotationFactor,
      'local_description': localDescription,
      'latin_description': latinDescription,
      'departure_latitude': departureLatitude,
      'departure_longitude': departureLongitude,
      'destination_latitude': destinationLatitude,
      'destination_longitude': destinationLongitude,
      'departure_city_id': departureCityId,
      'destination_city_id': destinationCityId,
    };
  }

  factory CreateTripOfferModel.fromMap(Map<String, dynamic> map) {
    return CreateTripOfferModel(
      price: map['price'],
      branchId: map['branch_id'],
      vehicleId: map['vehicle_id'],
      startDate: map['start_date'],
      endDate: map['end_date'],
      startTime: map['start_time'],
      endTime: map['end_time'],
      rotationType: map['rotation_type'],
      rotationFactor: map['rotation_factor'],
      localDescription: map['local_description'],
      latinDescription: map['latin_description'],
      departureLatitude: map['departure_latitude'],
      departureLongitude: map['departure_longitude'],
      destinationLatitude: map['destination_latitude'],
      destinationLongitude: map['destination_longitude'],
      departureCityId: map['departure_city_id'],
      destinationCityId: map['destination_city_id'],
    );
  }

  String toJson() => json.encode(toMap());

  factory CreateTripOfferModel.fromJson(String source) =>
      CreateTripOfferModel.fromMap(json.decode(source));
}
