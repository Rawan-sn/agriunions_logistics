import 'package:flutter/material.dart';
import 'package:agriunions_logistics/Localization/AppLocal.dart';
import 'package:agriunions_logistics/blocs/vehicle_bloc.dart';
import 'package:agriunions_logistics/helper/AppColors.dart';
import 'package:agriunions_logistics/models/vehicle_model.dart';
import 'package:agriunions_logistics/user_interfaces/widget/general_widget.dart';

class VehiclesBottomSheet extends StatefulWidget {
  @override
  _VehiclesBottomSheetState createState() => _VehiclesBottomSheetState();
}

class _VehiclesBottomSheetState extends State<VehiclesBottomSheet> {
  VehicleBloc _bloc = VehicleBloc();
  @override
  void initState() {
    _bloc.getVehicleList(context);
    super.initState();
  }

  @override
  void dispose() {
    _bloc.dispose();
    super.dispose();
  }

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
              AppLocalizations.of(context)!.trans("choose_vehicle")! + "..",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          ),
        ),
        Expanded(
          child: StreamBuilder<List<VehicleModel>?>(
            stream: _bloc.vehicleStream,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                if (snapshot.data!.length != 0) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListView.builder(
                      shrinkWrap: true,
                      primary: false,
                      itemCount: snapshot.data!.length,
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
                                    snapshot.data![index].name!,
                                    style: TextStyle(
                                      fontSize:
                                      MediaQuery.of(context).size.width /
                                          20,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          onTap: () =>
                              Navigator.pop(context, snapshot.data![index]),
                        );
                      },
                    ),
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
                        SizedBox(height: 20),
                        Text(AppLocalizations.of(context)!
                            .trans('no_data_found')!),
                      ],
                    ),
                  );
                }
              }
              return Padding(
                padding: const EdgeInsets.only(top: 20),
                child: GeneralWidget.listProgressIndicator(),
              );
            },
          ),
        )
      ],
    );
  }
}
