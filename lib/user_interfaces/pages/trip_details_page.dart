import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttericon/entypo_icons.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:agriunions_logistics/Localization/AppLocal.dart';
import 'package:agriunions_logistics/blocs/trip_offer_details_bloc.dart';
import 'package:agriunions_logistics/blocs/update_trip-offer_status_bloc.dart';
import 'package:agriunions_logistics/helper/AppColors.dart';
import 'package:agriunions_logistics/helper/app_permissions.dart';
import 'package:agriunions_logistics/helper/data_store.dart';
import 'package:agriunions_logistics/models/details_trip_offer_model.dart';
import 'package:agriunions_logistics/models/trip_offer_model.dart';
import 'package:agriunions_logistics/user_interfaces/cards/trip_detailes_card.dart';
import 'package:agriunions_logistics/user_interfaces/cards/trip_detailes_location_card.dart';
import 'package:agriunions_logistics/user_interfaces/dialogs&bottom_sheets/show_bottom_sheets.dart';
import 'package:agriunions_logistics/user_interfaces/dialogs&bottom_sheets/show_dialogs.dart';
import 'package:agriunions_logistics/user_interfaces/widget/general_widget.dart';

class TripDetailsPage extends StatefulWidget {
  TripDetailsPage(this.tripOffer);

  final TripOfferModel tripOffer;

  @override
  _TripDetailsPageState createState() => _TripDetailsPageState();
}

class _TripDetailsPageState extends State<TripDetailsPage> {
  TripOfferDetailsBloc _bloc = TripOfferDetailsBloc();

  UpdateTripOfferStatusBloc _update = UpdateTripOfferStatusBloc();

