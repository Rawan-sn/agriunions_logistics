import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:agriunions_logistics/Localization/AppLocal.dart';
import 'package:agriunions_logistics/models/city_model.dart';
import 'package:agriunions_logistics/providers/api_city_country.dart';
import 'package:rxdart/rxdart.dart';

class CityBloc {
  String? countryId;
  final _cityController = PublishSubject<List<CityModel>?>();

  get cityStream => _cityController.stream;

  final _isLoadingController = PublishSubject<bool>();

  get isLoadingStream => _isLoadingController.stream;

  clearCityList() {
    _cityController.sink.add(null);
  }

  bool _checkIsValid(BuildContext context) {
    if ((countryId ?? "").isEmpty) {
      Fluttertoast.showToast(
          msg: AppLocalizations.of(context)!.trans("please_choose_country")!);
      return false;
    }
    return true;
  }

  getCityList(BuildContext context) {
    if (_checkIsValid(context)) {
      _isLoadingController.sink.add(true);
      ApiCityCountry(context).getCities(countryId).then((webSer) {
        if (webSer != null) {
          if (!_cityController.isClosed) {
            _cityController.sink.add(List<CityModel>.from(
                webSer.data.map((x) => CityModel.fromMap(x))));
          }
        }
        if (!_isLoadingController.isClosed) {
          _isLoadingController.sink.add(false);
        }
      });
    }
  }

  void dispose() {
    _cityController.close();
    _isLoadingController.close();
  }
}
