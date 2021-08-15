import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:agriunions_logistics/Localization/AppLocal.dart';
import 'package:agriunions_logistics/models/create_models/create_vehicle_model.dart';
import 'package:agriunions_logistics/providers/api_vehicle.dart';
import 'package:agriunions_logistics/user_interfaces/widget/general_widget.dart';
import 'package:agriunions_logistics/user_interfaces/widget/progress_dialog.dart';
import 'package:agriunions_logistics/user_interfaces/pages/general/add_media_page.dart';

class CreateEditVehicleBloc {
  CreateVehicleModel model = new CreateVehicleModel();

  bool _checkIsValid(BuildContext context, AddMediaPage? addMediaPage) {
    // if ((model.userId ?? "").isEmpty) {
    //   Fluttertoast.showToast(
    //     msg: AppLocalizations.of(context).trans("add_driver_required"),
    //   );
    //   return false;
    // }
    if ((model.localName ?? "").isEmpty || (model.latinName ?? "").isEmpty) {
      Fluttertoast.showToast(
        msg: AppLocalizations.of(context)!.trans("add_vehicle_name_required")!,
      );
      return false;
    }
    if ((model.branchId ?? "").isEmpty) {
      Fluttertoast.showToast(
        msg: AppLocalizations.of(context)!.trans("add_branch_required")!,
      );
      return false;
    }
    if ((model.classificationId ?? "").isEmpty) {
      Fluttertoast.showToast(
        msg: AppLocalizations.of(context)!
            .trans("add_classification_vehicle_required")!,
      );
      return false;
    }
    if (!addMediaPage!.isValidInput(context)) return false;
    model.attachments = addMediaPage.addMediaState.mB.attachments;
    return true;
  }

  createVehicle(BuildContext context, AddMediaPage? addMediaPage) {
    if (_checkIsValid(context, addMediaPage)) {
      ProgressDialog progressDialog = GeneralWidget.progressDialog(context);
      progressDialog.show().then((value) {
        ApiVehicle(context).createVehicle(model.toMap()).then((value) {
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

  editVehicle(BuildContext context, AddMediaPage? addMediaPage, String? id) {
    if (_checkIsValid(context, addMediaPage)) {
      ProgressDialog progressDialog = GeneralWidget.progressDialog(context);
      progressDialog.show().then((value) {
        ApiVehicle(context).updateVehicle(model.toMap(), id!).then((value) {
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
