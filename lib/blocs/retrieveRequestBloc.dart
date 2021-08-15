import 'package:flutter/cupertino.dart';
import 'package:agriunions_logistics/models/service_provider_requests_model.dart';
import 'package:agriunions_logistics/providers/api_register_provider.dart';
import 'package:rxdart/rxdart.dart';

class ServiceProviderRequestsBloc {
  final _requestsController = PublishSubject<List<ProviderRequestsModel>?>();
  get requestsStream => _requestsController.stream;

  final _isLoadingController = PublishSubject<bool>();
  get isLoadingStream => _isLoadingController.stream;

  clearRequestsList() {
    _requestsController.sink.add(null);
  }

  getRequestsList(BuildContext context) {
    _isLoadingController.sink.add(true);
    ApiRegisterProvider(context)
        .retrieveServiceProviderRequests()
        .then((webSer) {
      if (webSer != null) {
        if (!_requestsController.isClosed) {
          _requestsController.sink.add(List<ProviderRequestsModel>.from(
              webSer.data.map((x) => ProviderRequestsModel.fromMap(x))));
        }
      }
      if (!_isLoadingController.isClosed) {
        _isLoadingController.sink.add(false);
      }
    });
  }

  void dispose() {
    _requestsController.close();
    _isLoadingController.close();
  }
}
