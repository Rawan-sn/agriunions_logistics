import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:agriunions_logistics/Localization/AppLocal.dart';
import 'package:agriunions_logistics/blocs/vehicle_bloc.dart';
import 'package:agriunions_logistics/helper/AppColors.dart';
import 'package:agriunions_logistics/helper/TextSizes.dart';
import 'package:agriunions_logistics/models/vehicle_model.dart';
import 'package:agriunions_logistics/user_interfaces/cards/vehicle_card.dart';
import 'package:agriunions_logistics/user_interfaces/dialogs&bottom_sheets/show_dialogs.dart';
import 'package:agriunions_logistics/user_interfaces/widget/general_widget.dart';

class VehiclesPage extends StatefulWidget {
  @override
  _VehiclesPageState createState() => _VehiclesPageState();
}

class _VehiclesPageState extends State<VehiclesPage> {
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

  Future<Null> _refresh() async {
    _bloc.clearVehicleList();
    _bloc.getVehicleList(context);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            toolbarHeight: 60,
            title: Text(
              AppLocalizations.of(context)!.trans("vehicles")!,
              style: TextStyle(
                fontSize: TextSizes.text,
              ),
            ),
            flexibleSpace: Container(
              color: Color(0xff7a0808),
            ),
            elevation: 0,
          ),
          body: RefreshIndicator(
            onRefresh: _refresh,
            child: StreamBuilder<List<VehicleModel>?>(
              stream: _bloc.vehicleStream,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  if (snapshot.data!.length != 0) {
                    return SingleChildScrollView(
                      child: Column(
                        children: [
                          SizedBox(height: 10),
                          ListView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            primary: false,
                            itemCount: snapshot.data!.length,
                            itemBuilder: (BuildContext context, int index) {
                              return InkWell(
                                child: VehicleCard(model: snapshot.data![index]),
                                onTap: () {
                                  print(snapshot.data![index].latinName);
                                  ShowDialogs.createVehicleDialog(context,
                                          model: snapshot.data![index])
                                      .then((value) {
                                    if (value ?? false) _refresh();
                                  });
                                },
                              );
                            },
                          ),
                        ],
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
                                image:
                                    AssetImage("assets/images/oops_data.png")),
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
          ),
          floatingActionButton: FloatingActionButton(
            child: Icon(Icons.add),
            backgroundColor: AppColors.Russet1,
            foregroundColor: Colors.white,
            tooltip: AppLocalizations.of(context)!.trans("new_vehicle"),
            onPressed: () {
              ShowDialogs.createVehicleDialog(context).then((value) {
                if (value ?? false) _refresh();
              });
            },
          )),
    );
  }
}
