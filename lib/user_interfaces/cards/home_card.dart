import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:agriunions_logistics/Localization/AppLocal.dart';
import 'package:agriunions_logistics/helper/general_func.dart';
import 'package:agriunions_logistics/models/trip_offer_model.dart';

class TripOfferCard extends StatelessWidget {
  final bool allowEdit;
  final TripOfferModel _model;

  const TripOfferCard(this._model, {this.allowEdit = false});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topCenter,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(
            top: 60 / 2.0,
          ),
          child: Container(
            height: 232.0,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15.0),
              color: Colors.grey.shade200,
              boxShadow: [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 8.0,
                  offset: Offset(0.0, 5.0),
                ),
              ],
            ),
            width: double.infinity,
            child: Padding(
                padding: const EdgeInsets.only(bottom: 15.0),
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      height: 100 / 2,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            AppLocalizations.of(context)!
                                    .trans("trip_number")! +
                                ":${_model.number}",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 22.0),
                          ),
                          Text(
                            GeneralFanc.dateformatedWithDay(_model.today),
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16.0,
                                color: Colors.amber),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 5.0,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10.0, right: 10),
                      child: Container(
                        height: 140,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15.0),
                          color: Colors.grey.shade100,
                          boxShadow: kElevationToShadow[1],
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Row(
                              children: [
                                Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        height: 30,
                                      ),
                                      Row(
                                        children: [
                                          Icon(
                                            Icons.monetization_on_outlined,
                                            size: 15,
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 4.0, right: 4),
                                            child: Text(
                                              AppLocalizations.of(context)!
                                                  .trans("price")!,
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 15.0,
                                                  color: Colors.brown),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 25.0),
                                        child: Text(
                                          _model.price!,
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 10.0),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      Row(
                                        children: [
                                          Icon(Icons.check_circle_outline,
                                              size: 15),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 4.0, right: 4),
                                            child: Text(
                                              'request:',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 15.0,
                                                  color: Colors.brown),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 25.0),
                                        child: Text(
                                          '5',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 10.0),
                                        ),
                                      ),
                                    ])
                              ],
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        AppLocalizations.of(context)!
                                            .trans("departure_title")!,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 15.0),
                                      ),
                                      Text(
                                        _model.departureName!,
                                        style: TextStyle(
                                            fontSize: 14.0,
                                            color: Colors.black54),
                                      ),
                                    ],
                                  ),
                                  Container(
                                    width: 150,
                                    child: Divider(
                                      color: Colors.amberAccent.shade100,
                                      thickness: 1.0,
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        AppLocalizations.of(context)!
                                            .trans("destination_title")!,
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15.0,
                                        ),
                                      ),
                                      Text(
                                        _model.destinationName!,
                                        style: TextStyle(
                                            fontSize: 14.0,
                                            color: Colors.black54),
                                      ),
                                    ],
                                  ),
                                  Container(
                                    width: 150,
                                    child: Divider(
                                      color: Colors.amberAccent.shade100,
                                      thickness: 1.0,
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        AppLocalizations.of(context)!
                                            .trans("branch")!,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 15.0),
                                      ),
                                      Text(
                                        _model.branchName!,
                                        style: TextStyle(
                                            fontSize: 14.0,
                                            color: Colors.black54),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                )),
          ),
        ),
        Container(
          width: 70,
          height: 70,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.grey.shade100,
            boxShadow: [
              BoxShadow(
                color: Colors.amber.shade200,
                blurRadius: 4.0,
                offset: Offset(0, 1),
              ),
            ],
          ),
          child: Padding(
            padding: EdgeInsets.all(4.0),
            child: Center(
              child: Container(
                child: Image.asset(
                  "assets/images/truck.png",
                  scale: 1.2,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
