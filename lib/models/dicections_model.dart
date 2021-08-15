import 'dart:convert';

import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class DirectionsModel {
  LatLngBounds? bounds;
  List<PointLatLng>? polylinePoints;
  String? totalDistance;
  String? totalDuration;
  DirectionsModel({
    this.bounds,
    this.polylinePoints,
    this.totalDistance,
    this.totalDuration,
  });

  factory DirectionsModel.fromMap(Map<String, dynamic> map) {
    if ((map['routes'] as List).isEmpty) return DirectionsModel();
    final data = Map<String, dynamic>.from(map['routes'][0]);
    final southwest = data['bounds']['southwest'];
    final northeast = data['bounds']['northeast'];
    final bounds = LatLngBounds(
      southwest: LatLng(southwest['lat'], southwest['lng']),
      northeast: LatLng(northeast['lat'], northeast['lng']),
    );
    String? distance;
    String? duration;
    if ((data['legs'] as List).isNotEmpty) {
      final leg = data['legs'][0];
      distance = leg['distance']['text'];
      duration = leg['duration']['text'];
    }
    return DirectionsModel(
      bounds: bounds,
      polylinePoints:
          PolylinePoints().decodePolyline(data['overview_polyline']['points']),
      totalDistance: distance,
      totalDuration: duration,
    );
  }

  factory DirectionsModel.fromJson(String source) =>
      DirectionsModel.fromMap(json.decode(source));
}
