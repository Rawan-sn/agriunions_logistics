import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:agriunions_logistics/Localization/AppLocal.dart';
import 'package:agriunions_logistics/blocs/requests_trip_offer_bloc.dart';
import 'package:agriunions_logistics/helper/AppColors.dart';
import 'package:agriunions_logistics/helper/TextSizes.dart';
import 'package:agriunions_logistics/helper/app_constants.dart';
import 'package:agriunions_logistics/models/create_models/search_filter_model.dart';
import 'package:agriunions_logistics/models/trip_offer_model.dart';
import 'package:agriunions_logistics/models/trip_offer_request_model.dart';
import 'package:agriunions_logistics/models/trip_offer_requests_info_model.dart';
import 'package:agriunions_logistics/user_interfaces/cards/extend_trip_offer_card.dart';
import 'package:agriunions_logistics/user_interfaces/cards/extend_trip_offer_requests_info_card.dart';
import 'package:agriunions_logistics/user_interfaces/cards/trip_offer_request_card_processing.dart';
import 'package:agriunions_logistics/user_interfaces/dialogs&bottom_sheets/show_bottom_sheets.dart';
import 'package:agriunions_logistics/user_interfaces/dialogs&bottom_sheets/show_dialogs.dart';
import 'package:agriunions_logistics/user_interfaces/widget/general_widget.dart';

class TodayTripsPage extends StatefulWidget {
  @override
  _TodayTripsPageState createState() => _TodayTripsPageState();
}

class _TodayTripsPageState extends State<TodayTripsPage> {
  RequestsTripOffersBloc _bloc = RequestsTripOffersBloc();
  ScrollController scrollController = ScrollController();
  SearchFilterModel? filterModel;
  TripOfferModel? selectedTrip;

  @override
  void initState() {
    filterModel = SearchFilterModel(
      fromDate: DateTime.now(),
      toDate: DateTime.now(),
      mineOnly: true,
    );
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        _bloc.getTripOfferRequests(context, filterModel: filterModel);
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    _bloc.dispose();
    scrollController.dispose();
    super.dispose();
  }

