import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:agriunions_logistics/Localization/AppLocal.dart';
import 'package:agriunions_logistics/models/create_models/create_branch_model.dart';
import 'package:agriunions_logistics/providers/api_branch.dart';
import 'package:agriunions_logistics/user_interfaces/widget/progress_dialog.dart';
import 'package:agriunions_logistics/user_interfaces/widget/general_widget.dart';

class CreateEditBranchBloc {
  CreateBranchModel model = new CreateBranchModel();

  bool _checkIsValid(BuildContext context) {
    if ((model.localName ?? "").isEmpty || (model.latinName ?? "").isEmpty) {
      Fluttertoast.showToast(
        msg: AppLocalizations.of(context)!.trans("add_branch_name_required")!,
      );
      return false;
    }

    return true;
  }

  createBranch(BuildContext context) {
    if (_checkIsValid(context)) {
      ProgressDialog progressDialog = GeneralWidget.progressDialog(context);
      progressDialog.show().then((value) {
        ApiBranch(context).createBranch(model.toMap()).then((value) {
          progressDialog.hide();
          if (value != null) {
            Fluttertoast.showToast(
                msg: AppLocalizations.of(context)!.trans("success")!);
            Navigator.pop(context, true);
          }
        });
      });
    }
  }

  editBranch(BuildContext context, String? id) {
    if (_checkIsValid(context)) {
      ProgressDialog progressDialog = GeneralWidget.progressDialog(context);
      progressDialog.show().then((value) {
        ApiBranch(context).updateBranch(model.toMap(), id!).then((value) {
          progressDialog.hide();
          if (value != null) {
            Fluttertoast.showToast(
                msg: AppLocalizations.of(context)!.trans("success")!);
            Navigator.pop(context, true);
          }
        });
      });
    }
  }
}
