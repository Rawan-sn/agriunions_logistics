import 'dart:convert';

class RealTimeShippingFilterModel {
  String? keyword;
  double? latitude;
  double? longitude;

  RealTimeShippingFilterModel({
    this.keyword,
    this.latitude,
    this.longitude,
  });

  Map<String, dynamic> toMap() {
    return {
      'keyword': keyword,
      'latitude': longitude,
      'longitude': longitude,
    };
  }

  Map<String, String> toParameterMap() {
    Map<String, String> body = {};
    if ((keyword ?? "").isNotEmpty) body["keyword"] = "$keyword";
    if (latitude != null) body["latitude"] = "$latitude";
    if (longitude != null) body["longitude"] = "$longitude";
    print(body);
    return body;
  }

  static RealTimeShippingFilterModel? fromMap(Map<String, dynamic>? map) {
    if (map == null) return null;

    return RealTimeShippingFilterModel(
      keyword: map['keyword'],
      latitude: map['latitude'],
      longitude: map['longitude'],
    );
  }

  String toJson() => json.encode(toMap());

  static RealTimeShippingFilterModel? fromJson(String source) =>
      fromMap(json.decode(source));
}