  Future<Null> _refreshAll() async {
    if (selectedTrip != null) {
      _bloc.clearTripOfferRequests();
      _bloc.getTripOfferRequests(context, filterModel: filterModel);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 60,
        title: Text(
          AppLocalizations.of(context)!.trans("today_trips")!,
          style: TextStyle(
            fontSize: TextSizes.text,
          ),
        ),
        flexibleSpace: Container(
          color: Color(0xff7a0808),
        ),
        elevation: 0,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          InkWell(
            onTap: () {
              showDatePicker(
                      context: context,
                      initialDate: filterModel!.fromDate ?? DateTime.now(),
                      firstDate: DateTime(2010),
                      lastDate: DateTime(2100))
                  .then((newDate) {
                if (newDate != null) {
                  setState(() {
                    filterModel!.fromDate = newDate;
                    filterModel!.toDate = newDate;
                    selectedTrip = null;
                  });
                  _bloc.emptyTripOfferRequests();
                }
              });
            },
            child: Card(
              child: ListTile(
                title: Text(
                  AppLocalizations.of(context)!.trans("the_date")!,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: AppColors.customGrey,
                  ),
                ),
                trailing: Text(
                  "${AppConstants.dateFormat1.format(filterModel!.fromDate!)}",
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: AppColors.Russet),
                ),
              ),
            ),
          ),
          InkWell(
            onTap: () {
              FocusScope.of(context).unfocus();
              ShowBottomSheets.selectTrip(context, filterModel,
                  (selectedTripOffer) {
                setState(() {
                  selectedTrip = selectedTripOffer;
                  filterModel!.tripOfferId = selectedTrip!.id;
                  _refreshAll();
                });
              });
            },
            child: Card(
              child: ListTile(
                title: Visibility(
                  visible: selectedTrip != null,
                  child: Text(
                    AppLocalizations.of(context)!.trans("trip_number")! +
                        " : ${selectedTrip?.number}",
                    style: TextStyle(
                      color: AppColors.Russet,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  replacement: Text(
                    AppLocalizations.of(context)!.trans("choose_trip")!,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: AppColors.customGrey,
                    ),
                  ),
                ),
                trailing: Icon(
                  Icons.keyboard_arrow_down_sharp,
                  color: AppColors.Russet,
                ),
              ),
            ),
          ),
          Expanded(
            child: RefreshIndicator(
              onRefresh: _refreshAll,
              child: SingleChildScrollView(
                controller: scrollController,
                child: Column(
                  children: [
                    Visibility(
                      visible: selectedTrip != null,
                      child: ExtendTripOfferCard(selectedTrip),
                    ),
                    Divider(
                      color: AppColors.Russet,
                      indent: 50,
                      endIndent: 50,
                    ),
                    StreamBuilder<List<TripOfferRequestModel>?>(
                      stream: _bloc.tripOffersRequestStream,
                      initialData: [],
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          if (snapshot.data!.length != 0) {
                            return ListView.builder(
                              padding: EdgeInsets.symmetric(horizontal: 5),
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              scrollDirection: Axis.vertical,
                              itemCount: snapshot.data!.length + 1,
                              itemBuilder: (context, index) {
                                if (index == snapshot.data!.length) {
                                  return GeneralWidget.progressIndicator(
                                      _bloc.isLoadingStream);
                                } else {
                                  return Padding(
                                    padding: const EdgeInsets.only(
                                        left: 8.0, right: 8.0),
                                    child: TripOfferRequestCardProcessing(
                                        snapshot.data![index], (isAccept) {
                                      ShowDialogs.showAlert(
                                          context,
                                          AppLocalizations.of(context)!.trans(
                                              isAccept
                                                  ? 'accept_request'
                                                  : 'reject_request'),
                                          AppLocalizations.of(context)!.trans(
                                              isAccept
                                                  ? 'do_you_want_accept_request'
                                                  : 'do_you_want_reject_request'),
                                          () {
                                        Navigator.of(context).pop();
                                        _bloc.setStatusRequestTrip(
                                          context,
                                          snapshot
                                              .data![index].tripOfferRequestId,
                                          isAccept,
                                          filterModel,
                                        );
                                      });
                                    }),
                                  );
                                }
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
                                      image: AssetImage(
                                          "assets/images/oops_data.png")),
                                ),
                                SizedBox(height: 10),
                                Visibility(
                                  visible: selectedTrip == null,
                                  child: Text(
                                    AppLocalizations.of(context)!
                                        .trans('plase_choose_trip_first')!,
                                  ),
                                  replacement: Text(
                                    AppLocalizations.of(context)!
                                        .trans('no_data_found')!,
                                  ),
                                ),
                              ],
                            ));
                          }
                        }
                        return GeneralWidget.listProgressIndicator();
                      },
                    ),
                    StreamBuilder<TripOfferRequestsInfoModel?>(
                      stream: _bloc.tripOffersRequestsInfoStream,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return ExtendTripOfferRequestsInfoCard(snapshot.data);
                        }
                        return Container();
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
          StreamBuilder<bool>(
            stream: _bloc.isAllRequestsProcessedStream,
            initialData: false,
            builder: (context, snapshot) {
              return Visibility(
                visible: snapshot.data!,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  color: AppColors.Russet,
                  child: InkWell(
                    onTap: () {
                      ShowDialogs.showAlert(
                          context,
                          AppLocalizations.of(context)!.trans('start_trip'),
                          AppLocalizations.of(context)!
                              .trans('do_you_want_start_trip'), () {
                        _bloc.startTripProcess(
                          context,
                          selectedTrip!.id,
                          filterModel!.fromDate,
                        );
                      });
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        AppLocalizations.of(context)!.trans("start_trip")!,
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
              );
            },
          ),
        ],
      ),
    );
  }
}
