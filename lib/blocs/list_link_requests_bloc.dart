import 'package:flutter/cupertino.dart';
import 'package:agriunions_logistics/models/link_request_model.dart';
import 'package:agriunions_logistics/providers/api_users.dart';
import 'package:rxdart/rxdart.dart';

class LinkRequestsBloc {
  List<LinkRequestModel> _linkRequest = [];
  int page = 1;
  bool hasNext = true;
  bool loadData = false;

  final _linkRequestsController = PublishSubject<List<LinkRequestModel>?>();
  get linkRequestsStream => _linkRequestsController.stream;

  final _isLoadingController = PublishSubject<bool>();
  get isLoadingStream => _isLoadingController.stream;

  clearLinkRequests() {
    page = 1;
    hasNext = true;
    _linkRequest.clear();
    _linkRequestsController.sink.add(null);
    loadData = false;
  }

  getLinkRequests(BuildContext context) {
    if (!loadData && this.hasNext) {
      loadData = true;
      print("********** getLinkRequest **********");
      _isLoadingController.sink.add(true);
      ApiUsers(context).getLinkRequestsList(this.page).then((webSer) {
        loadData = false;
        if (webSer != null) {
          _linkRequest.addAll(List<LinkRequestModel>.from(
              webSer.data.map((x) => LinkRequestModel.fromMap(x))));
          if (!_linkRequestsController.isClosed) {
            _linkRequestsController.sink.add(_linkRequest);
          }
          if (webSer.pagination!.currentPage! <
              webSer.pagination!.totalPages!) {
            this.hasNext = true;
            this.page++;
          } else {
            this.hasNext = false;
          }
          if (!_isLoadingController.isClosed) {
            _isLoadingController.sink.add(false);
          }
        }
      });
    }
  }

  void dispose() {
    _linkRequestsController.close();
    _isLoadingController.close();
  }
}
