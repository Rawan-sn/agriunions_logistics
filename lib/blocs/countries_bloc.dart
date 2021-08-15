import 'package:flutter/cupertino.dart';
import 'package:agriunions_logistics/models/country_model.dart';
import 'package:agriunions_logistics/providers/api_city_country.dart';
import 'package:rxdart/rxdart.dart';

class CountriesBloc {
  final _countriesController = PublishSubject<List<CountryModel>?>();
  get countriesStream => _countriesController.stream;

  final _isLoadingController = PublishSubject<bool>();
  get isLoadingStream => _isLoadingController.stream;

  clearCountriesList() {
    _countriesController.sink.add(null);
  }

  getCountriesList(BuildContext context) {
    _isLoadingController.sink.add(true);
    ApiCityCountry(context).getCountries().then((webSer) {
      if (webSer != null) {
        if (!_countriesController.isClosed) {
          _countriesController.sink.add(List<CountryModel>.from(
              webSer.data.map((x) => CountryModel.fromMap(x))));
        }
      }
      if (!_isLoadingController.isClosed) {
        _isLoadingController.sink.add(false);
      }
    });
  }

  void dispose() {
    _countriesController.close();
    _isLoadingController.close();
  }
}
