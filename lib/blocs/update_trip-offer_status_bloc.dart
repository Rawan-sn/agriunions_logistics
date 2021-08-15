import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:agriunions_logistics/user_interfaces/widget/progress_dialog.dart';

import 'package:agriunions_logistics/Localization/AppLocal.dart';
import 'package:agriunions_logistics/providers/api_trip_offers.dart';
import 'package:agriunions_logistics/user_interfaces/widget/general_widget.dart';

class UpdateTripOfferStatusBloc {
  updateRequestTripStatus(BuildContext context, String? tripId, String status) {
    ProgressDialog progressDialog = GeneralWidget.progressDialog(context);
    progressDialog.show().then((value) {
      ApiTripOffers(context)
          .updateTripOffersStatus(status, tripId!)
          .then((value) {
        progressDialog.hide();
        if (value != null) {
          Fluttertoast.showToast(
              msg: AppLocalizations.of(context)!.trans("success")!);
        }
      });
    });
  }
}
