import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:agriunions_logistics/Localization/AppLocal.dart';
import 'package:agriunions_logistics/helper/AppColors.dart';
import 'package:agriunions_logistics/helper/TextSizes.dart';
import 'package:agriunions_logistics/user_interfaces/pages/home_page_drawer/my_request_trip_offer.dart';
import 'my_trips.dart';

class TripTabPage extends StatefulWidget {
  @override
  _TripTabPageState createState() => _TripTabPageState();
}

class _TripTabPageState extends State<TripTabPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: DefaultTabController(
        length: 2,
        child: SafeArea(
          child: Scaffold(
            appBar: AppBar(
              toolbarHeight: 100,
              title: Text(
                AppLocalizations.of(context)!.trans("trips")!,
                style: TextStyle(
                  fontSize: TextSizes.text,
                ),
              ),
              flexibleSpace: Container(
                color: Color(0xff7a0808),
              ),
              elevation: 0,
              bottom: TabBar(
                labelPadding:
                    EdgeInsets.symmetric(horizontal: 1.0, vertical: 0),
                unselectedLabelColor: AppColors.gray,
                indicatorSize: TabBarIndicatorSize.tab,
                indicator: BoxDecoration(
                    gradient: LinearGradient(
                        colors: [AppColors.Russet, AppColors.white]),
                    borderRadius: BorderRadius.circular(8),
                    color: AppColors.Russet),
                tabs: [
                  SizedBox(
                    height: 35,
                    child: Tab(
                      child: Align(
                        alignment: Alignment.center,
                        child: Text(
                            AppLocalizations.of(context)!.trans("my_trips")!),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 35,
                    child: Tab(
                      child: Align(
                        alignment: Alignment.center,
                        child: Text(
                            AppLocalizations.of(context)!.trans("my_requests")!),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            body: TabBarView(
              children: [
                MyTripsPage(),
                MyRequestTripOfferPage(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
