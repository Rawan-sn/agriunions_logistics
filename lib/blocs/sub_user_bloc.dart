import 'package:flutter/cupertino.dart';
import 'package:agriunions_logistics/models/sub_user_model.dart';
import 'package:agriunions_logistics/providers/api_users.dart';
import 'package:rxdart/rxdart.dart';

class SubUsersBloc {
  List<SubUserModel> subUsers = [];
  int page = 1;
  bool hasNext = true;
  bool loadData = false;

  final _subUserController = PublishSubject<List<SubUserModel>?>();
  get subUserStream => _subUserController.stream;

  final _isLoadingController = PublishSubject<bool>();
  get isLoadingStream => _isLoadingController.stream;

  clearSubUsers() {
    page = 1;
    hasNext = true;
    subUsers.clear();
    _subUserController.sink.add(null);
    loadData = false;
  }

  getSubUsers(BuildContext context) {
    if (!loadData && this.hasNext) {
      loadData = true;
      print("********** getSubUser **********");
      _isLoadingController.sink.add(true);
      ApiUsers(context).getSubUserList(this.page).then((webSer) {
        loadData = false;
        if (webSer != null) {
          subUsers.addAll(List<SubUserModel>.from(
              webSer.data.map((x) => SubUserModel.fromMap(x))));
          if (!_subUserController.isClosed) {
            _subUserController.sink.add(subUsers);
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
    _subUserController.close();
    _isLoadingController.close();
  }
}
