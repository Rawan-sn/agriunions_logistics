import 'package:flutter/cupertino.dart';
import 'package:agriunions_logistics/models/details_trip_offer_model.dart';
import 'package:agriunions_logistics/providers/api_trip_offers.dart';
import 'package:rxdart/rxdart.dart';

class TripOfferDetailsBloc {
  final _tripOfferDetailsController = PublishSubject<TripDetailsOfferModel?>();

  get tripOfferDetailsStream => _tripOfferDetailsController.stream;

  final _isLoadingController = PublishSubject<bool>();

  get isLoadingStream => _isLoadingController.stream;

  clearTripOfferDetails() {
    _tripOfferDetailsController.sink.add(null);
  }

  getTripOfferDetails(BuildContext context, String tripId) {
    _isLoadingController.sink.add(true);
    ApiTripOffers(context).getTripOfferDetails(tripId).then((webSer) {
      if (webSer != null) {
        if (!_tripOfferDetailsController.isClosed) {
          _tripOfferDetailsController.sink.add(TripDetailsOfferModel.fromMap(
              Map<String, dynamic>.from(webSer.data)));
        }
      }
      if (!_isLoadingController.isClosed) {
        _isLoadingController.sink.add(false);
      }
    });
  }

  void dispose() {
    _tripOfferDetailsController.close();
    _isLoadingController.close();
  }
}
