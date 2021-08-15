import 'package:flutter/cupertino.dart';
import 'package:agriunions_logistics/models/classification_model.dart';
import 'package:agriunions_logistics/providers/api_vehicle.dart';
import 'package:rxdart/rxdart.dart';

class VehicleClassificationBloc {
  final _classificationController = PublishSubject<List<ClassificationModel>?>();
  get classificationStream => _classificationController.stream;

  final _isLoadingController = PublishSubject<bool>();
  get isLoadingStream => _isLoadingController.stream;

  clearVehicleClassificationList() {
    _classificationController.sink.add(null);
  }

  getVehicleClassification(BuildContext context) {
    _isLoadingController.sink.add(true);
    ApiVehicle(context)
        .getVehiclesClassifications()
        .then((webSer) {
      if (webSer != null) {
        if (!_classificationController.isClosed) {
          _classificationController.sink.add(List<ClassificationModel>.from(
              webSer.data.map((x) => ClassificationModel.fromMap(x))));
        }
      }
      if (!_isLoadingController.isClosed) {
        _isLoadingController.sink.add(false);
      }
    });
  }

  void dispose() {
    _classificationController.close();
    _isLoadingController.close();
  }
}
