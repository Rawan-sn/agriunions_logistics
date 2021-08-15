import 'package:flutter/cupertino.dart';
import 'package:agriunions_logistics/helper/enums.dart';
import 'package:agriunions_logistics/models/user_model.dart';
import 'package:agriunions_logistics/providers/api_users.dart';
import 'package:rxdart/rxdart.dart';

class FindUsersBloc {
  List<UserModel> subUsers = [];
  final _findUserController = PublishSubject<List<UserModel>?>();
  get findUserStream => _findUserController.stream;

  final _isLoadingController = PublishSubject<bool>();
  get isLoadingStream => _isLoadingController.stream;

  clearSubUsers() {
    _findUserController.sink.add(null);
  }

  emptySubUsers() {
    _findUserController.sink.add([]);
  }

  findUsers(BuildContext context, String keyword, {UserTypes? type}) {
    print("********** findUsers **********");
    _isLoadingController.sink.add(true);
    ApiUsers(context).findUser(keyword, type).then((webSer) {
      if (webSer != null) {
        if (!_findUserController.isClosed) {
          _findUserController.sink.add(List<UserModel>.from(
              webSer.data.map((x) => UserModel.fromMap(x))));
        }

        if (!_isLoadingController.isClosed) {
          _isLoadingController.sink.add(false);
        }
      }
    });
  }

  void dispose() {
    _findUserController.close();
    _isLoadingController.close();
  }
}
