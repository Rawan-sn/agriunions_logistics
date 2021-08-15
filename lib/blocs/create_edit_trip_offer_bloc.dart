import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:agriunions_logistics/Localization/AppLocal.dart';
import 'package:agriunions_logistics/models/create_models/create_trip_offer_model.dart';
import 'package:agriunions_logistics/providers/api_trip_offers.dart';
import 'package:agriunions_logistics/user_interfaces/widget/general_widget.dart';
import 'package:agriunions_logistics/user_interfaces/widget/progress_dialog.dart';

class CreateEditTripOfferBloc {
  CreateTripOfferModel model = CreateTripOfferModel();

  bool _checkIsValid(BuildContext context) {
    if ((model.price ?? "").isEmpty) {
      Fluttertoast.showToast(
        msg: AppLocalizations.of(context)!.trans("please_add_price")!,
      );
      return false;
    }
    if (model.branchId == null) {
      Fluttertoast.showToast(
        msg: AppLocalizations.of(context)!.trans("please_add_branch")!,
      );
      return false;
    }
    // if (model.vehicleId == null) {
    //   Fluttertoast.showToast(
    //     msg: AppLocalizations.of(context).trans("please_add_vehicle"),
    //   );
    //   return false;
    // }
    if (model.rotationType == null) {
      Fluttertoast.showToast(
        msg: AppLocalizations.of(context)!.trans("please_add_trip_type")!,
      );
      return false;
    }
    if (model.rotationFactor == null) {
      Fluttertoast.showToast(
        msg: AppLocalizations.of(context)!.trans("please_add_trip_factor")!,
      );
      return false;
    }
    if (model.startDate == null) {
      Fluttertoast.showToast(
        msg: AppLocalizations.of(context)!.trans("please_add_start_date")!,
      );
      return false;
    }
    if (model.endDate == null) {
      Fluttertoast.showToast(
        msg: AppLocalizations.of(context)!.trans("please_add_end_date")!,
      );
      return false;
    }
    if (model.startTime == null) {
      Fluttertoast.showToast(
        msg: AppLocalizations.of(context)!.trans("please_add_start_time")!,
      );
      return false;
    }
    if (model.endTime == null) {
      Fluttertoast.showToast(
        msg: AppLocalizations.of(context)!.trans("please_add_end_time")!,
      );
      return false;
    }
    if (model.departureCityId == null) {
      Fluttertoast.showToast(
        msg: AppLocalizations.of(context)!.trans("please_add_departure_city")!,
      );
      return false;
    }
    if (model.departureLatitude == null && model.departureLongitude == null) {
      Fluttertoast.showToast(
        msg: AppLocalizations.of(context)!
            .trans("please_add_departure_location")!,
      );
      return false;
    }
    if (model.localDescription == null) {
      Fluttertoast.showToast(
        msg: AppLocalizations.of(context)!.trans("please_add_description")!,
      );
      return false;
    }
    if (model.latinDescription == null) {
      Fluttertoast.showToast(
        msg: AppLocalizations.of(context)!.trans("please_add_description")!,
      );
      return false;
    }
    return true;
  }

  createTrip(BuildContext context) {
    if (_checkIsValid(context)) {
      ProgressDialog progressDialog = GeneralWidget.progressDialog(context);
      progressDialog.show().then((value) {
        ApiTripOffers(context).createTripOffer(model.toMap()).then((value) {
          progressDialog.hide();
          if (value != null) {
            Fluttertoast.showToast(
                msg: AppLocalizations.of(context)!.trans("success")!);
            Navigator.pop(context, true);
          }
        });
      });
    }
  }

  editTrip(BuildContext context, String? tripId) {
    if (_checkIsValid(context)) {
      ProgressDialog progressDialog = GeneralWidget.progressDialog(context);
      progressDialog.show().then((value) {
        ApiTripOffers(context)
            .editTripOffer(model.toMap(), tripId!)
            .then((value) {
          progressDialog.hide();
          if (value != null) {
            Fluttertoast.showToast(
                msg: AppLocalizations.of(context)!.trans("success")!);
            Navigator.pop(context, true);
          }
        });
      });
    }
  }
}
