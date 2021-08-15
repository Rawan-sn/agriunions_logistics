import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:agriunions_logistics/Localization/AppLocal.dart';

class ChangePasswordBloc {
  String? oldPassword;
  String? newPassword;
  String? confirmPassword;

  bool _checkIsValid(BuildContext context) {
    if ((oldPassword ?? "").isEmpty ||
        (newPassword ?? "").isEmpty ||
        (confirmPassword ?? "").isEmpty) {
      Fluttertoast.showToast(
          msg: AppLocalizations.of(context)!.trans("please_fill_all")!);
      return false;
    }
    if (newPassword != confirmPassword) {
      Fluttertoast.showToast(
          msg: AppLocalizations.of(context)!.trans("passwords_do_not_match")!);
      return false;
    }
    return true;
  }

  changePassword(context) {
    if (_checkIsValid(context)) {}
  }
}
