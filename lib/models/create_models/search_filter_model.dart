import 'dart:convert';

import 'package:agriunions_logistics/helper/app_constants.dart';
import 'package:agriunions_logistics/models/city_model.dart';
import 'package:agriunions_logistics/models/country_model.dart';

class SearchFilterModel {
  String? keyword;
  CountryModel? country;
  CityModel? departureCity;
  CityModel? destinationCity;
  DateTime? fromDate;
  DateTime? toDate;
  String? tripOfferId;
  bool? mineOnly;
  SearchFilterModel({
    this.keyword,
    this.country,
    this.departureCity,
    this.destinationCity,
    this.fromDate,
    this.toDate,
    this.tripOfferId,
    this.mineOnly = false,
  });

  Map<String, dynamic> toMap() {
    return {
      'keyword': keyword,
      'departure_city': departureCity!.toMap(),
      'destination_city': destinationCity!.toMap(),
      'fromDate': fromDate!.millisecondsSinceEpoch,
      'toDate': toDate!.millisecondsSinceEpoch,
      'trip_offer_id': tripOfferId,
      'mine_only': mineOnly,
    };
  }

  Map<String, String> toParameterMap() {
    Map<String, String> body = {
      'start_time': "00:00",
      'end_time': "23:59",
    };
    if ((keyword ?? "").isNotEmpty) body["keyword"] = "$keyword";
    if (departureCity != null)
      body["departure_city_id"] = "${departureCity?.id}";
    if (destinationCity != null)
      body["destination_city_id"] = "${destinationCity!.id}";
    if (fromDate != null)
      body["from_date"] = "${AppConstants.dateFormat1.format(fromDate!)}";
    if (toDate != null)
      body["to_date"] = "${AppConstants.dateFormat1.format(toDate!)}";
    if (tripOfferId != null) body["trip_offer_id"] = "$tripOfferId";
    body["mine_only"] = mineOnly! ? "1" : "0";
    print(body);
    return body;
  }

  static SearchFilterModel? fromMap(Map<String, dynamic>? map) {
    if (map == null) return null;

    return SearchFilterModel(
      keyword: map['keyword'],
      departureCity: CityModel.fromMap(map['departure_city']),
      destinationCity: CityModel.fromMap(map['destination_city']),
      fromDate: DateTime.fromMillisecondsSinceEpoch(map['fromDate']),
      toDate: DateTime.fromMillisecondsSinceEpoch(map['toDate']),
      tripOfferId: map['trip_offer_id'],
      mineOnly: map['mine_only'],
    );
  }

  String toJson() => json.encode(toMap());

  static SearchFilterModel? fromJson(String source) =>
      fromMap(json.decode(source));
}
