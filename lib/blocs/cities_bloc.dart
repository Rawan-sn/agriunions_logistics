import 'package:flutter/cupertino.dart';
import 'package:agriunions_logistics/models/city_model.dart';
import 'package:agriunions_logistics/providers/api_city_country.dart';
import 'package:rxdart/rxdart.dart';

class CitiesBloc {
  final _citiesController = PublishSubject<List<CityModel>?>();
  get citiesStream => _citiesController.stream;

  final _isLoadingController = PublishSubject<bool>();
  get isLoadingStream => _isLoadingController.stream;

  clearCitiesList() {
    _citiesController.sink.add(null);
  }

  getCitiesList(BuildContext context, String? countryId) {
    _isLoadingController.sink.add(true);
    ApiCityCountry(context).getCities(countryId).then((webSer) {
      if (webSer != null) {
        if (!_citiesController.isClosed) {
          _citiesController.sink.add(List<CityModel>.from(
              webSer.data.map((x) => CityModel.fromMap(x))));
        }
      }
      if (!_isLoadingController.isClosed) {
        _isLoadingController.sink.add(false);
      }
    });
  }

  void dispose() {
    _citiesController.close();
    _isLoadingController.close();
  }
}
