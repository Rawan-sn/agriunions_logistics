import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:agriunions_logistics/Localization/AppLocal.dart';
import 'package:agriunions_logistics/blocs/requests_trip_offer_bloc.dart';
import 'package:agriunions_logistics/models/trip_offer_request_model.dart';
import 'package:agriunions_logistics/user_interfaces/cards/trip_offer_request_card.dart';
import 'package:agriunions_logistics/user_interfaces/widget/general_widget.dart';

class MyRequestTripOfferPage extends StatefulWidget {
  @override
  _MyRequestTripOfferPageState createState() => _MyRequestTripOfferPageState();
}

class _MyRequestTripOfferPageState extends State<MyRequestTripOfferPage> {
  RequestsTripOffersBloc _bloc = RequestsTripOffersBloc();

  @override
  void initState() {
    _bloc.getTripOfferRequests(context);
    super.initState();
  }

  @override
  void dispose() {
    _bloc.dispose();
    super.dispose();
  }

  Future<Null> _refresh() async {
    _bloc.clearTripOfferRequests();
    _bloc.getTripOfferRequests(context);
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: _refresh,
      child: Padding(
        padding: const EdgeInsets.only(top: 10.0),
        child: StreamBuilder<List<TripOfferRequestModel>?>(
          stream: _bloc.tripOffersRequestStream,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data!.length != 0) {
                return ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                      child: TripOfferRequestCard(snapshot.data![index]),
                    );
                  },
                );
              } else {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        height: 80,
                        width: 80,
                        child: Image(
                            image: AssetImage("assets/images/oops_data.png")),
                      ),
                      SizedBox(height: 20),
                      Text(AppLocalizations.of(context)!.trans('no_data_found')!),
                    ],
                  ),
                );
              }
            }
            return Padding(
              padding: const EdgeInsets.only(top: 20),
              child: GeneralWidget.listProgressIndicator(),
            );
          },
        ),
      ),
    );
  }
}
