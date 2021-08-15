import 'package:flutter/material.dart';
import 'package:agriunions_logistics/Localization/AppLocal.dart';
import 'package:agriunions_logistics/models/branch_model.dart';
import 'package:agriunions_logistics/models/create_models/search_filter_model.dart';
import 'package:agriunions_logistics/models/details_trip_offer_model.dart';
import 'package:agriunions_logistics/models/trip_offer_model.dart';
import 'package:agriunions_logistics/models/vehicle_model.dart';
import 'package:agriunions_logistics/user_interfaces/dialogs&bottom_sheets/dialogs/search_filter_dialog.dart';
import 'package:agriunions_logistics/user_interfaces/dialogs&bottom_sheets/dialogs/branch_dialog_box.dart';
import 'package:agriunions_logistics/user_interfaces/dialogs&bottom_sheets/dialogs/trip_request_dialog_box.dart';
import 'package:agriunions_logistics/user_interfaces/dialogs&bottom_sheets/dialogs/vehicle_dialog_box.dart';
import 'dialogs/change_password_dialog_box.dart';
import 'dialogs/create_link_request_dialog_box.dart';
import 'dialogs/details_vehicle_trip_dialog.dart';

class ShowDialogs {
  static showAlert(
      BuildContext context, String? title, String? content, Function() pressed) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title!),
          content: Text(content!),
          shape: RoundedRectangleBorder(
              borderRadius: new BorderRadius.circular(15)),
          actions: <Widget>[
            TextButton(
              child: Text(
                AppLocalizations.of(context)!.trans('yes')!,
                style: TextStyle(color: Colors.grey[900]),
              ),
              onPressed: () {
                pressed();
              },
            ),
            TextButton(
              child: Text(
                AppLocalizations.of(context)!.trans('no')!,
                style: TextStyle(color: Colors.grey[900]),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  static createBranchDialog(BuildContext context, {BranchesModel? model}) async {
    return await showDialog(
      context: context,
      builder: (BuildContext context) {
        return BranchDialogBox(model: model);
      },
    );
  }

  static createVehicleDialog(BuildContext context, {VehicleModel? model}) async {
    return await showDialog(
      context: context,
      builder: (BuildContext context) {
        return VehicleDialogBox(model: model);
      },
    );
  }

  static detailsVehicleTripDialog(
      BuildContext context, TripDetailsOfferModel? model) async {
    return await showDialog(
      context: context,
      builder: (BuildContext context) {
        return DetailsVehicleTripDialogBox(model);
      },
    );
  }

  static sendTripRequestDialog(
      BuildContext context, TripOfferModel tripOffer) async {
    return await showDialog(
      context: context,
      builder: (BuildContext context) {
        return TripRequestDialogBox(tripOffer);
      },
    );
  }

  static showSearchFilterDialog(
      BuildContext context,
      SearchFilterModel? oldFilterModel,
      void completation(SearchFilterModel? searchFilterModel)) async {
    final SearchFilterModel? filterModel = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return SearchFilterDialog(
          filterModel: oldFilterModel,
        );
      },
    );
    completation(filterModel);
  }


  static createLinkRequestsDialog(BuildContext context) async {
    return await showDialog(
      context: context,
      builder: (BuildContext context) {
        return CreateLinkRequestDialogBox();
      },
    );
  }

  static changPasswordDialog(BuildContext context) async {
    return await showDialog(
      context: context,
      builder: (BuildContext context) {
        return ChangePasswordDialogBox();
      },
    );
  }

}
