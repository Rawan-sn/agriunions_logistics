import 'package:flutter/cupertino.dart';
import 'package:agriunions_logistics/models/vehicle_model.dart';
import 'package:agriunions_logistics/providers/api_vehicle.dart';
import 'package:rxdart/rxdart.dart';

class VehicleBloc {
  final _vehicleController = PublishSubject<List<VehicleModel>?>();

  get vehicleStream => _vehicleController.stream;

  final _isLoadingController = PublishSubject<bool>();

  get isLoadingStream => _isLoadingController.stream;

  clearVehicleList() {
    _vehicleController.sink.add(null);
  }

  getVehicleList(BuildContext context) {
    _isLoadingController.sink.add(true);
    ApiVehicle(context).getVehicles().then((webSer) {
      if (webSer != null) {
        if (!_vehicleController.isClosed) {
          _vehicleController.sink.add(List<VehicleModel>.from(
              webSer.data.map((x) => VehicleModel.fromMap(x))));
        }
      }
      if (!_isLoadingController.isClosed) {
        _isLoadingController.sink.add(false);
      }
    });
  }

  void dispose() {
    _vehicleController.close();
    _isLoadingController.close();
  }
}
