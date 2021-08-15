import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:agriunions_logistics/Localization/AppLocal.dart';
import 'package:agriunions_logistics/blocs/create_edit_vehicle_bloc.dart';
import 'package:agriunions_logistics/blocs/vehicleClassifications_bloc.dart';
import 'package:agriunions_logistics/helper/AppColors.dart';
import 'package:agriunions_logistics/helper/TextSizes.dart';
import 'package:agriunions_logistics/helper/data_store.dart';
import 'package:agriunions_logistics/helper/enums.dart';
import 'package:agriunions_logistics/models/branch_model.dart';
import 'package:agriunions_logistics/models/classification_model.dart';
import 'package:agriunions_logistics/models/user_model.dart';
import 'package:agriunions_logistics/models/vehicle_model.dart';
import 'package:agriunions_logistics/user_interfaces/dialogs&bottom_sheets/show_bottom_sheets.dart';
import 'package:agriunions_logistics/user_interfaces/pages/general/add_media_page.dart';

class VehicleDialogBox extends StatefulWidget {
  const VehicleDialogBox({this.model});

  final VehicleModel? model;

  @override
  _CustomDialogBoxState createState() => _CustomDialogBoxState();
}

class _CustomDialogBoxState extends State<VehicleDialogBox> {
  BranchesModel? branchesModel;
  ClassificationModel? classificationModel;
  UserModel? userModel;
  VehicleClassificationBloc _classificationBloc = VehicleClassificationBloc();
  CreateEditVehicleBloc _bloc = CreateEditVehicleBloc();
  TextEditingController? controllerLatinName;
  TextEditingController? controllerLocalName;
  AddMediaPage? addMediaPage;

  @override
  void initState() {
    super.initState();
    if (widget.model != null) {
      addMediaPage = AddMediaPage(
        attachments: widget.model!.attachments,
      );
      branchesModel = BranchesModel(
          id: widget.model!.branch!.id, branchName: widget.model!.branch!.name);
      classificationModel = ClassificationModel(
          id: widget.model!.classification!.id,
          name: widget.model!.classification!.name);
      userModel =
          UserModel(id: widget.model!.user!.id, name: widget.model!.user!.userName);
      //  _bloc.model.attachments
      _bloc.model.localName = widget.model!.localName;
      _bloc.model.latinName = widget.model!.latinName;
      _bloc.model.branchId = widget.model!.branch!.id;
      _bloc.model.classificationId = widget.model!.classification!.id;
      _bloc.model.userId = widget.model!.user!.id;
      controllerLatinName = TextEditingController(text: widget.model!.latinName);
      controllerLocalName = TextEditingController(text: widget.model!.localName);
    } else {
      addMediaPage = AddMediaPage();
      controllerLatinName = TextEditingController();
      controllerLocalName = TextEditingController();
    }
  }

  @override
  void dispose() {
    _classificationBloc.dispose();
    controllerLatinName!.dispose();
    controllerLocalName!.dispose();
    super.dispose();
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
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Text(
                    (widget.model != null)
                        ? AppLocalizations.of(context)!.trans("update_vehicle")!
                        : AppLocalizations.of(context)!.trans("new_vehicle")!,
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
                    ShowBottomSheets.selectUser(
                      context,
                      (user) {
                        if (user != null) {
                          setState(() {
                            userModel = user;
                            _bloc.model.userId = user.id;
                          });
                        }
                      },
                      userTypes: UserTypes.user,
                    );
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 6.0),
                    margin: EdgeInsets.symmetric(vertical: 8.0),
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
                            userModel?.name ??
                                AppLocalizations.of(context)!
                                    .trans("the_driver")!,
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        Icon(
                          Icons.keyboard_arrow_down_sharp,
                          color: AppColors.Russet,
                        ),
                      ],
                    ),
                  ),
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
                            AppLocalizations.of(context)!
                                .trans("vehicle_local_name")!,
                            style: TextStyle(fontWeight: FontWeight.bold),
                          )),
                      TextFormField(
                        controller: controllerLocalName,
                        cursorColor: Colors.black,
                        onChanged: (text) {
                          _bloc.model.localName = text;
                        },
                        decoration: new InputDecoration(
                            border: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            errorBorder: InputBorder.none,
                            disabledBorder: InputBorder.none,
                            hintText: AppLocalizations.of(context)!
                                .trans("local_name"),
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
                                    .trans("vehicle_latin_name")!,
                                style: TextStyle(fontWeight: FontWeight.bold))),
                        TextFormField(
                          controller: controllerLatinName,
                          cursorColor: Colors.black,
                          onChanged: (text) {
                            _bloc.model.latinName = text;
                          },
                          decoration: new InputDecoration(
                              border: InputBorder.none,
                              focusedBorder: InputBorder.none,
                              enabledBorder: InputBorder.none,
                              errorBorder: InputBorder.none,
                              disabledBorder: InputBorder.none,
                              hintText: AppLocalizations.of(context)!
                                  .trans("latin_name"),
                              hintStyle: TextStyle(fontSize: 15)),
                        )
                      ],
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    FocusScope.of(context).unfocus();

                    ShowBottomSheets.selectBranch(context, (selectedBranch) {
                      setState(() {
                        branchesModel = selectedBranch;
                        _bloc.model.branchId = selectedBranch.id;
                      });
                    });
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
                            branchesModel?.branchName ??
                                AppLocalizations.of(context)!.trans("branch")!,
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        Icon(
                          Icons.keyboard_arrow_down_sharp,
                          color: AppColors.Russet,
                        ),
                      ],
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    FocusScope.of(context).unfocus();
                    ShowBottomSheets.selectClassification(context,
                        (selectedClassification) {
                      setState(() {
                        classificationModel = selectedClassification;
                        _bloc.model.classificationId =
                            selectedClassification.id;
                      });
                    });
                  },
                  child: Container(
                    margin: EdgeInsets.only(top: 10),
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
                            classificationModel?.name ??
                                AppLocalizations.of(context)!
                                    .trans("classification")!,
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
                  padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
                  child: Text(
                    AppLocalizations.of(context)!.trans('upload_photos')!,
                    style: TextStyle(color: AppColors.darkRed),
                  ),
                ),
                Container(
                    height: MediaQuery.of(context).size.height / 8,
                    child: addMediaPage),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: InkWell(
                      onTap: () {
                        FocusScope.of(context).unfocus();
                        if (widget.model != null)
                          _bloc.editVehicle(
                              context, addMediaPage, widget.model!.id);
                        else
                          _bloc.createVehicle(context, addMediaPage);
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
                            (widget.model != null)
                                ? AppLocalizations.of(context)!.trans("update")!
                                : AppLocalizations.of(context)!.trans("create")!,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: TextSizes.smallText,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      )),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
