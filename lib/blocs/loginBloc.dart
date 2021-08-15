import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:agriunions_logistics/Localization/AppLocal.dart';
import 'package:agriunions_logistics/models/auth_user_model.dart';
import 'package:agriunions_logistics/models/user_model.dart';
import 'package:agriunions_logistics/providers/api_login.dart';
import 'package:agriunions_logistics/helper/data_store.dart';
import 'package:agriunions_logistics/user_interfaces/pages/splash.dart';
import 'package:agriunions_logistics/user_interfaces/widget/general_widget.dart';
import 'package:agriunions_logistics/user_interfaces/widget/progress_dialog.dart';

class LoginBloc {
  String? username;
  String? password;

  bool _checkIsValid(BuildContext context) {
    if ((username ?? "").isEmpty || (password ?? "").isEmpty) {
      Fluttertoast.showToast(
          msg: AppLocalizations.of(context)!.trans("please_fill_all")!);
      return false;
    }
    return true;
  }

  login(context) {
    if (_checkIsValid(context)) {
      ProgressDialog progressDialog = GeneralWidget.progressDialog(context);
      progressDialog.show().then((value) {
        ApiLogin(context).login(username, password).then((res) {
          progressDialog.hide();
          if (res != null) {
            dataStore
                .setAuthUser(AuthUserModel(
                        token: res.token, user: UserModel.fromMap(res.data))
                    .toJson())
                .then((isSet) {
              if (isSet) {
                dataStore.getAuthUser().then((_) {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Splash(),
                      ));
                });
              }
            });
          }
        });
      });
    }
  }
}
