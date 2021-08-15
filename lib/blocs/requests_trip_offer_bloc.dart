import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:agriunions_logistics/Localization/AppLocal.dart';
import 'package:agriunions_logistics/models/create_models/search_filter_model.dart';
import 'package:agriunions_logistics/models/trip_offer_request_model.dart';
import 'package:agriunions_logistics/models/trip_offer_requests_info_model.dart';
import 'package:agriunions_logistics/providers/api_trip_offers.dart';
import 'package:agriunions_logistics/user_interfaces/widget/general_widget.dart';
import 'package:agriunions_logistics/user_interfaces/widget/progress_dialog.dart';
import 'package:rxdart/rxdart.dart';

class RequestsTripOffersBloc {
  List<TripOfferRequestModel> tripOfferRequest = [];

  int page = 1;
  bool hasNext = true;
  bool loadData = false;

  final _tripOffersRequestController =
      PublishSubject<List<TripOfferRequestModel>?>();
  get tripOffersRequestStream => _tripOffersRequestController.stream;

  final _tripOffersRequestsInfoController =
      PublishSubject<TripOfferRequestsInfoModel?>();
  get tripOffersRequestsInfoStream => _tripOffersRequestsInfoController.stream;

  final _isLoadingController = PublishSubject<bool>();
  get isLoadingStream => _isLoadingController.stream;

  final _isAllRequestsProcessedController = PublishSubject<bool>();
  get isAllRequestsProcessedStream => _isAllRequestsProcessedController.stream;

  clearTripOfferRequests() {
    page = 1;
    hasNext = true;
    tripOfferRequest.clear();
    _tripOffersRequestController.sink.add(null);
    _tripOffersRequestsInfoController.sink.add(null);
    loadData = false;
  }

  emptyTripOfferRequests() {
    page = 1;
    hasNext = true;
    tripOfferRequest.clear();
    _tripOffersRequestController.sink.add(tripOfferRequest);
    _tripOffersRequestsInfoController.sink.add(null);
    loadData = false;
  }

  getTripOfferRequests(BuildContext context, {SearchFilterModel? filterModel}) {
    if (!loadData && this.hasNext) {
      loadData = true;
      print("********** getTripOffersRequests **********");
      _isLoadingController.sink.add(true);
      ApiTripOffers(context)
          .getTripOffersRequests(this.page, filterModel)
          .then((webSer) {
        loadData = false;
        if (webSer != null) {
          tripOfferRequest.addAll(List<TripOfferRequestModel>.from(
              webSer.data.map((x) => TripOfferRequestModel.fromMap(x))));
          bool isAllRequestsProcessed = tripOfferRequest.isNotEmpty;
          for (var item in tripOfferRequest) {
            if (item.tripOfferRequestStatus == 'Pending') {
              isAllRequestsProcessed = false;
              break;
            }
          }
          _isAllRequestsProcessedController.sink.add(isAllRequestsProcessed);
          if (!_tripOffersRequestController.isClosed) {
            _tripOffersRequestController.sink.add(tripOfferRequest);
          }
          if (tripOfferRequest.isNotEmpty) {
            TripOfferRequestsInfoModel info = TripOfferRequestsInfoModel();
            for (var item in tripOfferRequest) {
              if (item.tripOfferRequestStatus == 'Received') {
                info.numberAcceptedRequests++;
                info.tripOfferRequestsNumberOfBoxes +=
                    item.tripOfferRequestsNumberOfBoxes!;
                info.tripOfferRequestsWeight += item.tripOfferRequestsWeight!;
                info.tripOfferRequestsPrice += item.tripOfferRequestsPrice!;
              }
            }
            _tripOffersRequestsInfoController.sink.add(info);
          }
          if (webSer.pagination!.currentPage! <
              webSer.pagination!.totalPages!) {
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

  createRequestTrip(BuildContext context, var body) {
    ProgressDialog progressDialog = GeneralWidget.progressDialog(context);
    progressDialog.show().then((value) {
      ApiTripOffers(context).createTripOffersRequest(body).then((value) {
        progressDialog.hide();
        if (value != null) {
          Fluttertoast.showToast(
              msg: AppLocalizations.of(context)!.trans("success")!);
          Navigator.pop(context, true);
        }
      });
    });
  }

  setStatusRequestTrip(
    BuildContext context,
    String? tripOfferRequestId,
    bool isAccept,
    SearchFilterModel? filterModel,
  ) {
    ProgressDialog progressDialog = GeneralWidget.progressDialog(context);
    progressDialog.show().then((value) {
      ApiTripOffers(context)
          .setStatusTripOffersRequest(tripOfferRequestId, isAccept)
          .then((value) {
        progressDialog.hide();
        if (value != null) {
          Fluttertoast.showToast(
            msg: AppLocalizations.of(context)!.trans("success")!,
          );
          clearTripOfferRequests();
          getTripOfferRequests(context, filterModel: filterModel);
        }
      });
    });
  }

  startTripProcess(
    BuildContext context,
    String? tripOfferRequestId,
    DateTime? date,
  ) {
    ProgressDialog progressDialog = GeneralWidget.progressDialog(context);
    progressDialog.show().then((value) {
      ApiTripOffers(context)
          .startTripProcess(tripOfferRequestId!, date!)
          .then((value) {
        progressDialog.hide();
        if (value != null) {
          Fluttertoast.showToast(
            msg: AppLocalizations.of(context)!.trans("success")!,
          );
        }
      });
    });
  }

  void dispose() {
    _tripOffersRequestController.close();
    _tripOffersRequestsInfoController.close();
    _isLoadingController.close();
    _isAllRequestsProcessedController.close();
  }
}
