import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:agriunions_logistics/Localization/AppLocal.dart';
import 'package:agriunions_logistics/helper/AppColors.dart';
import 'package:agriunions_logistics/helper/data_store.dart';
import 'package:agriunions_logistics/user_interfaces/pages/general/map_screen.dart';
import 'package:agriunions_logistics/user_interfaces/pages/general/map_screen_departure.dart';
import 'package:place_picker/place_picker.dart';

class TripDetailsLocationCard extends StatelessWidget {
  TripDetailsLocationCard({this.departurePos, this.destinationPos});
  final LatLng? departurePos;
  final LatLng? destinationPos;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [

        Container(
          width: MediaQuery.of(context).size.width,
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
                  Image.asset("assets/icons/latitude.png", scale: 2.8),
                  Padding(
                    padding: (dataStore.lang == 'en')
                        ? const EdgeInsets.only(left: 8.0)
                        : const EdgeInsets.only(right: 8.0),
                    child: Text(
                        AppLocalizations.of(context)!
                            .trans("departure_Latitude")!,
                        style: TextStyle(
                            fontWeight: FontWeight.bold)),
                  ),
                ],
              ),
              Text("${departurePos!.latitude}"),
            ],
          ),
        ),
        SizedBox(height: 10),
        Container(
          width: MediaQuery.of(context).size.width,
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
                  Image.asset("assets/icons/longitude.png", scale: 2),
                  Padding(
                    padding: (dataStore.lang == 'en')
                        ? const EdgeInsets.only(left: 8.0)
                        : const EdgeInsets.only(right: 8.0),
                    child: Text(
                        AppLocalizations.of(context)!
                            .trans("departure_Longitude")!,
                        style: TextStyle(
                            fontWeight: FontWeight.bold)),
                  ),
                ],
              ),
              Text("${departurePos!.longitude}"),
            ],
          ),
        ),
        SizedBox(height: 10),

        Container(
          width: MediaQuery.of(context).size.width,
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
                  Image.asset("assets/icons/latitude.png", scale: 2.8),
                  Padding(
                    padding: (dataStore.lang == 'en')
                        ? const EdgeInsets.only(left: 8.0)
                        : const EdgeInsets.only(right: 8.0),
                    child: Text(
                        AppLocalizations.of(context)!
                            .trans("destination_Latitude")!,
                        style: TextStyle(
                            fontWeight: FontWeight.bold)),
                  ),
                ],
              ),
              Text("${destinationPos!.latitude}"),
            ],
          ),
        ),
        SizedBox(height: 10),
        Container(
          width: MediaQuery.of(context).size.width,
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
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Image.asset("assets/icons/longitude.png", scale: 2),
                  Padding(
                    padding: (dataStore.lang == 'en')
                        ? const EdgeInsets.only(left: 8.0)
                        : const EdgeInsets.only(right: 8.0),
                    child: Text(
                        AppLocalizations.of(context)!
                            .trans("destination_Longitude")!,
                        style: TextStyle(
                            fontWeight: FontWeight.bold)),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Text("${destinationPos!.longitude}"),
              ),
            ],
          ),
        ),


        SizedBox(height: 8),
        InkWell(
          onTap: () {
            if(destinationPos!.longitude==0&&destinationPos!.latitude==0)
              {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MapScreenDeparture(
                      departure: departurePos,
                    ),
                  ),
                );
              }
            else {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      MapScreen(
                        departurePos: departurePos,
                        destinationPos: destinationPos,
                      ),
                ),
              );
            }
          },
          child: Container(
            decoration: BoxDecoration(
               borderRadius: BorderRadius.circular(20),
              boxShadow: kElevationToShadow[1],
              color: AppColors.white,
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                AppLocalizations.of(context)!.trans("view_on_map")!,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: AppColors.lightBlack,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
