import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:agriunions_logistics/Localization/AppLocal.dart';
import 'package:agriunions_logistics/providers/api_users.dart';
import 'package:agriunions_logistics/user_interfaces/widget/general_widget.dart';
import 'package:agriunions_logistics/user_interfaces/widget/progress_dialog.dart';

class UnlinkUserBloc {
  unlinkUserBloc(BuildContext context, String? userId, onTapSuccess) {
    ProgressDialog progressDialog = GeneralWidget.progressDialog(context);
    progressDialog.show().then((value) {
      ApiUsers(context).unlinkUser(userId: userId).then((value) {
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
