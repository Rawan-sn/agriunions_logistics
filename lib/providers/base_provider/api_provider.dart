import 'dart:async';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:agriunions_logistics/Localization/AppLocal.dart';
import 'package:agriunions_logistics/models/web_service_response_model.dart';
import 'dart:io' show Platform;
import 'dart:io';

import 'package:agriunions_logistics/providers/base_provider/api_constants.dart';
import 'package:agriunions_logistics/helper/data_store.dart';
import 'package:agriunions_logistics/helper/enums.dart';
import 'package:agriunions_logistics/user_interfaces/pages/splash.dart';

class ApiProvider {
  BuildContext context;
  ApiProvider(this.context);

  Future<bool> _checkIsInternetConnected() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        print('connected');
        return true;
      }
    } on SocketException catch (_) {
      print('not connected');
      return false;
    }
    return false;
  }

  Uri getUri(String target, [Map? queryParameters]) {
    if (queryParameters != null) {
      return Uri.http(ApiConstants.authority!, target,
          queryParameters as Map<String, dynamic>?);
    } else {
      return Uri.http(ApiConstants.authority!, target);
    }
  }

  _getHeaders() {
    Map<String, String> headers = {
      "Accept": "application/json",
      "Content-Type": "application/json",
      "lang": dataStore.lang ?? "en",
    };
    if (dataStore.authUser != null) {
      headers["Authorization"] = dataStore.authUser?.token ?? "";
    }
    if (Platform.isAndroid) {
      headers["platform"] = "userandroid";
      headers["device_type"] = "android";
    } else if (Platform.isIOS) {
      headers["platform"] = "userios";
      headers["device_type"] = "ios";
    }
    return headers;
  }

  Future<dynamic> fetchRequest({
    required Uri uri,
    Map? body,
    RequestType type = RequestType.get,
  }) async {
    late var response;
    print("uri: $uri");
    try {
      bool isConnected = await _checkIsInternetConnected();
      print("_getHeaders: ${_getHeaders()}");
      if (isConnected) {
        switch (type) {
          case RequestType.get:
            response = await http.get(uri, headers: _getHeaders());
            break;
          case RequestType.post:
            response = await http.post(uri,
                headers: _getHeaders(), body: json.encode(body));
            break;
          case RequestType.put:
            response = await http.put(
              uri,
              headers: _getHeaders(),
              body: json.encode(body),
              encoding: utf8,
            );
            break;
          case RequestType.delete:
            response = await http.delete(uri, headers: _getHeaders());
            break;
          default:
        }
        if (response.statusCode == 200) {
          // If server returns an OK response, parse the JSON.
          var res = WebServiceResponse.fromJson(response.body);
          if (res.status == 200) {
            print(res.data);

            // print("===============${res.toJson()}");
            return res;
          } else if (res.status == 401) {
            if (dataStore.authUser != null) {
              dataStore.removeAuthUser().then((_) => Navigator.pushReplacement(
                  context, MaterialPageRoute(builder: (context) => Splash())));
            }
            Fluttertoast.showToast(msg: '${res.message}');
            return null;
          } else {
            Fluttertoast.showToast(msg: '${res.message}');
            return null;
          }
        } else {
          // If that response was not OK, throw an error.
          Fluttertoast.showToast(msg: '${response.body}');
          return null;
        }
      } else {
        Fluttertoast.showToast(
            msg: AppLocalizations.of(context)!.trans("no_connection")!);
        return null;
      }
    } catch (e) {
      print("Exception: ${e.toString()}");
      Fluttertoast.showToast(msg: e.toString());
      return null;
    }
  }
}
