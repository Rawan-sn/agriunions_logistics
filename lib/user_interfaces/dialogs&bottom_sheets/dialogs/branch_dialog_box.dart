import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:agriunions_logistics/Localization/AppLocal.dart';
import 'package:agriunions_logistics/blocs/create_edit_branch_bloc.dart';
import 'package:agriunions_logistics/helper/AppColors.dart';
import 'package:agriunions_logistics/helper/TextSizes.dart';
import 'package:agriunions_logistics/helper/data_store.dart';
import 'package:agriunions_logistics/models/branch_model.dart';
import 'package:agriunions_logistics/models/country_model.dart';

class BranchDialogBox extends StatefulWidget {
  final BranchesModel? model;

  const BranchDialogBox({this.model});

  @override
  _BranchDialogBoxState createState() => _BranchDialogBoxState();
}

class _BranchDialogBoxState extends State<BranchDialogBox> {
  CreateEditBranchBloc branchBloc = CreateEditBranchBloc();
  CountryModel? country;
  TextEditingController? controllerLatinName;
  TextEditingController? controllerLocalName;

  @override
  void initState() {
    super.initState();
    branchBloc.model.countryId=dataStore.country!.id;
    if (widget.model != null) {
      branchBloc.model.latinName = widget.model!.latinName;
      branchBloc.model.localName = widget.model!.localName;
      branchBloc.model.countryId = widget.model!.countryId;
      controllerLatinName = TextEditingController(text: widget.model!.latinName);
      controllerLocalName = TextEditingController(text: widget.model!.localName);
    } else {
      controllerLatinName = TextEditingController();
      controllerLocalName = TextEditingController();
    }
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
                    (widget.model != null)
                        ? AppLocalizations.of(context)!.trans("update_branch")!
                        : AppLocalizations.of(context)!.trans("new_branch")!,
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
                            AppLocalizations.of(context)!
                                .trans("branch_local_name")!,
                            style: TextStyle(fontWeight: FontWeight.bold),
                          )),
                      TextFormField(
                        controller: controllerLocalName,
                        cursorColor: Colors.black,
                        onChanged: (text) {
                          branchBloc.model.localName = text;
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
                                    .trans("branch_latin_name")!,
                                style: TextStyle(fontWeight: FontWeight.bold))),
                        TextFormField(
                          controller: controllerLatinName,
                          cursorColor: Colors.black,
                          onChanged: (text) {
                            branchBloc.model.latinName = text;
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
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: InkWell(
                    onTap: () {
                      if (widget.model != null) {
                        branchBloc.editBranch(context, widget.model!.id);
                      } else
                        branchBloc.createBranch(context);
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
