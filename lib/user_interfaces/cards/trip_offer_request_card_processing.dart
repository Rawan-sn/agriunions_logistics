import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:agriunions_logistics/Localization/AppLocal.dart';
import 'package:agriunions_logistics/helper/AppColors.dart';
import 'package:agriunions_logistics/models/trip_offer_request_model.dart';

class TripOfferRequestCardProcessing extends StatefulWidget {
  final TripOfferRequestModel model;
  final void Function(bool isAccept) processRequest;

  const TripOfferRequestCardProcessing(this.model, this.processRequest);

  @override
  _TripOfferRequestCardProcessingState createState() =>
      _TripOfferRequestCardProcessingState();
}

class _TripOfferRequestCardProcessingState
    extends State<TripOfferRequestCardProcessing> {
  bool isShow = false;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
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
                    Expanded(
                      child: Text(
                        "${AppLocalizations.of(context)!.trans("the_client")} : ${widget.model.username}",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: AppColors.Russet),
                      ),
                    ),
                    Row(
                      children: [
                        Icon(
                          widget.model.tripOfferRequestStatus == 'Pending'
                              ? Icons.access_time
                              : widget.model.tripOfferRequestStatus ==
                                      'Received'
                                  ? Icons.check_circle_outline
                                  : Icons.close,
                          size: 15,
                          color:
                              widget.model.tripOfferRequestStatus == 'Pending'
                                  ? Colors.yellow[700]
                                  : widget.model.tripOfferRequestStatus ==
                                          'Received'
                                      ? Colors.green
                                      : AppColors.Russet,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 2.0),
                          child: Text(
                            AppLocalizations.of(context)!
                                .trans(widget.model.tripOfferRequestStatus)!,
                            style: TextStyle(
                              fontSize: 10,
                              color: widget.model.tripOfferRequestStatus ==
                                      'Pending'
                                  ? Colors.yellow[700]
                                  : widget.model.tripOfferRequestStatus ==
                                          'Received'
                                      ? Colors.green
                                      : AppColors.Russet,
                            ),
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
                Visibility(
                  visible: (widget.model.email ?? '').isNotEmpty,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Expanded(
                              child: Text(
                                AppLocalizations.of(context)!.trans("email")!,
                                style: TextStyle(color: AppColors.darkGray),
                              ),
                            ),
                            Expanded(
                              child: Text(
                                widget.model.email ?? "",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Divider(),
                    ],
                  ),
                ),
                Visibility(
                  visible: (widget.model.mobile ?? '').isNotEmpty,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Expanded(
                              child: Text(
                                AppLocalizations.of(context)!.trans("mobile")!,
                                style: TextStyle(color: AppColors.darkGray),
                              ),
                            ),
                            Expanded(
                              child: Text(
                                widget.model.mobile ?? "",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Divider(),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Expanded(
                        child: Text(
                          AppLocalizations.of(context)!.trans("number_of_boxes")!,
                          style: TextStyle(color: AppColors.darkGray),
                        ),
                      ),
                      Text(
                        "${widget.model.tripOfferRequestsNumberOfBoxes}",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                Divider(),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Expanded(
                        child: Text(
                          AppLocalizations.of(context)!.trans("weight")!,
                          style: TextStyle(color: AppColors.darkGray),
                        ),
                      ),
                      Text(
                        "${widget.model.tripOfferRequestsWeight}",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                Divider(),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Expanded(
                        child: Text(
                          AppLocalizations.of(context)!.trans("price")!,
                          style: TextStyle(color: AppColors.darkGray),
                        ),
                      ),
                      Text(
                        "${widget.model.tripOfferRequestsPrice}",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                Divider(),
                Visibility(
                  visible: widget.model.tripOfferRequestStatus == 'Pending',
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.4,
                        child: OutlinedButton(
                          onPressed: () => widget.processRequest(true),
                          child: Text(
                            AppLocalizations.of(context)!.trans("accept")!,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(color: Colors.green),
                          ),
                          style: ButtonStyle(
                            overlayColor:
                                MaterialStateProperty.all(Colors.green),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.4,
                        child: OutlinedButton(
                          onPressed: () => widget.processRequest(false),
                          child: Text(
                            AppLocalizations.of(context)!.trans("reject")!,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(color: AppColors.Russet),
                          ),
                          style: ButtonStyle(
                            overlayColor:
                                MaterialStateProperty.all(AppColors.Russet),
                          ),
                        ),
                      ),
                    ],
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
