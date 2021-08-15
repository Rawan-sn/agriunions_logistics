import 'dart:convert';

import 'package:agriunions_logistics/helper/data_store.dart';

class CityModel {
  String? id;
  String? number;
  String? localName;
  String? latinName;
  String? name;
  String? countryId;

  CityModel({
    this.id,
    this.number,
    this.localName,
    this.latinName,
    this.name,
    this.countryId,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'number': number,
      'local_name': localName,
      'latin_name': latinName,
      'country_id': countryId,
    };
  }

  factory CityModel.fromMap(Map<String, dynamic> map) {
    CityModel model = CityModel(
      id: map['id'],
      number: map['number'],
      localName: map['local_name'],
      latinName: map['latin_name'],
      countryId: map['country_id'],
    );
    if (dataStore.lang == dataStore.localLang) {
      model.name = model.localName;
    } else {
      model.name = model.latinName;
    }
    return model;
  }

  String toJson() => json.encode(toMap());

  factory CityModel.fromJson(String source) =>
      CityModel.fromMap(json.decode(source));
}
