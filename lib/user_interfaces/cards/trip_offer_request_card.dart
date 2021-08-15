import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:agriunions_logistics/Localization/AppLocal.dart';
import 'package:agriunions_logistics/helper/AppColors.dart';
import 'package:agriunions_logistics/models/trip_offer_request_model.dart';

class TripOfferRequestCard extends StatefulWidget {
  final TripOfferRequestModel _model;

  const TripOfferRequestCard(this._model);

  @override
  _TripOfferRequestCardState createState() => _TripOfferRequestCardState();
}

class _TripOfferRequestCardState extends State<TripOfferRequestCard> {
  bool isShow = false;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            boxShadow: kElevationToShadow[1],
            color: Colors.white,
          ),
          child: Padding(
            padding:
                const EdgeInsets.only(top: 10, left: 10, right: 10, bottom: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text(
                        AppLocalizations.of(context)!.trans("number")! +
                            ":${widget._model.number}",
                        style: TextStyle(color: AppColors.Russet),
                      ),
                    ),
                    Row(
                      children: [
                        Icon(
                          widget._model.tripOfferRequestStatus == 'Pending'
                              ? Icons.access_time
                              : Icons.check_circle_outline,
                          size: 20,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 2.0),
                          child: Text(
                            AppLocalizations.of(context)!
                                .trans(widget._model.tripOfferRequestStatus)!,
                            style: TextStyle(
                                fontSize: 10, color: AppColors.Russet),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Container(
                  width: 200,
                  child: Divider(
                    color: AppColors.Russet1,
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    boxShadow: kElevationToShadow[1],
                    color: Colors.white,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 30.0, right: 30.0, top: 8.0, bottom: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Row(
                          children: [
                            Text(
                              AppLocalizations.of(context)!
                                  .trans("departure_title")!,
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        Text(
                          widget._model.departureName!,
                          style: TextStyle(fontWeight: FontWeight.w200),
                        )
                      ],
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 8),
                  decoration: BoxDecoration(
                    // border: Border.all(color: AppColors.Russet),
                    borderRadius: BorderRadius.circular(25),
                    boxShadow: kElevationToShadow[1],
                    color: Colors.white,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 30.0, right: 30.0, top: 8.0, bottom: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Row(
                          children: [
                            Text(
                              AppLocalizations.of(context)!
                                  .trans("destination_title")!,
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        Text(
                          widget._model.destinationName!,
                          style: TextStyle(fontWeight: FontWeight.w100),
                        )
                      ],
                    ),
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
                  child: Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                            boxShadow: kElevationToShadow[1],
                            color: Colors.white,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(
                                left: 30.0, right: 30.0, top: 8.0, bottom: 8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Row(
                                  children: [
                                    Text(
                                      AppLocalizations.of(context)!
                                          .trans("departure_city")!,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                                Text(
                                  widget._model.departureCityName!,
                                  style: TextStyle(fontWeight: FontWeight.w200),
                                )
                              ],
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 8),
                          decoration: BoxDecoration(
                            // border: Border.all(color: AppColors.Russet),
                            borderRadius: BorderRadius.circular(25),
                            boxShadow: kElevationToShadow[1],
                            color: Colors.white,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(
                                left: 30.0, right: 30.0, top: 8.0, bottom: 8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Row(
                                  children: [
                                    Text(
                                      AppLocalizations.of(context)!
                                          .trans("destination_city")!,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                                Text(
                                  widget._model.destinationCityName!,
                                  style: TextStyle(fontWeight: FontWeight.w100),
                                )
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
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
                                      widget._model.vehicleName!,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                                VerticalDivider(
                                  width: 2,
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
                                        widget._model.vehicleClassificationName!,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                        textAlign: TextAlign.center),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Container(
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
                                widget._model.branchName!,
                                style: TextStyle(fontWeight: FontWeight.bold),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
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
                )
              ],
            ),
          ),
        ),
      ),
      onTap: () {
        isShow = !isShow;
        setState(() {});
      },
    );
  }
}
