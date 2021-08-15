import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:agriunions_logistics/Localization/AppLocal.dart';
import 'package:agriunions_logistics/models/create_models/register_as_service_provider_model.dart';
import 'package:agriunions_logistics/providers/api_register_provider.dart';
import 'package:agriunions_logistics/user_interfaces/pages/general/add_media_page.dart';
import 'package:agriunions_logistics/user_interfaces/widget/general_widget.dart';
import 'package:agriunions_logistics/user_interfaces/widget/progress_dialog.dart';

class RegisterAsServiceBloc {
  RegisterAsServiceProviderModel _registerModel =
      RegisterAsServiceProviderModel();
  bool _checkIsValid(
      BuildContext context, AddMediaPage addMediaPage, String? description) {
    if (!addMediaPage.isValidInput(context)) return false;
    if ((description ?? "").isEmpty) {
      Fluttertoast.showToast(
        msg: AppLocalizations.of(context)!
            .trans("noti_add_description_is_required")!,
      );
      return false;
    }
    _registerModel.description = description;
    _registerModel.attachments = addMediaPage.addMediaState.mB.attachments;
    return true;
  }

  registerAsService(context, AddMediaPage addMediaPage, String description) {
    if (_checkIsValid(context, addMediaPage, description)) {
      ProgressDialog progressDialog = GeneralWidget.progressDialog(context);
      progressDialog.show().then((value) {
        ApiRegisterProvider(context)
            .register(_registerModel.toMap())
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
