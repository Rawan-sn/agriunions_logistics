import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:agriunions_logistics/Localization/AppLocal.dart';
import 'package:agriunions_logistics/helper/app_permissions.dart';
import 'package:agriunions_logistics/models/trip_offer_model.dart';
import 'package:agriunions_logistics/user_interfaces/pages/trip_conversation.dart';
import 'package:agriunions_logistics/user_interfaces/pages/trip_conversations_list.dart';
import 'package:agriunions_logistics/user_interfaces/pages/trip_details_page.dart';

class DetailsTripTabPage extends StatefulWidget {
  DetailsTripTabPage(this.trip);

  final TripOfferModel trip;

  @override
  _DetailsTripTabPageState createState() => _DetailsTripTabPageState();
}

class _DetailsTripTabPageState extends State<DetailsTripTabPage> {
  int selectedIndex = 0;
  double gap = 10;
  PageController controller = PageController();

  List<Widget> _route = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _route = [
      TripDetailsPage(widget.trip),
      Visibility(
        visible: AppPermissions.isLogged(),
        child: Visibility(
          visible: AppPermissions.isServiceProvider(),
          child: TripConversationsListPage(
            withUserId: widget.trip.branchUserId,
            withRoomId: widget.trip.id,
          ),
          replacement: TripConversationPage(
            withUserId: widget.trip.branchUserId,
            withRoomId: widget.trip.id,
          ),
        ),
        replacement: Center(
          child: Text(
            AppLocalizations.of(context)!.trans("need_login")!,
          ),
        ),
      ),
    ];
    return Scaffold(
      backgroundColor: Colors.white,
      extendBody: true,
      appBar: AppBar(
        brightness: Brightness.light,
        title: Text(
          AppLocalizations.of(context)!.trans("details_trip")!,
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.amber,
      ),
      body: Column(
        children: [
          SafeArea(
            child: Container(
              height: 50,
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(100)),
                boxShadow: [
                  BoxShadow(
                    spreadRadius: -10,
                    blurRadius: 60,
                    color: Colors.black.withOpacity(.4),
                    offset: Offset(0, 25),
                  )
                ],
              ),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 3.0, vertical: 3),
                child: GNav(
                  tabs: [
                    GButton(
                      gap: gap,
                      iconActiveColor: Colors.amber[600],
                      iconColor: Colors.black,
                      textColor: Colors.amber[600],
                      backgroundColor: Colors.amber[600]!.withOpacity(.2),
                      iconSize: 24,
                      padding:
                          EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                      icon: Icons.directions_car,
                      text:
                          AppLocalizations.of(context)!.trans("details_trip")!,
                    ),
                    GButton(
                      gap: gap,
                      iconActiveColor: Colors.black,
                      iconColor: Colors.black,
                      textColor: Colors.black,
                      backgroundColor: Colors.amber.withOpacity(.2),
                      iconSize: 24,
                      padding:
                          EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                      icon: Icons.chat,
                      text: AppPermissions.isServiceProvider()
                          ? AppLocalizations.of(context)!
                              .trans("conversations")!
                          : AppLocalizations.of(context)!.trans("chat")!,
                    )
                  ],
                  selectedIndex: selectedIndex,
                  onTabChange: (index) {
                    setState(() {
                      selectedIndex = index;
                    });
                    controller.jumpToPage(index);
                  },
                ),
              ),
            ),
          ),
          Expanded(
            child: PageView.builder(
              onPageChanged: (page) {
                setState(() {
                  selectedIndex = page;
                });
              },
              controller: controller,
              itemBuilder: (context, position) {
                return _route[position];
              },
              itemCount: 2,
            ),
          ),
        ],
      ),
    );
  }
}
