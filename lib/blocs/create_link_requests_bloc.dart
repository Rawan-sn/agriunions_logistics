import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:agriunions_logistics/Localization/AppLocal.dart';
import 'package:agriunions_logistics/providers/api_users.dart';
import 'package:agriunions_logistics/user_interfaces/widget/general_widget.dart';
import 'package:agriunions_logistics/user_interfaces/widget/progress_dialog.dart';

class CreateLinkRequestBloc {
  String? userId;

  bool _checkIsValid(BuildContext context) {
    if ((userId ?? "").isEmpty) {
      Fluttertoast.showToast(
          msg: AppLocalizations.of(context)!.trans("choose_user_is_required")!);
      return false;
    }
    return true;
  }

  createLinkRequestBloc(BuildContext context) {
    if (_checkIsValid(context)) {
      ProgressDialog progressDialog = GeneralWidget.progressDialog(context);
      progressDialog.show().then((value) {
        ApiUsers(context).sendLinkRequest(userId).then((value) {
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
