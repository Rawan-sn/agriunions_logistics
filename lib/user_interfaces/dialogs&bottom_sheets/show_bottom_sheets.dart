import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:agriunions_logistics/helper/enums.dart';
import 'package:agriunions_logistics/models/branch_model.dart';
import 'package:agriunions_logistics/models/city_model.dart';
import 'package:agriunions_logistics/models/classification_model.dart';
import 'package:agriunions_logistics/models/country_model.dart';
import 'package:agriunions_logistics/models/create_models/search_filter_model.dart';
import 'package:agriunions_logistics/models/sub_user_model.dart';
import 'package:agriunions_logistics/models/trip_offer_model.dart';
import 'package:agriunions_logistics/models/user_model.dart';
import 'package:agriunions_logistics/models/vehicle_model.dart';
import 'package:agriunions_logistics/user_interfaces/dialogs&bottom_sheets/bottom_sheets/branch_bottom_sheet.dart';
import 'package:agriunions_logistics/user_interfaces/dialogs&bottom_sheets/bottom_sheets/cities_bottom_sheet.dart';
import 'package:agriunions_logistics/user_interfaces/dialogs&bottom_sheets/bottom_sheets/classification_bottom_sheet.dart';
import 'package:agriunions_logistics/user_interfaces/dialogs&bottom_sheets/bottom_sheets/countries_bottom_sheet.dart';
import 'package:agriunions_logistics/user_interfaces/dialogs&bottom_sheets/bottom_sheets/find_user_bottom_sheet.dart';
import 'package:agriunions_logistics/user_interfaces/dialogs&bottom_sheets/bottom_sheets/rotation_type_bottom_sheet.dart';
import 'package:agriunions_logistics/user_interfaces/dialogs&bottom_sheets/bottom_sheets/trips_bottom_sheet.dart';
import 'package:agriunions_logistics/user_interfaces/dialogs&bottom_sheets/bottom_sheets/vehicles_bottom_sheet.dart';

import 'bottom_sheets/status_trip_bootom_sheet.dart';
import 'bottom_sheets/sub_user_bottom_sheet.dart';

class ShowBottomSheets {
  static selectCountry(
      BuildContext context, void completation(CountryModel country)) async {
    final CountryModel? country = await showModalBottomSheet(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
        ),
        context: context,
        builder: (context) {
          return CountriesBottomSheet();
        });
    if (country != null) completation(country);
  }

  static selectCity(BuildContext context,
      void completation(CityModel city)) async {
    final CityModel? city = await showModalBottomSheet(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
        ),
        context: context,
        builder: (context) {
          return CitiesBottomSheet();
        });
    if (city != null) completation(city);
  }

  static selectBranch(
      BuildContext context, void completation(BranchesModel branches)) async {
    final BranchesModel? branche = await showModalBottomSheet(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
        ),
        context: context,
        builder: (context) {
          return BranchBottomSheet();
        });
    if (branche != null) completation(branche);
  }

  static selectTrip(BuildContext context, SearchFilterModel? filterModel,
      void completation(TripOfferModel trip)) async {
    final TripOfferModel? tripOfferModel = await showModalBottomSheet(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
        ),
        context: context,
        builder: (context) {
          return TripsBottomSheet(filterModel: filterModel);
        });
    if (tripOfferModel != null) completation(tripOfferModel);
  }

  static selectVehicle(
      BuildContext context, void completation(VehicleModel vehicle)) async {
    final VehicleModel? vehicle = await showModalBottomSheet(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
        ),
        context: context,
        builder: (context) {
          return VehiclesBottomSheet();
        });
    if (vehicle != null) completation(vehicle);
  }

  static selectRotationType(
      BuildContext context, void completation(String rotationType)) async {
    final String? rotationType = await showModalBottomSheet(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
        ),
        context: context,
        builder: (context) {
          return RotationTypeBottomSheet();
        });
    if (rotationType != null) completation(rotationType);
  }

  static selectClassification(BuildContext context,
      void completation(ClassificationModel classification)) async {
    final ClassificationModel? classification = await showModalBottomSheet(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
        ),
        context: context,
        builder: (context) {
          return ClassificationBottomSheet();
        });
    if (classification != null) completation(classification);
  }

  static selectStatusTrip(
      BuildContext context, void completation(String? state)) async {
    final String? stateType = await showModalBottomSheet(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
        ),
        context: context,
        builder: (context) {
          return StatusTripBottomSheet();
        });
    if (stateType != null) completation(stateType);
  }

  static selectSubUser(BuildContext context,
      void completation(SubUserModel subUserModel)) async {
    final SubUserModel? model = await showModalBottomSheet(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
        ),
        context: context,
        builder: (context) {
          return SubUserBottomSheet();
        });
    if (model != null) completation(model);
  }

  static selectUser(
      BuildContext context,
      void completation(UserModel? userModel), {
        UserTypes? userTypes,
      }) async {
    final UserModel? model = await showModalBottomSheet(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
        ),
        context: context,
        builder: (context) {
          return FindUserBottomSheet(userTypes);
        });
    if (model != null) completation(model);
  }

}
