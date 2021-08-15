import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:agriunions_logistics/Localization/AppLocal.dart';
import 'package:agriunions_logistics/providers/api_register.dart';
import 'package:agriunions_logistics/user_interfaces/pages/home_page_drawer/login_page.dart';
import 'package:agriunions_logistics/user_interfaces/widget/general_widget.dart';
import 'package:agriunions_logistics/user_interfaces/widget/progress_dialog.dart';

class RegisterBloc {
  String? username;
  String? password;
  String? confirmPassword;
  String? phoneNumber;
  String? email;

  bool _checkIsValid(BuildContext context) {
    if ((username ?? "").isEmpty ||
        (password ?? "").isEmpty ||
        (confirmPassword ?? "").isEmpty ||
        (phoneNumber ?? "").isEmpty ||
        (email ?? "").isEmpty) {
      Fluttertoast.showToast(
          msg: AppLocalizations.of(context)!.trans("please_fill_all")!);
      return false;
    }
    if (password != confirmPassword) {
      Fluttertoast.showToast(
          msg: AppLocalizations.of(context)!.trans("passwords_do_not_match")!);
      return false;
    }
    return true;
  }

  register(context) {
    if (_checkIsValid(context)) {
      ProgressDialog progressDialog = GeneralWidget.progressDialog(context);
      progressDialog.show().then((value) {
        ApiRegister(context)
            .register(username, password, confirmPassword, phoneNumber, email)
            .then((res) {
          progressDialog.hide();
          if (res != null) {
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (context) => LoginPage()));
          }
        });
      });
    }
  }
}
