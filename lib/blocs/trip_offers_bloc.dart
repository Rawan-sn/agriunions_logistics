import 'package:flutter/cupertino.dart';
import 'package:agriunions_logistics/models/create_models/search_filter_model.dart';
import 'package:agriunions_logistics/models/trip_offer_model.dart';
import 'package:agriunions_logistics/providers/api_trip_offers.dart';
import 'package:rxdart/rxdart.dart';

class TripOffersBloc {
  List<TripOfferModel> tripOffers = [];
  int page = 1;
  bool hasNext = true;
  bool loadData = false;

  final _tripOffersController = PublishSubject<List<TripOfferModel>?>();
  get tripOffersStream => _tripOffersController.stream;

  final _isLoadingController = PublishSubject<bool>();
  get isLoadingStream => _isLoadingController.stream;

  clearTripOffers() {
    page = 1;
    hasNext = true;
    tripOffers.clear();
    _tripOffersController.sink.add(null);
    loadData = false;
  }

  getSchedulesTripOffers(BuildContext context,
      {SearchFilterModel? filterModel}) {
    if (!loadData && this.hasNext) {
      loadData = true;
      print("********** getSchedulesTripOffers **********");
      _isLoadingController.sink.add(true);
      ApiTripOffers(context)
          .getSchedulesTripOffers(this.page, filterModel)
          .then((webSer) {
        loadData = false;
        if (webSer != null) {
          tripOffers.addAll(List<TripOfferModel>.from(
              webSer.data.map((x) => TripOfferModel.fromMap(x))));
          if (!_tripOffersController.isClosed) {
            _tripOffersController.sink.add(tripOffers);
          }
          if (webSer.pagination!.currentPage! < webSer.pagination!.totalPages!) {
            this.hasNext = true;
            this.page++;
          } else {
            this.hasNext = false;
          }
          if (!_isLoadingController.isClosed) {
            _isLoadingController.sink.add(false);
          }
        }
      });
    }
  }

  getMyTripsOffers(BuildContext context, {SearchFilterModel? filterModel}) {
    if (!loadData && this.hasNext) {
      loadData = true;
      print("********** getMyTripsOffers **********");
      _isLoadingController.sink.add(true);
      ApiTripOffers(context)
          .getMyTripOffers(this.page, filterModel)
          .then((webSer) {
        loadData = false;
        if (webSer != null) {
          tripOffers.addAll(List<TripOfferModel>.from(
              webSer.data.map((x) => TripOfferModel.fromMap(x))));
          if (!_tripOffersController.isClosed) {
            _tripOffersController.sink.add(tripOffers);
          }
          if (webSer.pagination!.currentPage! < webSer.pagination!.totalPages!) {
            this.hasNext = true;
            this.page++;
          } else {
            this.hasNext = false;
          }
          if (!_isLoadingController.isClosed) {
            _isLoadingController.sink.add(false);
          }
        }
      });
    }
  }

  void dispose() {
    _tripOffersController.close();
    _isLoadingController.close();
  }
}
