import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:agriunions_logistics/Localization/AppLocal.dart';
import 'package:agriunions_logistics/blocs/vehicleClassifications_bloc.dart';
import 'package:agriunions_logistics/helper/AppColors.dart';
import 'package:agriunions_logistics/models/classification_model.dart';
import 'package:agriunions_logistics/user_interfaces/cards/vehicle_classification_grid_card.dart';
import 'package:agriunions_logistics/user_interfaces/widget/general_widget.dart';

class ClassificationBottomSheet extends StatefulWidget {
  @override
  _ClassificationBottomSheetState createState() =>
      _ClassificationBottomSheetState();
}

class _ClassificationBottomSheetState extends State<ClassificationBottomSheet> {
  VehicleClassificationBloc _bloc = VehicleClassificationBloc();
  @override
  void initState() {
    _bloc.getVehicleClassification(context);
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
              AppLocalizations.of(context)!.trans("choose_vehicle_type")! + "..",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          ),
        ),
        Expanded(
          child: StreamBuilder<List<ClassificationModel>?>(
            stream: _bloc.classificationStream,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                if (snapshot.data!.length != 0) {
                  return _buildGridView(snapshot.data!);
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

  Widget _buildGridView(List<ClassificationModel> data) {
    return AnimationConfiguration.synchronized(
      duration: Duration(milliseconds: 1500),
      child: SlideAnimation(
        verticalOffset: 200,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: StaggeredGridView.countBuilder(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            crossAxisCount: 6,
            crossAxisSpacing: 8,
            mainAxisSpacing: 10,
            staggeredTileBuilder: (index) {
              return StaggeredTile.fit(2);
            },
            itemCount: data.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(4.0),
                child: VehicleGridCard(
                  image: "assets/icons/truck_green.png",
                  title: data[index].name!,
                  onTap: () => Navigator.pop(context, data[index]),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
