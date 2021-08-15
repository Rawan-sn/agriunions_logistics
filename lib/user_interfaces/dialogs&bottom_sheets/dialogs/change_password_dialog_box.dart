import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:agriunions_logistics/Localization/AppLocal.dart';
import 'package:agriunions_logistics/blocs/change_password_bloc.dart';
import 'package:agriunions_logistics/helper/AppColors.dart';
import 'package:agriunions_logistics/helper/TextSizes.dart';
import 'package:agriunions_logistics/helper/data_store.dart';

class ChangePasswordDialogBox extends StatefulWidget {
  @override
  _ChangePasswordDialogBoxState createState() =>
      _ChangePasswordDialogBoxState();
}

class _ChangePasswordDialogBoxState extends State<ChangePasswordDialogBox> {
  TextEditingController? controllerOldPassword;
  TextEditingController? controllerNewPassword;
  TextEditingController? controllerConfirmPassword;
  ChangePasswordBloc changePasswordBloc=new ChangePasswordBloc();
  bool canUpdate = false;

  @override
  void initState() {
    super.initState();
    controllerOldPassword = TextEditingController();
    controllerNewPassword = TextEditingController();
    controllerConfirmPassword = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
          side: BorderSide(color: AppColors.Russet1)),
      elevation: 0,
      child: contentBox(context),
    );
  }

  contentBox(context) {
    return Stack(
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(right: 10, left: 10, bottom: 8),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Text(
                    AppLocalizations.of(context)!.trans("change_password")!,
                    style: TextStyle(
                        color: AppColors.Russet1,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Divider(
                  color: AppColors.Russet1,
                  thickness: 2,
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: kElevationToShadow[1],
                    color: Colors.white,
                  ),
                  padding: EdgeInsets.only(left: 8.0, right: 8.0, top: 8.0),
                  child: Column(
                    children: [
                      Align(
                          alignment: dataStore.lang == 'ar'
                              ? Alignment.topRight
                              : Alignment.topLeft,
                          child: Text(
                            AppLocalizations.of(context)!.trans("old_password")!,
                            style: TextStyle(fontWeight: FontWeight.bold),
                          )),
                      TextFormField(
                        controller: controllerOldPassword,
                        keyboardType:  TextInputType.visiblePassword,
                        cursorColor: Colors.black,
                        onChanged: (text) {
                          changePasswordBloc.oldPassword=text;
                        },
                        obscureText: true,
                        decoration: new InputDecoration(
                            border: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            errorBorder: InputBorder.none,
                            disabledBorder: InputBorder.none,
                            hintText: AppLocalizations.of(context)!
                                .trans("old_password"),
                            hintStyle: TextStyle(fontSize: 15)),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0, bottom: 8),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: kElevationToShadow[1],
                      color: Colors.white,
                    ),
                    padding: EdgeInsets.only(left: 8.0, right: 8.0, top: 8.0),
                    child: Column(
                      children: [
                        Align(
                            alignment: dataStore.lang == 'ar'
                                ? Alignment.topRight
                                : Alignment.topLeft,
                            child: Text(
                                AppLocalizations.of(context)!
                                    .trans("new_password")!,
                                style: TextStyle(fontWeight: FontWeight.bold))),
                        TextFormField(
                          controller: controllerNewPassword,
                          cursorColor: Colors.black,
                          onChanged: (text) {
                            changePasswordBloc.newPassword=text;
                          },
                          obscureText: true,
                          decoration: new InputDecoration(
                              border: InputBorder.none,
                              focusedBorder: InputBorder.none,
                              enabledBorder: InputBorder.none,
                              errorBorder: InputBorder.none,
                              disabledBorder: InputBorder.none,
                              hintText: AppLocalizations.of(context)!
                                  .trans("new_password"),
                              hintStyle: TextStyle(fontSize: 15)),
                        )
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0, bottom: 8),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: kElevationToShadow[1],
                      color: Colors.white,
                    ),
                    padding: EdgeInsets.only(left: 8.0, right: 8.0, top: 8.0),
                    child: Column(
                      children: [
                        Align(
                            alignment: dataStore.lang == 'ar'
                                ? Alignment.topRight
                                : Alignment.topLeft,
                            child: Text(
                                AppLocalizations.of(context)!
                                    .trans("confirm_password")!,
                                style: TextStyle(fontWeight: FontWeight.bold))),
                        TextFormField(
                          controller: controllerConfirmPassword,
                          cursorColor: Colors.black,
                          onChanged: (text) {
                            changePasswordBloc.confirmPassword=text;
                          },
                          obscureText: true,
                          decoration: new InputDecoration(
                              border: InputBorder.none,
                              focusedBorder: InputBorder.none,
                              enabledBorder: InputBorder.none,
                              errorBorder: InputBorder.none,
                              disabledBorder: InputBorder.none,
                              hintText: AppLocalizations.of(context)!
                                  .trans("confirm_password"),
                              hintStyle: TextStyle(fontSize: 15)),
                        )
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: InkWell(
                    onTap: () {
                      FocusScope.of(context).unfocus();
                      changePasswordBloc.changePassword(context);
                    },
                    child: Container(
                      width: double.infinity,
                      margin: EdgeInsets.only(top: 6),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.white, width: 1.5),
                        gradient: LinearGradient(
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter,
                            colors: [AppColors.Russet1, AppColors.Russet]),
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(10),
                        child: Text(
                          AppLocalizations.of(context)!.trans("send")!,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: TextSizes.smallText,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
