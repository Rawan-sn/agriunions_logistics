import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:agriunions_logistics/Localization/AppLocal.dart';
import 'package:agriunions_logistics/helper/AppColors.dart';
import 'package:agriunions_logistics/helper/app_permissions.dart';
import 'package:agriunions_logistics/helper/general_func.dart';

import 'package:agriunions_logistics/models/trip_offer_model.dart';
import 'package:agriunions_logistics/user_interfaces/pages/add_edit_trip_page.dart';

class TripOfferCard1 extends StatelessWidget {
  final bool allowEdit;
  final TripOfferModel _model;
  const TripOfferCard1(this._model, {this.allowEdit = false});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          boxShadow: kElevationToShadow[1],
          color: Colors.white,
        ),
        child: Stack(
          children: [
            Center(
              child: Image.asset(
                'assets/images/trip_card_bc.png',
                height: 200,
                width: MediaQuery.of(context).size.width,
              ),
            ),
            Center(
              child: Container(
                height: 200,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.93),
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  top: 10, left: 10, right: 10, bottom: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        AppLocalizations.of(context)!.trans("trip_number")! +
                            ":${_model.number}",
                        style: TextStyle(color: AppColors.Russet),
                      ),
                      Text(
                        GeneralFanc.dateformatedWithDay(_model.today),
                        style: TextStyle(color: AppColors.Russet),
                      ),
                    ],
                  ),
                  Divider(indent: 50, endIndent: 50, color: AppColors.Russet1),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Row(
                          children: [
                            Text(
                              AppLocalizations.of(context)!.trans("the_price")!,
                              style: TextStyle(color: AppColors.darkGray),
                            ),
                          ],
                        ),
                        Text(
                          _model.price! ,
                          style: TextStyle(fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                  ),
                  Divider(),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Row(
                          children: [
                            Text(
                              AppLocalizations.of(context)!
                                  .trans("departure_title")!,
                              style: TextStyle(color: AppColors.darkGray),
                            ),
                          ],
                        ),
                        Text(
                          _model.departureName!,
                          style: TextStyle(fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                  ),
                  Visibility(
                    visible: (_model.destinationName ?? '').isNotEmpty,
                    child: Divider(),
                  ),
                  Visibility(
                    visible: (_model.destinationName ?? '').isNotEmpty,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            AppLocalizations.of(context)!
                                .trans("destination_title")!,
                            style: TextStyle(color: AppColors.darkGray),
                          ),
                          Text(
                            _model.destinationName!,
                            style: TextStyle(fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                    ),
                  ),
                  Visibility(
                    visible: AppPermissions.isLogged() &&
                        ((_model.numberOfRequests ?? "").isNotEmpty ||
                            (_model.numberOfYourRequests ?? "").isNotEmpty),
                    child: Column(
                      children: [
                        Divider(),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Row(
                                children: [
                                  Text(
                                    AppLocalizations.of(context)!.trans(
                                        AppPermissions.isServiceProvider()
                                            ? "number_of_requests"
                                            : "number_of_your_requests")!,
                                    style: TextStyle(color: AppColors.darkGray),
                                  ),
                                ],
                              ),
                              Text(
                                AppPermissions.isServiceProvider()
                                    ? _model.numberOfRequests ?? ""
                                    : _model.numberOfYourRequests ?? "",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Visibility(
                    visible: (_model.vehicleName ?? '').isEmpty,
                    child: Container(
                      width: MediaQuery.of(context).size.width / 1.5,
                      margin: EdgeInsets.only(top: 8),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        boxShadow: kElevationToShadow[1],
                        color: Colors.white,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Row(
                              children: [
                                Text(
                                  AppLocalizations.of(context)!.trans("branch")!,
                                  style: TextStyle(color: AppColors.darkGray),
                                ),
                              ],
                            ),
                            Text(
                              _model.branchName!,
                              style: TextStyle(fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                      ),
                    ),
                    replacement: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: IntrinsicHeight(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width / 2.8,
                              margin: EdgeInsets.only(top: 8),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(25),
                                boxShadow: kElevationToShadow[1],
                                color: Colors.white,
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  _model.vehicleName!,
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                            VerticalDivider(
                              width: 10,
                              indent: 10,
                              endIndent: 5,
                              color: AppColors.Russet1,
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width / 2.8,
                              margin: EdgeInsets.only(top: 8),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(25),
                                boxShadow: kElevationToShadow[1],
                                color: Colors.white,
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(_model.branchName!,
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                    textAlign: TextAlign.center),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Visibility(
                    visible: allowEdit,
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => AddEditTripPage(
                                      model: _model,
                                    )));
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width / 3,
                        margin: EdgeInsets.only(top: 8),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          boxShadow: kElevationToShadow[1],
                          color: Colors.white,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 30.0, right: 30.0, top: 8.0, bottom: 8.0),
                          child:
                              Text(AppLocalizations.of(context)!.trans("edit")!),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
/*
 Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          boxShadow: kElevationToShadow[1],
          color: Colors.white,
        ),
        child: Stack(
          children: [
            Center(
              child: Image.asset(
                'assets/images/trip_card_bc.png',
                height: 200,
                width: MediaQuery.of(context).size.width,
              ),
            ),
            Center(
              child: Container(
                height: 200,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.93),
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  top: 10, left: 10, right: 10, bottom: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        AppLocalizations.of(context)!.trans("trip_number")! +
                            ":${_model.number}",
                        style: TextStyle(color: AppColors.Russet),
                      ),
                      Text(
                        GeneralFanc.dateformatedWithDay(_model.today),
                        style: TextStyle(color: AppColors.Russet),
                      ),
                    ],
                  ),
                  Divider(indent: 50, endIndent: 50, color: AppColors.Russet1),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Row(
                          children: [
                            Text(
                              AppLocalizations.of(context)!.trans("the_price")!,
                              style: TextStyle(color: AppColors.darkGray),
                            ),
                          ],
                        ),
                        Text(
                          _model.price! ,
                          style: TextStyle(fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                  ),
                  Divider(),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Row(
                          children: [
                            Text(
                              AppLocalizations.of(context)!
                                  .trans("departure_title")!,
                              style: TextStyle(color: AppColors.darkGray),
                            ),
                          ],
                        ),
                        Text(
                          _model.departureName!,
                          style: TextStyle(fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                  ),
                  Visibility(
                    visible: (_model.destinationName ?? '').isNotEmpty,
                    child: Divider(),
                  ),
                  Visibility(
                    visible: (_model.destinationName ?? '').isNotEmpty,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            AppLocalizations.of(context)!
                                .trans("destination_title")!,
                            style: TextStyle(color: AppColors.darkGray),
                          ),
                          Text(
                            _model.destinationName!,
                            style: TextStyle(fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                    ),
                  ),
                  Visibility(
                    visible: AppPermissions.isLogged() &&
                        ((_model.numberOfRequests ?? "").isNotEmpty ||
                            (_model.numberOfYourRequests ?? "").isNotEmpty),
                    child: Column(
                      children: [
                        Divider(),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Row(
                                children: [
                                  Text(
                                    AppLocalizations.of(context)!.trans(
                                        AppPermissions.isServiceProvider()
                                            ? "number_of_requests"
                                            : "number_of_your_requests")!,
                                    style: TextStyle(color: AppColors.darkGray),
                                  ),
                                ],
                              ),
                              Text(
                                AppPermissions.isServiceProvider()
                                    ? _model.numberOfRequests ?? ""
                                    : _model.numberOfYourRequests ?? "",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Visibility(
                    visible: (_model.vehicleName ?? '').isEmpty,
                    child: Container(
                      width: MediaQuery.of(context).size.width / 1.5,
                      margin: EdgeInsets.only(top: 8),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        boxShadow: kElevationToShadow[1],
                        color: Colors.white,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Row(
                              children: [
                                Text(
                                  AppLocalizations.of(context)!.trans("branch")!,
                                  style: TextStyle(color: AppColors.darkGray),
                                ),
                              ],
                            ),
                            Text(
                              _model.branchName!,
                              style: TextStyle(fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                      ),
                    ),
                    replacement: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: IntrinsicHeight(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width / 2.8,
                              margin: EdgeInsets.only(top: 8),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(25),
                                boxShadow: kElevationToShadow[1],
                                color: Colors.white,
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  _model.vehicleName!,
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                            VerticalDivider(
                              width: 10,
                              indent: 10,
                              endIndent: 5,
                              color: AppColors.Russet1,
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width / 2.8,
                              margin: EdgeInsets.only(top: 8),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(25),
                                boxShadow: kElevationToShadow[1],
                                color: Colors.white,
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(_model.branchName!,
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                    textAlign: TextAlign.center),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Visibility(
                    visible: allowEdit,
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => AddEditTripPage(
                                      model: _model,
                                    )));
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width / 3,
                        margin: EdgeInsets.only(top: 8),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          boxShadow: kElevationToShadow[1],
                          color: Colors.white,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 30.0, right: 30.0, top: 8.0, bottom: 8.0),
                          child:
                              Text(AppLocalizations.of(context)!.trans("edit")!),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
 */