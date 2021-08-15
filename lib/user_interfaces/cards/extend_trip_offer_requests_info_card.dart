import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:agriunions_logistics/Localization/AppLocal.dart';
import 'package:agriunions_logistics/helper/AppColors.dart';

import 'package:agriunions_logistics/models/trip_offer_requests_info_model.dart';

class ExtendTripOfferRequestsInfoCard extends StatefulWidget {
  final TripOfferRequestsInfoModel? model;
  const ExtendTripOfferRequestsInfoCard(this.model);

  @override
  _ExtendTripOfferRequestsInfoCardState createState() =>
      _ExtendTripOfferRequestsInfoCardState();
}

class _ExtendTripOfferRequestsInfoCardState
    extends State<ExtendTripOfferRequestsInfoCard> {
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
            color: Colors.grey[200],
          ),
          child: Padding(
            padding:
                const EdgeInsets.only(top: 10, left: 10, right: 10, bottom: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  AppLocalizations.of(context)!.trans("stats_of_requests")!,
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
                        AppLocalizations.of(context)!.trans("accepted_requests")!,
                        style: TextStyle(color: AppColors.darkGray),
                      ),
                      Text(
                        "${widget.model!.numberAcceptedRequests}",
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
                        AppLocalizations.of(context)!.trans("number_of_boxes")!,
                        style: TextStyle(color: AppColors.darkGray),
                      ),
                      Text(
                        "${widget.model!.tripOfferRequestsNumberOfBoxes}",
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
                        AppLocalizations.of(context)!.trans("total_weight")!,
                        style: TextStyle(color: AppColors.darkGray),
                      ),
                      Text(
                        "${widget.model!.tripOfferRequestsWeight}",
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
                        AppLocalizations.of(context)!.trans("total_price")!,
                        style: TextStyle(color: AppColors.darkGray),
                      ),
                      Text(
                        "${widget.model!.tripOfferRequestsPrice}",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                ),
                Divider(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
