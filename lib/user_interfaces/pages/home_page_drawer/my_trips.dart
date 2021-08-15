import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:agriunions_logistics/Localization/AppLocal.dart';
import 'package:agriunions_logistics/blocs/trip_offers_bloc.dart';
import 'package:agriunions_logistics/helper/AppColors.dart';
import 'package:agriunions_logistics/helper/app_permissions.dart';
import 'package:agriunions_logistics/helper/data_store.dart';
import 'package:agriunions_logistics/models/create_models/search_filter_model.dart';
import 'package:agriunions_logistics/models/trip_offer_model.dart';
import 'package:agriunions_logistics/user_interfaces/cards/filter_info_card.dart';
import 'package:agriunions_logistics/user_interfaces/cards/trip_offer_card.dart';
import 'package:agriunions_logistics/user_interfaces/dialogs&bottom_sheets/show_dialogs.dart';
import 'package:agriunions_logistics/user_interfaces/pages/add_edit_trip_page.dart';
import 'package:agriunions_logistics/user_interfaces/pages/detailsTripTapPage.dart';
import 'package:agriunions_logistics/user_interfaces/widget/general_widget.dart';

class MyTripsPage extends StatefulWidget {
  @override
  _MyTripsPageState createState() => _MyTripsPageState();
}

class _MyTripsPageState extends State<MyTripsPage> {
  TripOffersBloc _tripOffersBloc = TripOffersBloc();
  final _searchTextController = new TextEditingController();
  ScrollController scrollController = ScrollController();
  SearchFilterModel? filterModel;

  @override
  void initState() {
    filterModel = SearchFilterModel(
      fromDate: DateTime.now(),
      toDate: DateTime.now(),
      country: dataStore.country,
    );
    _tripOffersBloc.getMyTripsOffers(context);
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        _tripOffersBloc.getMyTripsOffers(context, filterModel: filterModel);
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

  moveToAddEditTrip() async {
    var isAddedOrEdited = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {
          return AddEditTripPage();
        },
      ),
    );
    if (isAddedOrEdited != null) {
      _refreshAll();
    }
  }

  Future<Null> _refreshAll() async {
    _tripOffersBloc.clearTripOffers();
    _tripOffersBloc.getMyTripsOffers(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Card(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: TextFormField(
                    textAlign: TextAlign.start,
                    onFieldSubmitted: (term) {
                      if (filterModel != null) {
                        filterModel!.keyword = term;
                      } else {
                        filterModel = SearchFilterModel(keyword: term);
                      }
                      _tripOffersBloc.clearTripOffers();
                      _tripOffersBloc.getMyTripsOffers(context,
                          filterModel: filterModel);
                      setState(() => _searchTextController.text = "");
                    },
                    style: TextStyle(color: AppColors.gray),
                    controller: _searchTextController,
                    decoration: new InputDecoration(
                      border: InputBorder.none,
                      prefixIcon: new Icon(Icons.search, color: AppColors.gray),
                      hintText: AppLocalizations.of(context)!.trans('search'),
                      hintStyle: new TextStyle(color: Colors.grey, height: 1.2),
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(FontAwesome5.filter, color: AppColors.red),
                  onPressed: () {
                    ShowDialogs.showSearchFilterDialog(context, filterModel,
                        (newFilterModel) {
                      if (newFilterModel != null) {
                        setState(() {
                          this.filterModel = newFilterModel;
                        });
                        _tripOffersBloc.clearTripOffers();
                        _tripOffersBloc.getMyTripsOffers(context,
                            filterModel: filterModel);
                      }
                    });
                  },
                )
              ],
            ),
          ),
          Expanded(
            child: RefreshIndicator(
              onRefresh: _refreshAll,
              child: SingleChildScrollView(
                controller: scrollController,
                child: Column(
                  children: <Widget>[
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
                                            snapshot.data![index],
                                          ),
                                        ),
                                      );
                                    },
                                    child: TripOfferCard1(
                                      snapshot.data![index],
                                      allowEdit: true,
                                    ),
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
                            ));
                          }
                        }
                        return Padding(
                          padding: const EdgeInsets.only(top: 200),
                          child: GeneralWidget.listProgressIndicator(),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: Visibility(
        visible: AppPermissions.isServiceProvider(),
        child: FloatingActionButton(
          backgroundColor: AppColors.Russet1,
          onPressed: () {
            moveToAddEditTrip();
          },
          child: Icon(Icons.add),
        ),
      ),
    );
  }
}
