import 'dart:convert';

import 'package:agriunions_logistics/helper/data_store.dart';

class CountryModel {
  String? id;
  String? number;
  String? localName;
  String? latinName;
  String? name;

  CountryModel({
    this.id,
    this.number,
    this.name,
    this.localName,
    this.latinName,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'number': number,
      'local_name': localName,
      'latin_name': latinName,
    };
  }

  factory CountryModel.fromMap(Map<String, dynamic> map) {
    CountryModel model = CountryModel(
      id: map['id'],
      number: map['name'],
      localName: map['local_name'],
      latinName: map['latin_name'],
    );
    if (dataStore.lang == dataStore.localLang) {
      model.name = model.localName;
    } else {
      model.name = model.latinName;
    }
    return model;
  }

  String toJson() => json.encode(toMap());

  factory CountryModel.fromJson(String source) =>
      CountryModel.fromMap(json.decode(source));
}
