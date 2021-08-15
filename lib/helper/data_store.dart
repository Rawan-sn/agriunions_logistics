import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:agriunions_logistics/models/auth_user_model.dart';
import 'package:agriunions_logistics/helper/enums.dart';
import 'package:agriunions_logistics/models/country_model.dart';
import 'package:agriunions_logistics/models/initial_data_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DataStore {
  static final DataStore _dataStore = new DataStore._internal();
  Locale? locale;

  factory DataStore() {
    return _dataStore;
  }

  String? lang;
  String localLang = 'en';
  AuthUserModel? authUser;
  InitialDataModel? initialData;
  String? baseUrl;
  ProjectType? proType;
  CountryModel? country;

  DataStore._internal();
  setProjectType(ProjectType type) {
    this.proType = type;
    switch (type) {
      case ProjectType.production:
        this.baseUrl = "husam.from-ar.com:2000";
        break;
      case ProjectType.staging:
        this.baseUrl = "husam.from-ar.com:2000";
//        this.baseUrl = "husam.from-ar.com:56356";
//         this.baseUrl = "192.168.2.10:56356";
        break;
      default:
    }
  }

  Future<bool> setLang(String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    lang = value;
    return prefs.setString('Lang', value);
  }

  Future<void> getLang() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    lang = prefs.getString('Lang') ?? 'ar';
  }

  Future<bool> setCountry(CountryModel? value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    this.country = value;
    if (value != null) {
      return await prefs.setString('country', value.toJson());
    } else {
      return await prefs.remove('country');
    }
  }

  Future<CountryModel?> getCountry() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getString("country") == null) {
      this.country = null;
      return this.country;
    } else {
      var countryJson = json.decode(prefs.getString("country")!);
      this.country = CountryModel.fromMap(countryJson);
      return this.country;
    }
  }

  Future<bool> setAuthUser(String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.setString('user', value);
  }

  Future<bool> removeAuthUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.remove('user');
  }

  Future<void> freeUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('user');
    prefs.remove('country');
  }

  Future<AuthUserModel?> getAuthUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getString("user") == null) {
      this.authUser = null;
      return this.authUser;
    } else {
      var userJson = json.decode(prefs.getString("user")!);
      this.authUser = AuthUserModel.fromMap(userJson);
      return this.authUser;
    }
  }

  Future<bool> setInitialData(String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.setString('initialData', value);
  }

  Future<InitialDataModel?> getInitialData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getString("initialData") == null) {
      this.initialData = null;
      return this.initialData;
    } else {
      var initialDataJson = json.decode(prefs.getString("initialData")!);
      this.initialData = InitialDataModel.fromMap(initialDataJson);
      return this.initialData;
    }
  }
}

final dataStore = DataStore();