  @override
  void initState() {
    super.initState();
    _bloc.getTripOfferDetails(context, widget.tripOffer.id!);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder<TripDetailsOfferModel?>(
              stream: _bloc.tripOfferDetailsStream,
              builder: (context, snapshot) {
                if (snapshot.hasData)
                  return Padding(
                    padding: const EdgeInsets.all(9.0),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          SizedBox(
                            height: 5,
                          ),
                          Padding(
                            padding:
                            const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Align(
                              alignment: Alignment.center,
                              child: Text(
                                AppLocalizations.of(context)!.trans("trip")! +
                                    " ${snapshot.data!.number}",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                          Visibility(
                            visible: snapshot.data!.canControl ?? false,
                            child: InkWell(
                              child: Container(
                                padding: EdgeInsets.all(7.0),
                                decoration: BoxDecoration(
                                  border: Border.all(color: AppColors.Russet),
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.white,
                                  boxShadow: kElevationToShadow[3],
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Icon(Icons.update),
                                        Padding(
                                          padding: (dataStore.lang == 'en')
                                              ? const EdgeInsets.only(left: 8.0)
                                              : const EdgeInsets.only(
                                              right: 8.0),
                                          child: Text(
                                              AppLocalizations.of(context)!
                                                  .trans("update_status")!,
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold)),
                                        ),
                                      ],
                                    ),
                                    Icon(Icons.arrow_drop_down),
                                  ],
                                ),
                              ),
                              onTap: () {
                                ShowBottomSheets.selectStatusTrip(context,
                                        (selectedType) {
                                      setState(() {
                                        if (selectedType != null) {
                                          _update.updateRequestTripStatus(context,
                                              snapshot.data!.id, selectedType);
                                        }
                                      });
                                    });
                              },
                            ),
                          ),
                          SizedBox(height: 10),
                          Row(children: [
                            Container(
                              width: MediaQuery.of(context).size.width/2.2,
                              padding: EdgeInsets.all(7.0),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.amber,
                                    blurRadius: 1,
                                    offset: Offset(0, 2), // Shadow position
                                  ),
                                ],
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Icon(Entypo.user),
                                      Padding(
                                        padding: (dataStore.lang == 'en')
                                            ? const EdgeInsets.only(left: 8.0)
                                            : const EdgeInsets.only(right: 8.0),
                                        child: Text(
                                            AppLocalizations.of(context)!
                                                .trans("service_provider")!,
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold)),
                                      ),
                                    ],
                                  ),
                                  Text(snapshot.data!.branchUsername ?? "0.0"),
                                ],
                              ),
                            ),
                            SizedBox(width: 10),
                            Container(
                              width: MediaQuery.of(context).size.width/2.2,

                              padding: EdgeInsets.all(7.0),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.amber,
                                    blurRadius: 1,
                                    offset: Offset(0, 2), // Shadow position
                                  ),
                                ],
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Icon(Entypo.tag),
                                      Padding(
                                        padding: (dataStore.lang == 'en')
                                            ? const EdgeInsets.only(left: 8.0)
                                            : const EdgeInsets.only(right: 8.0),
                                        child: Text(
                                            AppLocalizations.of(context)!
                                                .trans("the_price")!,
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold)),
                                      ),
                                    ],
                                  ),
                                  Text(snapshot.data!.price ?? "0.0"),
                                ],
                              ),
                            ),

                          ],),

                          SizedBox(height: 10),
                          Visibility(
                            visible: snapshot.data!.vehicleId!.trim() != "",
                            child: Row(children: [
                              Container(
                                width: MediaQuery.of(context).size.width/2.2,
                                padding: EdgeInsets.all(7.0),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.white,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.amber,
                                      blurRadius: 1,
                                      offset: Offset(0, 2), // Shadow position
                                    ),
                                  ],                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Icon(Icons.directions_car_sharp,),
                                        Padding(
                                          padding: (dataStore.lang == 'en')
                                              ? const EdgeInsets.only(left: 8.0)
                                              : const EdgeInsets.only(right: 8.0),
                                          child: Text(
                                              AppLocalizations.of(context)!
                                                  .trans("vehicle")!,
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold)),
                                        ),
                                      ],
                                    ),
                                    Text(snapshot.data!.vehicleName ?? "",),
                                  ],
                                ),
                              ),
                              SizedBox(width: 10),
                              Container(
                                width: MediaQuery.of(context).size.width/2.2,

                                padding: EdgeInsets.all(7.0),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.white,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.amber,
                                      blurRadius: 1,
                                      offset: Offset(0, 2), // Shadow position
                                    ),
                                  ],                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Icon(Entypo.tag),
                                        Padding(
                                          padding: (dataStore.lang == 'en')
                                              ? const EdgeInsets.only(left: 8.0)
                                              : const EdgeInsets.only(right: 8.0),
                                          child: Text(
                                              AppLocalizations.of(context)!
                                                  .trans("classification")!,
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold)),
                                        ),
                                      ],
                                    ),
                                    Text( snapshot.data!.vehicleClassificationName ?? ""),
                                  ],
                                ),
                              ),

                            ],),
                          )
                          ,Visibility(
                            visible: snapshot.data!.vehicleId!.trim() != "",
                            child: SizedBox(height: 10),
                          ),
                          Row(children: [
                            Container(
                              width: MediaQuery.of(context).size.width/2.2,
                              padding: EdgeInsets.all(7.0),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.amber,
                                    blurRadius: 1,
                                    offset: Offset(0, 2), // Shadow position
                                  ),
                                ],                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Icon(Icons.location_on_outlined,),
                                      Padding(
                                        padding: (dataStore.lang == 'en')
                                            ? const EdgeInsets.only(left: 8.0)
                                            : const EdgeInsets.only(right: 8.0),
                                        child: Text(
                                            AppLocalizations.of(context)!
                                                .trans("departure")!,
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold)),
                                      ),
                                    ],
                                  ),
                                  Text( snapshot.data!.departureName!),
                                ],
                              ),
                            ),
                            SizedBox(width: 10),
                            Container(
                              width: MediaQuery.of(context).size.width/2.2,

                              padding: EdgeInsets.all(7.0),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.amber,
                                    blurRadius: 1,
                                    offset: Offset(0, 2), // Shadow position
                                  ),
                                ],
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Icon(Icons.location_city,),
                                      Padding(
                                        padding: (dataStore.lang == 'en')
                                            ? const EdgeInsets.only(left: 8.0)
                                            : const EdgeInsets.only(right: 8.0),
                                        child: Text(
                                            AppLocalizations.of(context)!
                                                .trans("departure_city")!,
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold)),
                                      ),
                                    ],
                                  ),
                                  Text( snapshot.data!.departureCityName!),
                                ],
                              ),
                            ),

                          ],),

                          SizedBox(height: 10),
                          Visibility(
                            visible: snapshot.data!.destinationName!.isNotEmpty,

                            child: Row(children: [
                              Container(
                                width: MediaQuery.of(context).size.width/2.2,
                                padding: EdgeInsets.all(7.0),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.white,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.amber,
                                      blurRadius: 1,
                                      offset: Offset(0, 2), // Shadow position
                                    ),
                                  ],                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Icon(Icons.location_on_outlined,),
                                        Padding(
                                          padding: (dataStore.lang == 'en')
                                              ? const EdgeInsets.only(left: 8.0)
                                              : const EdgeInsets.only(right: 8.0),
                                          child: Text(
                                              AppLocalizations.of(context)!
                                                  .trans("destination")!,
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold)),
                                        ),
                                      ],
                                    ),
                                    Text( snapshot.data!.destinationName!),
                                  ],
                                ),
                              ),
                              SizedBox(width: 10),
                              Container(
                                width: MediaQuery.of(context).size.width/2.2,

                                padding: EdgeInsets.all(7.0),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.white,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.amber,
                                      blurRadius: 1,
                                      offset: Offset(0, 2), // Shadow position
                                    ),
                                  ],                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Icon(Icons.location_city,),
                                        Padding(
                                          padding: (dataStore.lang == 'en')
                                              ? const EdgeInsets.only(left: 8.0)
                                              : const EdgeInsets.only(right: 8.0),
                                          child: Text(
                                              AppLocalizations.of(context)!
                                                  .trans("destination_city")!,
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold)),
                                        ),
                                      ],
                                    ),
                                    Text( snapshot.data!.destinationCityName!),
                                  ],
                                ),
                              ),

                            ],),
                          ),

                          SizedBox(height: 10),
                          Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: Container(
                              padding: EdgeInsets.all(7.0),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.amber,
                                    blurRadius: 1,
                                    offset: Offset(0, 2), // Shadow position
                                  ),
                                ],
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Icon(Entypo.flow_branch),
                                      // Image.asset(
                                      //   "assets/icons/branch.png",
                                      //   scale: 2,
                                      // ),
                                      Padding(
                                        padding: (dataStore.lang == 'en')
                                            ? const EdgeInsets.only(left: 8.0)
                                            : const EdgeInsets.only(right: 8.0),
                                        child: Text(
                                            AppLocalizations.of(context)!
                                                .trans("branch")!,
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold)),
                                      ),
                                    ],
                                  ),
                                  Text(snapshot.data!.branchName!),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(height: 10),

                          TripDetailsLocationCard(
                            departurePos: LatLng(
                              double.tryParse(
                                  snapshot.data!.departureLatitude!) ??
                                  0,
                              double.tryParse(
                                  snapshot.data!.departureLongitude!) ??
                                  0,
                            ),
                            destinationPos: LatLng(
                              double.tryParse(
                                  snapshot.data!.destinationLatitude!) ??
                                  0,
                              double.tryParse(
                                  snapshot.data!.destinationLongitude!) ??
                                  0,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                return Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: GeneralWidget.listProgressIndicator(),
                );
              },
            ),
          ),
          Visibility(
            visible: AppPermissions.isLogged(),
            child: Container(
              margin: EdgeInsets.only(top: 6),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.white, width: 1.5),
                color: Colors.amber,
              ),
              width: MediaQuery.of(context).size.width,
              child: InkWell(
                onTap: () {
                  FocusScope.of(context).unfocus();
                  ShowDialogs.sendTripRequestDialog(context, widget.tripOffer);
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    AppLocalizations.of(context)!.trans("request_trip")!,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: AppColors.white,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
/*
    Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    gradient: LinearGradient(
                                        begin: Alignment.bottomCenter,
                                        end: Alignment.topCenter,
                                        colors: [Colors.grey.shade100, Colors.grey.shade300]),
                                    boxShadow: kElevationToShadow[1],            color: Colors.grey.shade100,
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Icon(Icons.location_on_sharp),
                                  )),
 */