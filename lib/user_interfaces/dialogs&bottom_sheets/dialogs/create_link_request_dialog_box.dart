import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:agriunions_logistics/Localization/AppLocal.dart';
import 'package:agriunions_logistics/blocs/create_link_requests_bloc.dart';
import 'package:agriunions_logistics/helper/AppColors.dart';
import 'package:agriunions_logistics/helper/TextSizes.dart';
import 'package:agriunions_logistics/helper/enums.dart';
import 'package:agriunions_logistics/models/user_model.dart';
import 'package:agriunions_logistics/user_interfaces/dialogs&bottom_sheets/show_bottom_sheets.dart';

class CreateLinkRequestDialogBox extends StatefulWidget {
  const CreateLinkRequestDialogBox();

  @override
  _CreateLinkRequestDialogBoxState createState() =>
      _CreateLinkRequestDialogBoxState();
}

class _CreateLinkRequestDialogBoxState
    extends State<CreateLinkRequestDialogBox> {
  CreateLinkRequestBloc _bloc = CreateLinkRequestBloc();
  UserModel? model;

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
                    AppLocalizations.of(context)!.trans("new_request")!,
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
                InkWell(
                  onTap: () {
                    ShowBottomSheets.selectUser(context, (userModel) {
                      if (userModel != null) {
                        setState(() {
                          model = userModel;
                          _bloc.userId = userModel.id;
                        });
                      }
                    }, userTypes: UserTypes.service_provider);
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 6.0),
                    height: MediaQuery.of(context).size.height / 12,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: kElevationToShadow[1],
                      color: Colors.white,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                            model?.name ??
                                AppLocalizations.of(context)!.trans("username")!,
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        Icon(
                          Icons.keyboard_arrow_down_sharp,
                          color: AppColors.Russet,
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: InkWell(
                    onTap: () {
                      _bloc.createLinkRequestBloc(context);
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
                          AppLocalizations.of(context)!.trans("create")!,
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
