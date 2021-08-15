import 'dart:convert';

import 'package:agriunions_logistics/helper/data_store.dart';

class BranchesModel {
  String? id;
  String? number;
  String? localName;
  String? latinName;
  String? branchName;
  String? countryId;
  String? countryLocalName;
  String? countryLatinName;
  String? countryName;
  String? cityId;
  String? address;
  String? latitude;
  String? longitude;
  BranchesModel({
    this.id,
    this.number,
    this.branchName,
    this.localName,
    this.latinName,
    this.countryId,
    this.countryLocalName,
    this.countryLatinName,
    this.cityId,
    this.address,
    this.latitude,
    this.longitude,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'number': number,
      'local_name': localName,
      'latin_name': latinName,
      'country_id': countryId,
      "country_local_name":countryLocalName,
      'country_latin_name':countryLatinName,
      'city_id': cityId,
      'address': address,
      'latitude': latitude,
      'longitude': longitude,
    };
  }

  factory BranchesModel.fromMap(Map<String, dynamic> map) {
    BranchesModel model= BranchesModel(
      id: map['id'],
      number: map['number'],
      localName: map['local_name'],
      latinName: map['latin_name'],
      countryId: map['country_id'],
      countryLocalName: map['country_local_name'],
      countryLatinName: map['country_latin_name'],
      cityId: map['city_id'],
      address: map['address'],
      latitude: map['latitude'],
      longitude: map['longitude'],
    );
    if (dataStore.lang == dataStore.localLang) {
      model.branchName=model.localName;
      model.countryName=model.countryLocalName;
    }
    else
    {
      model.branchName=model.latinName;
      model.countryName=model.countryLatinName;
    }
    return model;
  }

  String toJson() => json.encode(toMap());

  factory BranchesModel.fromJson(String source) => BranchesModel.fromMap(json.decode(source));

}
