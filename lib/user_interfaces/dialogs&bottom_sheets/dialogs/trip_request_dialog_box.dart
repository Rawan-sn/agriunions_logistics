import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:agriunions_logistics/Localization/AppLocal.dart';
import 'package:agriunions_logistics/blocs/requests_trip_offer_bloc.dart';
import 'package:agriunions_logistics/helper/AppColors.dart';
import 'package:agriunions_logistics/helper/TextSizes.dart';
import 'package:agriunions_logistics/helper/app_constants.dart';
import 'package:agriunions_logistics/helper/data_store.dart';
import 'package:agriunions_logistics/models/trip_offer_model.dart';
import 'package:agriunions_logistics/user_interfaces/pages/general/add_media_page.dart';

class TripRequestDialogBox extends StatefulWidget {
  final TripOfferModel tripOffer;
  const TripRequestDialogBox(this.tripOffer);
  @override
  _TripRequestDialogBoxState createState() => _TripRequestDialogBoxState();
}

class _TripRequestDialogBoxState extends State<TripRequestDialogBox> {
  RequestsTripOffersBloc _bloc = RequestsTripOffersBloc();
  bool isPartialShipment = false;
  final weightControlle = TextEditingController();
  final countControlle = TextEditingController();
  AddMediaPage addMediaPage = AddMediaPage();

  @override
  void dispose() {
    weightControlle.dispose();
    countControlle.dispose();
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
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Text(
                    AppLocalizations.of(context)!.trans("request_trip")!,
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
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        AppLocalizations.of(context)!
                            .trans("is_partial_shipment")!,
                      ),
                    ),
                    Switch(
                      value: isPartialShipment,
                      onChanged: (value) {
                        setState(() {
                          isPartialShipment = value;
                        });
                      },
                    ),
                  ],
                ),
                Visibility(
                  visible: isPartialShipment,
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
                              AppLocalizations.of(context)!.trans("weight")!,
                              style: TextStyle(fontWeight: FontWeight.bold),
                            )),
                        TextField(
                          controller: weightControlle,
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(
                                RegExp("[0-9]+\.?[0-9]*"))
                          ],
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            floatingLabelBehavior: FloatingLabelBehavior.never,
                            hintText:
                                AppLocalizations.of(context)!.trans("weight")! +
                                    "...",
                          ),
                          autofocus: false,
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Visibility(
                  visible: isPartialShipment,
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
                            AppLocalizations.of(context)!.trans("count")!,
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        TextField(
                          controller: countControlle,
                          keyboardType: TextInputType.number,
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.allow(RegExp(r'[0-9]'))
                          ],
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            floatingLabelBehavior: FloatingLabelBehavior.never,
                            hintText:
                                AppLocalizations.of(context)!.trans("count")! +
                                    "...",
                          ),
                          autofocus: false,
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                    height: MediaQuery.of(context).size.height / 8,
                    child: addMediaPage),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: InkWell(
                    onTap: () {
                      Map<String, dynamic> body = {
                        "Trip_Offer_Id": widget.tripOffer.id,
                        "date": AppConstants.dateFormat1
                            .format(DateTime.parse(widget.tripOffer.today!)),
                      };
                      if (addMediaPage
                          .addMediaState.mB.attachments.isNotEmpty) {
                        body["attachments"] = addMediaPage
                            .addMediaState.mB.attachments
                            .map((x) => x.toMap())
                            .toList();
                      }
                      if (!isPartialShipment) {
                        _bloc.createRequestTrip(context, body);
                        print(body);
                      } else if (weightControlle.text.isNotEmpty &&
                          countControlle.text.isNotEmpty) {
                        body["weight"] = weightControlle.text;
                        body["count"] = countControlle.text;
                        _bloc.createRequestTrip(context, body);
                        print(body);
                      } else {
                        Fluttertoast.showToast(
                          msg: AppLocalizations.of(context)!
                              .trans("weight_and_count_is_required")!,
                        );
                      }
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
