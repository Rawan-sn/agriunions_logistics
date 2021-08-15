import 'package:flutter/material.dart';
import 'package:agriunions_logistics/Localization/AppLocal.dart';
import 'package:agriunions_logistics/helper/AppColors.dart';
import 'package:agriunions_logistics/helper/app_constants.dart';

class RotationTypeBottomSheet extends StatefulWidget {
  @override
  _RotationTypeBottomSheetState createState() =>
      _RotationTypeBottomSheetState();
}

class _RotationTypeBottomSheetState extends State<RotationTypeBottomSheet> {
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
              AppLocalizations.of(context)!.trans("choose_trip_cycle")! + "..",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              primary: false,
              itemCount: AppConstants.rotationType.length,
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
                                .trans(AppConstants.rotationType[index])!,
                            style: TextStyle(
                              fontSize: MediaQuery.of(context).size.width / 20,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  onTap: () =>
                      Navigator.pop(context, AppConstants.rotationType[index]),
                );
              },
            ),
          ),
        )
      ],
    );
  }
}
