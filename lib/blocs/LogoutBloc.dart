import 'package:flutter/material.dart';
import 'package:agriunions_logistics/providers/api_logout.dart';
import 'package:agriunions_logistics/user_interfaces/pages/splash.dart';
import 'package:agriunions_logistics/helper/data_store.dart';
import 'package:agriunions_logistics/user_interfaces/widget/general_widget.dart';
import 'package:agriunions_logistics/user_interfaces/widget/progress_dialog.dart';

class LogoutBloc {
  static logout(context) {
    ProgressDialog progressDialog = GeneralWidget.progressDialog(context);
    progressDialog.show().then((value) {
      ApiLogout(context).logout().then((res) {
        progressDialog.hide();
        if (res != null) {
          dataStore.freeUser().then((_) => Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => Splash())));
        }
      });
    });
  }
}
