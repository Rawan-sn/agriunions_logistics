import 'package:flutter/material.dart';
import 'package:agriunions_logistics/Localization/AppLocal.dart';
import 'package:agriunions_logistics/helper/AppColors.dart';
import 'package:agriunions_logistics/helper/app_constants.dart';

class StatusTripBottomSheet extends StatefulWidget {
  @override
  _StatusTripBottomSheetState createState() => _StatusTripBottomSheetState();
}

class _StatusTripBottomSheetState extends State<StatusTripBottomSheet> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
            color: AppColors.Russet,
          ),
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height / 10,
          child: Center(
            child: Text(
              AppLocalizations.of(context)!.trans("choose_state")! + "..",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView.builder(
              shrinkWrap: true,
              primary: false,
              itemCount: AppConstants.tripStatus.length,
              itemBuilder: (BuildContext context, int index) {
                return InkWell(
                    child: Padding(
                      padding: EdgeInsets.only(
                        top: 4,
                        bottom: 4,
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          boxShadow: kElevationToShadow[1],
                          color: Colors.white,
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(16),
                          child: Center(
                            child: Text(
                              AppLocalizations.of(context)!
                                  .trans(AppConstants.tripStatus[index])!,
                              style: TextStyle(
                                fontSize:
                                    MediaQuery.of(context).size.width / 20,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    onTap: () {
                      Navigator.pop(context, AppConstants.tripStatus[index]);
                    });
              },
            ),
          ),
        )
      ],
    );
  }
}
