import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:agriunions_logistics/Localization/AppLocal.dart';
import 'package:agriunions_logistics/providers/api_users.dart';
import 'package:agriunions_logistics/user_interfaces/widget/general_widget.dart';
import 'package:agriunions_logistics/user_interfaces/widget/progress_dialog.dart';

class ProcessLinkRequestBloc {
  processLinkRequestBloc(
      BuildContext context, String? userId, String status, onTapSuccess) {
    ProgressDialog progressDialog = GeneralWidget.progressDialog(context);
    progressDialog.show().then((value) {
      ApiUsers(context).processLinkRequest(userId, status).then((value) {
        progressDialog.hide();
        if (value != null) {
          Fluttertoast.showToast(
              msg: AppLocalizations.of(context)!.trans("success")!);
          onTapSuccess();
        }
      });
    });
  }
}
