import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:agriunions_logistics/Localization/AppLocal.dart';
import 'package:agriunions_logistics/helper/AppColors.dart';
import 'package:agriunions_logistics/helper/app_constants.dart';
import 'package:place_picker/place_picker.dart';
import 'package:agriunions_logistics/user_interfaces/widget/progress_dialog.dart';

class GeneralWidget {
  static progressIndicator(Stream<bool> isLoadingStream) {
    return StreamBuilder<bool>(
      stream: isLoadingStream,
      initialData: false,
      builder: (context, snapshot) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: new Center(
            child: new Opacity(
              opacity: snapshot.data! ? 1.0 : 00,
              child: new SpinKitCircle(
                color: Colors.yellow[700],
                size: 25,
              ),
            ),
          ),
        );
      },
    );
  }

  static Future<LocationResult?> showPlacePicker(BuildContext context,
      {LatLng? customLocation}) async {
    LocationResult? result = await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => PlacePicker(
          AppConstants.googleMapKey,
          displayLocation: customLocation,
        ),
      ),
    );
    return result;
  }

  static progressDialog(context) {
    ProgressDialog progressDialog =
        ProgressDialog(context, isDismissible: false);
    progressDialog.style(
      message: AppLocalizations.of(context)!.trans('please_wait')!,
      borderRadius: 10.0,
      backgroundColor: Colors.white,
      progressWidget:
          CircularProgressIndicator(backgroundColor: AppColors.Russet),
      elevation: 10.0,
      insetAnimCurve: Curves.easeInOut,
      progress: 0.0,
      maxProgress: 100.0,
      progressTextStyle: TextStyle(
          color: AppColors.Russet, fontSize: 13.0, fontWeight: FontWeight.w400),
      messageTextStyle: TextStyle(
          color: AppColors.Russet, fontSize: 19.0, fontWeight: FontWeight.w600),
    );
    return progressDialog;
  }

  static listProgressIndicator() {
    return Center(
      child: SpinKitCircle(
        color: AppColors.Russet, // Colors.yellow[700]
        size: 40,
      ),
    );
  }
}
