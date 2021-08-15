import 'dart:convert';

import 'package:agriunions_logistics/helper/data_store.dart';

class InitialDataModel {
  String? registerNote;
  String? defaultCountryId;
  String? defaultCountryLocalName;
  String? defaultCountryLatinName;
  String? name;

  InitialDataModel(
      {this.registerNote,
      this.defaultCountryId,
      this.defaultCountryLatinName,
      this.defaultCountryLocalName,
      this.name});

  Map<String, dynamic> toMap() {
    return {
      'register_note': registerNote,
      'default_country_id': defaultCountryId,
      'default_country_local_name': defaultCountryLocalName,
      'default_country_latin_name': defaultCountryLatinName,
    };
  }

  factory InitialDataModel.fromMap(Map<String, dynamic> map) {
    InitialDataModel model = new InitialDataModel(
        registerNote: map['register_note'] ?? '',
        defaultCountryId: map['default_country_id'] ?? '',
        defaultCountryLatinName: map['default_country_latin_name'] ?? '',
        defaultCountryLocalName: map['default_country_local_name'] ?? '');
    if(dataStore.lang==dataStore.localLang)
      {
        model.name=model.defaultCountryLocalName;
      }
    else
      {
        model.name=model.defaultCountryLatinName;
      }
      return model;
  }

  String toJson() => json.encode(toMap());

  factory InitialDataModel.fromJson(String source) =>
      InitialDataModel.fromMap(json.decode(source));
}
