import 'dart:convert';
import 'package:geolocator/geolocator.dart';
import 'package:agriunions_logistics/helper/app_constants.dart';
import 'dart:io';
import 'package:path/path.dart' as p;

class GeneralFanc {
  static String pathTobase64Image(String path) {
    List<int> imageBytes = File(path).readAsBytesSync();
    return "${base64.encode(imageBytes)}";
  }

  static String pathTobase64Video(String path) {
    List<int> videoBytes = File(path).readAsBytesSync();
    return "data:video/mp4;base64,${base64.encode(videoBytes)}";
  }

  static String pathTobase64Voice(String path) {
    List<int> voiceBytes = File(path).readAsBytesSync();
    return "data:audio/aac;base64,${base64.encode(voiceBytes)}";
  }

  static getNameFromMediaPath(String path) {
    return p.basename(path);
  }

  static String dateformated(String? strDate) {
    if (strDate == null) return "";
    DateTime date = DateTime.parse(strDate);
    return AppConstants().dateFormat2.format(date.toLocal());
  }

  static String dateformatedWithDay(String? strDate) {
    if (strDate == null) return "";
    DateTime date = DateTime.parse(strDate);
    return AppConstants().dateFormat3.format(date.toLocal());
  }

  static String dateformatedFromDate(DateTime date) {
    return AppConstants().dateFormat2.format(date);
  }

  static Future<Position> determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permantly denied, we cannot request permissions.');
    }

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission != LocationPermission.whileInUse &&
          permission != LocationPermission.always) {
        return Future.error(
            'Location permissions are denied (actual value: $permission).');
      }
    }

    return await Geolocator.getCurrentPosition();
  }
}
