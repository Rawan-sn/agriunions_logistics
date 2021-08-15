import 'dart:convert';

class TripOfferRequestsInfoModel {
  int numberAcceptedRequests;
  int tripOfferRequestsNumberOfBoxes;
  double tripOfferRequestsWeight;
  double tripOfferRequestsPrice;
  TripOfferRequestsInfoModel({
    this.numberAcceptedRequests = 0,
    this.tripOfferRequestsNumberOfBoxes = 0,
    this.tripOfferRequestsWeight = 0.0,
    this.tripOfferRequestsPrice = 0.0,
  });

  Map<String, dynamic> toMap() {
    return {
      'numberAcceptedRequests': numberAcceptedRequests,
      'tripOfferRequestsNumberOfBoxes': tripOfferRequestsNumberOfBoxes,
      'tripOfferRequestsWeight': tripOfferRequestsWeight,
      'tripOfferRequestsPrice': tripOfferRequestsPrice,
    };
  }

  factory TripOfferRequestsInfoModel.fromMap(Map<String, dynamic> map) {
    return TripOfferRequestsInfoModel(
      numberAcceptedRequests: map['numberAcceptedRequests'] ?? 0,
      tripOfferRequestsNumberOfBoxes:
          map['tripOfferRequestsNumberOfBoxes'] ?? 0,
      tripOfferRequestsWeight: map['tripOfferRequestsWeight'] ?? 0.0,
      tripOfferRequestsPrice: map['tripOfferRequestsPrice'] ?? 0.0,
    );
  }

  String toJson() => json.encode(toMap());

  factory TripOfferRequestsInfoModel.fromJson(String source) =>
      TripOfferRequestsInfoModel.fromMap(json.decode(source));
}
