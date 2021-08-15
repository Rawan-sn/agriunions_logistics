import 'package:agriunions_logistics/models/branch_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:agriunions_logistics/providers/api_branch.dart';
import 'package:rxdart/rxdart.dart';

class BranchBloc {
  final _branchController = PublishSubject<List<BranchesModel>?>();
  get branchStream => _branchController.stream;

  final _isLoadingController = PublishSubject<bool>();
  get isLoadingStream => _isLoadingController.stream;

  clearBranchList() {
    _branchController.sink.add(null);
  }

  getBranchList(BuildContext context) {
    _isLoadingController.sink.add(true);
    ApiBranch(context).getBranches().then((webSer) {
      if (webSer != null) {
        if (!_branchController.isClosed) {
          _branchController.sink.add(List<BranchesModel>.from(
              webSer.data.map((x) => BranchesModel.fromMap(x))));
        }
      }
      if (!_isLoadingController.isClosed) {
        _isLoadingController.sink.add(false);
      }
    });
  }

  void dispose() {
    _branchController.close();
    _isLoadingController.close();
  }
}
