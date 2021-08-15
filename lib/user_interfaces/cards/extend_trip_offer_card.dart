import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:agriunions_logistics/Localization/AppLocal.dart';
import 'package:agriunions_logistics/helper/AppColors.dart';
import 'package:agriunions_logistics/helper/app_permissions.dart';

import 'package:agriunions_logistics/models/trip_offer_model.dart';

class ExtendTripOfferCard extends StatefulWidget {
  final TripOfferModel? _model;
  const ExtendTripOfferCard(this._model);

  @override
  _ExtendTripOfferCardState createState() => _ExtendTripOfferCardState();
}

class _ExtendTripOfferCardState extends State<ExtendTripOfferCard> {
  bool isShow = false;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        isShow = !isShow;
        setState(() {});
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            boxShadow: kElevationToShadow[1],
            color: Colors.grey[100],
          ),
          child: Padding(
            padding:
                const EdgeInsets.only(top: 10, left: 10, right: 10, bottom: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  AppLocalizations.of(context)!.trans("trip_info")!,
                  style: TextStyle(
                    color: AppColors.Russet,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Divider(indent: 50, endIndent: 50, color: AppColors.Russet1),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        AppLocalizations.of(context)!.trans("the_price")!,
                        style: TextStyle(color: AppColors.darkGray),
                      ),
                      Text(
                        widget._model!.price! ,
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
                      Text(
                        AppLocalizations.of(context)!.trans("departure_title")!,
                        style: TextStyle(color: AppColors.darkGray),
                      ),
                      Text(
                        widget._model!.departureName!,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                ),
                Visibility(
                  visible: (widget._model!.destinationName ?? '').isNotEmpty,
                  child: Column(
                    children: [
                      Divider(),
                      Padding(
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
                              widget._model!.destinationName!,
                              style: TextStyle(fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Visibility(
                  visible: !isShow,
                  child: Container(
                    margin: EdgeInsets.only(top: 8),
                    decoration: BoxDecoration(
                      // border: Border.all(color: AppColors.Russet),
                      borderRadius: BorderRadius.circular(25),
                      boxShadow: kElevationToShadow[1],
                      color: Colors.white,
                    ),
                    child: Icon(Icons.arrow_drop_down),
                  ),
                ),
                Visibility(
                  visible: isShow,
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
                                  AppLocalizations.of(context)!
                                      .trans("departure_city")!,
                                  style: TextStyle(color: AppColors.darkGray),
                                ),
                              ],
                            ),
                            Text(
                              widget._model!.departureCityName!,
                              style: TextStyle(fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                      ),
                      Visibility(
                        visible:
                            (widget._model!.destinationName ?? '').isNotEmpty,
                        child: Column(
                          children: [
                            Divider(),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text(
                                    AppLocalizations.of(context)!
                                        .trans("destination_city")!,
                                    style: TextStyle(color: AppColors.darkGray),
                                  ),
                                  Text(
                                    widget._model!.destinationCityName!,
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Visibility(
                        visible: AppPermissions.isLogged() &&
                            ((widget._model!.numberOfRequests ?? "")
                                    .isNotEmpty ||
                                (widget._model!.numberOfYourRequests ?? "")
                                    .isNotEmpty),
                        child: Column(
                          children: [
                            Divider(),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Row(
                                    children: [
                                      Text(
                                        AppLocalizations.of(context)!.trans(
                                            AppPermissions.isServiceProvider()
                                                ? "number_of_requests"
                                                : "number_of_your_requests")!,
                                        style: TextStyle(
                                            color: AppColors.darkGray),
                                      ),
                                    ],
                                  ),
                                  Text(
                                    AppPermissions.isServiceProvider()
                                        ? widget._model!.numberOfRequests ?? ""
                                        : widget._model!.numberOfYourRequests ??
                                            "",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Visibility(
                        visible: (widget._model!.vehicleName ?? '').isNotEmpty,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: IntrinsicHeight(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width / 2.8,
                                  margin: EdgeInsets.only(top: 8),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(25),
                                    boxShadow: kElevationToShadow[1],
                                    color: Colors.white,
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      widget._model!.vehicleName!,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
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
                                  width:
                                      MediaQuery.of(context).size.width / 2.8,
                                  margin: EdgeInsets.only(top: 8),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(25),
                                    boxShadow: kElevationToShadow[1],
                                    color: Colors.white,
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                        widget._model!.vehicleClassificationName!,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                        textAlign: TextAlign.center),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Container(
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
                                    AppLocalizations.of(context)!
                                        .trans("branch")!,
                                    style: TextStyle(color: AppColors.darkGray),
                                  ),
                                ],
                              ),
                              Text(
                                widget._model!.branchName!,
                                style: TextStyle(fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Visibility(
                  visible: isShow,
                  child: Container(
                    margin: EdgeInsets.only(top: 8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      boxShadow: kElevationToShadow[1],
                      color: Colors.white,
                    ),
                    child: Icon(Icons.arrow_drop_up),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
