import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:agriunions_logistics/Localization/AppLocal.dart';
import 'package:agriunions_logistics/blocs/trip_offers_bloc.dart';
import 'package:agriunions_logistics/helper/enums.dart';
import 'package:agriunions_logistics/models/create_models/search_filter_model.dart';
import 'package:agriunions_logistics/models/trip_offer_model.dart';
import 'package:agriunions_logistics/user_interfaces/cards/filter_info_card.dart';
import 'package:agriunions_logistics/user_interfaces/cards/home_card.dart';
import 'package:agriunions_logistics/user_interfaces/dialogs&bottom_sheets/show_dialogs.dart';
import 'package:agriunions_logistics/user_interfaces/pages/detailsTripTapPage.dart';
import 'package:agriunions_logistics/user_interfaces/pages/home_page_drawer/home_page_drawer.dart';
import 'package:agriunions_logistics/helper/data_store.dart';
import 'package:agriunions_logistics/user_interfaces/widget/ads_home_page_slider.dart';
import 'package:agriunions_logistics/user_interfaces/widget/general_widget.dart';

class SchedulesTripsPage extends StatefulWidget {
  @override
  _SchedulesTripsState createState() => _SchedulesTripsState();
}

class _SchedulesTripsState extends State<SchedulesTripsPage> {
  TripOffersBloc _tripOffersBloc = TripOffersBloc();
  final _searchTextController = new TextEditingController();
  ScrollController scrollController = ScrollController();
  SearchFilterModel? filterModel;
  @override
  void initState() {
    filterModel =
        SearchFilterModel(fromDate: DateTime.now(), toDate: DateTime.now());
    _tripOffersBloc.getSchedulesTripOffers(context, filterModel: filterModel);
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        _tripOffersBloc.getSchedulesTripOffers(context,
            filterModel: filterModel);
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    _tripOffersBloc.dispose();
    _searchTextController.dispose();
    scrollController.dispose();
    super.dispose();
  }

  Future<Null> _refreshAll() async {
    _tripOffersBloc.clearTripOffers();
    _tripOffersBloc.getSchedulesTripOffers(context, filterModel: filterModel);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "main",
        ),
        backgroundColor: Colors.amber,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Visibility(
            visible: dataStore.proType == ProjectType.staging,
            child: Container(
              color: Colors.red[700],
              width: double.infinity,
              child: Text(
                AppLocalizations.of(context)!.trans("staging")!,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
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
                  children: <Widget>[
                    AdsHomePageSlider(),
                    Row(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              width: MediaQuery.of(context).size.width / 2.2,
                              height: 50,
                              decoration: BoxDecoration(
                                  boxShadow: kElevationToShadow[1],
                                  borderRadius: BorderRadius.all(
                                    (Radius.circular(10)),
                                  ),
                                  color: Colors.grey.shade200),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  children: [
                                    Icon(Icons.search),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8.0),
                                      child: Text("search for trip"),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            height: 50,
                            width: MediaQuery.of(context).size.width / 5.5,
                            decoration: BoxDecoration(
                              color: Colors.amberAccent,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey,
                                  blurRadius: 1,
                                  offset: Offset(0, 2), // Shadow position
                                ),
                              ],
                              borderRadius: BorderRadius.all(
                                (Radius.circular(10)),
                              ),
                            ),
                            child: InkWell(
                              child: Icon(Icons.filter_list_alt),
                              onTap: () {
                                ShowDialogs.showSearchFilterDialog(
                                    context, filterModel, (newFilterModel) {
                                  if (newFilterModel != null) {
                                    setState(() {
                                      this.filterModel = newFilterModel;
                                    });
                                    _tripOffersBloc.clearTripOffers();
                                    _tripOffersBloc.getSchedulesTripOffers(
                                        context,
                                        filterModel: filterModel);
                                  }
                                });
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                    FilterInfoCard(filterModel: filterModel),
                    StreamBuilder<List<TripOfferModel>?>(
                      stream: _tripOffersBloc.tripOffersStream,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          if (snapshot.data!.length != 0) {
                            return ListView.builder(
                              padding: EdgeInsets.symmetric(horizontal: 5),
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              scrollDirection: Axis.vertical,
                              itemCount: snapshot.data!.length + 1,
                              itemBuilder: (context, index) {
                                if (index == snapshot.data!.length) {
                                  return GeneralWidget.progressIndicator(
                                      _tripOffersBloc.isLoadingStream);
                                } else {
                                  return InkWell(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              DetailsTripTabPage(
                                                  snapshot.data![index]),
                                        ),
                                      );
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: TripOfferCard( snapshot.data![index]),
                                    ), //snapshot.data![index]
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
                                  Text(AppLocalizations.of(context)!
                                      .trans('no_data_found')!),
                                  ElevatedButton(
                                    child: Text(AppLocalizations.of(context)!
                                        .trans('refresh')!),
                                    onPressed: () {
                                      _refreshAll();
                                    },
                                  )
                                ],
                              ),
                            );
                          }
                        }
                        return GeneralWidget.listProgressIndicator();
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      drawer: HomePageDrawer(),
    );
  }
}
