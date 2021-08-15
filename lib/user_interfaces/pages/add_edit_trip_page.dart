import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttericon/entypo_icons.dart';
import 'package:agriunions_logistics/helper/app_constants.dart';
import 'package:agriunions_logistics/models/trip_offer_model.dart';
import 'package:agriunions_logistics/Localization/AppLocal.dart';
import 'package:agriunions_logistics/blocs/create_edit_trip_offer_bloc.dart';
import 'package:agriunions_logistics/helper/AppColors.dart';
import 'package:agriunions_logistics/helper/general_func.dart';
import 'package:agriunions_logistics/models/branch_model.dart';
import 'package:agriunions_logistics/models/city_model.dart';
import 'package:agriunions_logistics/models/vehicle_model.dart';
import 'package:agriunions_logistics/user_interfaces/dialogs&bottom_sheets/show_bottom_sheets.dart';
import 'package:agriunions_logistics/user_interfaces/widget/general_widget.dart';

class AddEditTripPage extends StatefulWidget {
  final TripOfferModel? model;

  AddEditTripPage({this.model});

  @override
  _AddEditTripPageState createState() => _AddEditTripPageState();
}

class _AddEditTripPageState extends State<AddEditTripPage> {
  CreateEditTripOfferBloc bloc = CreateEditTripOfferBloc();
  BranchesModel? branch;
  VehicleModel? vehicle;
  String? rotationType;
  int? rotationFactor = 1;
  DateTime? startDate;
  DateTime? endDate;
  TimeOfDay? fromTime;
  TimeOfDay? toTime;
  CityModel? departureCity;
  CityModel? destinationCity;
  String? departureTitle;
  String? destinationTitle;
  double? departureLat;
  double? departureLong;
  double? destinationLat;
  double? destinationLong;
  TextEditingController? priceController;
  TextEditingController? localDesController;
  TextEditingController? latinDesController;

  @override
  void initState() {
    if (widget.model != null) {
      bloc.model.price = widget.model!.price;
      bloc.model.branchId = widget.model!.branchId;
      bloc.model.vehicleId = widget.model!.vehicleId;
      bloc.model.departureCityId = widget.model!.departureCityId;
      bloc.model.departureLatitude = widget.model!.departureLatitude;
      bloc.model.departureLongitude = widget.model!.departureLongitude;
      bloc.model.localDescription = "";
      bloc.model.latinDescription = widget.model!.description;
      bloc.model.destinationCityId = widget.model!.destinationCityId;
      bloc.model.destinationLatitude = widget.model!.destinationLatitude;
      bloc.model.destinationLongitude = widget.model!.destinationLongitude;
      bloc.model.startDate = widget.model!.startDate;
      bloc.model.endDate = widget.model!.endData;
      bloc.model.startTime = widget.model!.startTime;
      bloc.model.endTime = widget.model!.endTime;
      bloc.model.rotationType = widget.model!.rotationType;
      bloc.model.rotationFactor = widget.model!.rotationFactor;
      branch = BranchesModel(
        id: widget.model!.branchId,
        branchName: widget.model!.branchName,
      );
      vehicle = VehicleModel(
        id: widget.model!.vehicleId,
        name: widget.model!.vehicleName,
      );
      departureCity = CityModel(
        id: widget.model!.departureCityId,
        name: widget.model!.departureCityName,
      );
      destinationCity = CityModel(
        id: widget.model!.destinationCityId,
        name: widget.model!.destinationCityName,
      );
      rotationType = widget.model!.rotationType;
      rotationFactor = widget.model!.rotationFactor;
      departureTitle = widget.model!.departureName;
      destinationTitle = widget.model!.destinationName;
      destinationLat = double.parse(widget.model!.destinationLatitude!);
      destinationLong = double.parse(widget.model!.destinationLongitude!);
      departureLat = double.parse(widget.model!.departureLatitude!);
      departureLong = double.parse(widget.model!.departureLongitude!);
      priceController = TextEditingController(text: widget.model!.price);
      localDesController = TextEditingController(text: "");
      latinDesController =
          TextEditingController(text: widget.model!.description);
    } else {
      priceController = TextEditingController();
      localDesController = TextEditingController();
      latinDesController = TextEditingController();
    }

    super.initState();
  }

  @override
  void dispose() {
    priceController!.dispose();
    localDesController!.dispose();
    latinDesController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: AppColors.Russet1,
        title: Text(
          widget.model != null
              ? AppLocalizations.of(context)!.trans("edit_trip")!
              : AppLocalizations.of(context)!.trans("add_trip")!,
        ),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 6.0),
                      height: MediaQuery.of(context).size.height / 20,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: kElevationToShadow[1],
                        color: Colors.white,
                      ),
                      child: TextField(
                        onChanged: (price) => bloc.model.price = price,
                        textAlign: TextAlign.center,
                        controller: priceController,
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(
                              RegExp("[0-9]+\.?[0-9]*"))
                        ],
                        style: TextStyle(color: AppColors.Russet),
                        decoration: InputDecoration(
                          focusedBorder: UnderlineInputBorder(
                              borderSide:
                                  BorderSide(color: AppColors.lightOrange)),
                          hintText:
                              AppLocalizations.of(context)!.trans("the_price"),
                        ),
                        autofocus: false,
                      ),
                    ),
                    Divider(height: 25, thickness: 2),
                    InkWell(
                      onTap: () {
                        FocusScope.of(context).unfocus();
                        ShowBottomSheets.selectBranch(context,
                            (selectedBranch) {
                          setState(() {
                            branch = selectedBranch;
                            bloc.model.branchId = selectedBranch.id;
                          });
                        });
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 6.0),
                        height: MediaQuery.of(context).size.height / 20,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: kElevationToShadow[1],
                          color: Colors.white,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              branch?.branchName ??
                                  AppLocalizations.of(context)!.trans("branch")!,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: branch == null
                                    ? Colors.grey[700]
                                    : AppColors.Russet,
                              ),
                            ),
                            Icon(
                              Icons.keyboard_arrow_down_sharp,
                              color: AppColors.Russet,
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    InkWell(
                      onTap: () {
                        FocusScope.of(context).unfocus();
                        ShowBottomSheets.selectVehicle(context,
                            (selectedVehicle) {
                          setState(() {
                            vehicle = selectedVehicle;
                            bloc.model.vehicleId = selectedVehicle.id;
                          });
                        });
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 6.0),
                        height: MediaQuery.of(context).size.height / 20,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: kElevationToShadow[1],
                          color: Colors.white,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              vehicle?.name ??
                                  AppLocalizations.of(context)!.trans("vehicle")!,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: vehicle == null
                                    ? Colors.grey[700]
                                    : AppColors.Russet,
                              ),
                            ),
                            Icon(
                              Icons.keyboard_arrow_down_sharp,
                              color: AppColors.Russet,
                            ),
                          ],
                        ),
                      ),
                    ),
                    Divider(height: 25, thickness: 2),
                    InkWell(
                      onTap: () {
                        FocusScope.of(context).unfocus();
                        ShowBottomSheets.selectRotationType(context,
                            (selectedType) {
                          setState(() {
                            rotationType = selectedType;
                            bloc.model.rotationType = selectedType;
                          });
                        });
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 6.0),
                        height: MediaQuery.of(context).size.height / 20,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: kElevationToShadow[1],
                          color: Colors.white,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              AppLocalizations.of(context)!
                                  .trans(rotationType ?? "trip_cycle")!,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: rotationType == null
                                    ? Colors.grey[700]
                                    : AppColors.Russet,
                              ),
                            ),
                            Icon(
                              Icons.keyboard_arrow_down_sharp,
                              color: AppColors.Russet,
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 6.0, vertical: 10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: kElevationToShadow[1],
                        color: Colors.white,
                      ),
                      child: Column(
                        children: [
                          Text(
                              "${AppLocalizations.of(context)!.trans("rotation_factor")}: $rotationFactor"),
                          Slider(
                            value: rotationFactor!.toDouble(),
                            onChanged: (newRating) {
                              setState(() {
                                rotationFactor = newRating.round();
                                bloc.model.rotationFactor = rotationFactor;
                              });
                            },
                            divisions: 10,
                            min: 1,
                            max: 10,
                            label: "$rotationFactor",
                          ),
                        ],
                      ),
                    ),
                    Divider(height: 25, thickness: 2),
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: kElevationToShadow[1],
                        color: Colors.white,
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            AppLocalizations.of(context)!.trans("from_date")!,
                            style: TextStyle(
                              color: Colors.grey[700],
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(width: 5),
                          Expanded(
                            child: InkWell(
                              onTap: () {
                                FocusScope.of(context).unfocus();
                                showDatePicker(
                                        context: context,
                                        initialDate: DateTime.now(),
                                        firstDate: DateTime(2010),
                                        lastDate: DateTime(2100))
                                    .then((date) {
                                  if (date != null) {
                                    setState(() {
                                      startDate = date;
                                      bloc.model.startDate = AppConstants
                                          .dateFormat1
                                          .format(startDate!);
                                      if (endDate != null) {
                                        if (endDate!.difference(date).inDays <
                                            0) {
                                          endDate = date;
                                          bloc.model.endDate = AppConstants
                                              .dateFormat1
                                              .format(endDate!);
                                        }
                                      }
                                    });
                                  }
                                });
                              },
                              child: Card(
                                color: Colors.grey[100],
                                child: Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Text(
                                        startDate == null
                                            ? AppLocalizations.of(context)!
                                                .trans("not_set")!
                                            : GeneralFanc.dateformatedFromDate(
                                                startDate!),
                                        style: TextStyle(
                                            color: startDate == null
                                                ? Colors.grey[700]
                                                : AppColors.Russet),
                                      ),
                                      Icon(Icons.keyboard_arrow_down)
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 5),
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: kElevationToShadow[1],
                        color: Colors.white,
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            AppLocalizations.of(context)!.trans("to_date")!,
                            style: TextStyle(
                              color: Colors.grey[700],
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(width: 5),
                          Expanded(
                            child: InkWell(
                              onTap: () {
                                FocusScope.of(context).unfocus();
                                showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime(2010),
                                  lastDate: DateTime(2100),
                                ).then((date) {
                                  if (date != null) {
                                    setState(() {
                                      endDate = date;
                                      bloc.model.endDate = AppConstants
                                          .dateFormat1
                                          .format(endDate!);
                                      if (startDate != null) {
                                        if (date.difference(startDate!).inDays <
                                            0) {
                                          setState(() {
                                            startDate = date;
                                            bloc.model.startDate = AppConstants
                                                .dateFormat1
                                                .format(startDate!);
                                          });
                                        }
                                      }
                                    });
                                  }
                                  // isValid();
                                });
                              },
                              child: Card(
                                color: Colors.grey[100],
                                child: Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Text(
                                        endDate == null
                                            ? AppLocalizations.of(context)!
                                                .trans("not_set")!
                                            : GeneralFanc.dateformatedFromDate(
                                                endDate!),
                                        style: TextStyle(
                                            color: endDate == null
                                                ? Colors.grey[700]
                                                : AppColors.Russet),
                                      ),
                                      Icon(Icons.keyboard_arrow_down)
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Divider(height: 25, thickness: 2),
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: kElevationToShadow[1],
                        color: Colors.white,
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            AppLocalizations.of(context)!.trans("from_time")!,
                            style: TextStyle(
                              color: Colors.grey[700],
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(width: 5),
                          Expanded(
                            child: InkWell(
                              onTap: () {
                                FocusScope.of(context).unfocus();
                                showTimePicker(
                                  context: context,
                                  initialTime: TimeOfDay(hour: 1, minute: 0),
                                ).then((time) {
                                  setState(() {
                                    fromTime = time;
                                    bloc.model.startTime = fromTime!.hour
                                            .toString()
                                            .padLeft(2, "0") +
                                        ":" +
                                        fromTime!.minute
                                            .toString()
                                            .padLeft(2, "0");
                                    if (toTime != null) {
                                      if ((toTime!.hour + toTime!.minute / 60.0) <
                                          (fromTime!.hour +
                                              fromTime!.minute / 60.0)) {
                                        toTime = time;
                                        bloc.model.endTime = toTime!.hour
                                                .toString()
                                                .padLeft(2, "0") +
                                            ":" +
                                            toTime!.minute
                                                .toString()
                                                .padLeft(2, "0");
                                      }
                                    }
                                  });
                                });
                              },
                              child: Card(
                                color: Colors.grey[100],
                                child: Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Text(
                                        (fromTime == null)
                                            ? AppLocalizations.of(context)!
                                                .trans("not_set")!
                                            : fromTime!.format(context),
                                        style: TextStyle(
                                            color: fromTime == null
                                                ? Colors.grey[700]
                                                : AppColors.Russet),
                                      ),
                                      Icon(Icons.keyboard_arrow_down)
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 5),
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: kElevationToShadow[1],
                        color: Colors.white,
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            AppLocalizations.of(context)!.trans("to_time")!,
                            style: TextStyle(
                              color: Colors.grey[700],
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(width: 5),
                          Expanded(
                            child: InkWell(
                              onTap: () {
                                FocusScope.of(context).unfocus();
                                showTimePicker(
                                  context: context,
                                  initialTime: TimeOfDay(hour: 1, minute: 0),
                                ).then((time) {
                                  setState(() {
                                    toTime = time;
                                    bloc.model.endTime =
                                        toTime!.hour.toString().padLeft(2, "0") +
                                            ":" +
                                            toTime!.minute
                                                .toString()
                                                .padLeft(2, "0");
                                    if (fromTime != null) {
                                      if ((toTime!.hour + toTime!.minute / 60.0) <
                                          (fromTime!.hour +
                                              fromTime!.minute / 60.0)) {
                                        setState(() {
                                          fromTime = time;
                                          bloc.model.startTime = fromTime!.hour
                                                  .toString()
                                                  .padLeft(2, "0") +
                                              ":" +
                                              fromTime!.minute
                                                  .toString()
                                                  .padLeft(2, "0");
                                        });
                                      }
                                    }
                                  });
                                });
                              },
                              child: Card(
                                color: Colors.grey[100],
                                child: Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Text(
                                        (toTime == null)
                                            ? AppLocalizations.of(context)!
                                                .trans("not_set")!
                                            : toTime!.format(context),
                                        style: TextStyle(
                                            color: toTime == null
                                                ? Colors.grey[700]
                                                : AppColors.Russet),
                                      ),
                                      Icon(Icons.keyboard_arrow_down)
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Divider(height: 25, thickness: 2),
                    InkWell(
                      onTap: () {
                        FocusScope.of(context).unfocus();
                        ShowBottomSheets.selectCity(context, (selectedCity) {
                          setState(() {
                            departureCity = selectedCity;
                            bloc.model.departureCityId = selectedCity.id;
                          });
                        });
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 6.0),
                          height: MediaQuery.of(context).size.height / 12,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: kElevationToShadow[1],
                            color: Colors.white,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  departureCity?.name ??
                                      AppLocalizations.of(context)!
                                          .trans("departure_city")!,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: departureCity == null
                                        ? Colors.grey[700]
                                        : AppColors.Russet,
                                  ),
                                ),
                                Icon(
                                  Icons.keyboard_arrow_down_sharp,
                                  color: AppColors.Russet,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        FocusScope.of(context).unfocus();
                        ShowBottomSheets.selectCity(context, (selectedCity) {
                          setState(() {
                            destinationCity = selectedCity;
                            bloc.model.destinationCityId = selectedCity.id;
                          });
                        });
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 6.0),
                          height: MediaQuery.of(context).size.height / 12,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: kElevationToShadow[1],
                            color: Colors.white,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  destinationCity?.name ??
                                      AppLocalizations.of(context)!
                                          .trans("destination_city")!,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: destinationCity == null
                                        ? Colors.grey[700]
                                        : AppColors.Russet,
                                  ),
                                ),
                                Icon(
                                  Icons.keyboard_arrow_down_sharp,
                                  color: AppColors.Russet,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    Divider(height: 25, thickness: 2),
                    Card(
                      child: Column(
                        children: [
                          SizedBox(height: 10),
                          Text(
                            AppLocalizations.of(context)!
                                .trans("departure_title")!,
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey[600],
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          InkWell(
                            onTap: () => GeneralWidget.showPlacePicker(context)
                                .then((result) {
                              if (result != null) {
                                print("3:${result.formattedAddress}");
                                print("4:${result.city!.name}");
                                print("5:${result.country!.name}");
                                print("6:${result.latLng!.latitude}");
                                print("7:${result.latLng!.longitude}");
                                setState(() {
                                  departureTitle = result.formattedAddress;
                                  departureLat = result.latLng!.latitude;
                                  departureLong = result.latLng!.longitude;
                                  bloc.model.departureLatitude =
                                      "${result.latLng!.latitude}";
                                  bloc.model.departureLongitude =
                                      "${result.latLng!.longitude}";
                                });
                              }
                            }),
                            child: Container(
                              width: double.infinity,
                              child: ListTile(
                                leading: Icon(Entypo.location),
                                title: Text(
                                  departureTitle ??
                                      AppLocalizations.of(context)!
                                          .trans("set_location_on_map")!,
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: departureTitle == null
                                        ? Colors.grey[400]
                                        : Colors.green[600],
                                  ),
                                ),
                                trailing: Icon(Icons.keyboard_arrow_down),
                              ),
                            ),
                          ),
                          Divider(height: 25, thickness: 2),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Expanded(
                                  child: ListTile(
                                title: Text(AppLocalizations.of(context)!
                                    .trans("latitude")!),
                                subtitle: Text("${departureLat ?? ''}"),
                              )),
                              Container(
                                width: 1,
                                height: 30,
                                color: Colors.grey,
                              ),
                              Expanded(
                                  child: ListTile(
                                title: Text(AppLocalizations.of(context)!
                                    .trans("longitude")!),
                                subtitle: Text("${departureLong ?? ''}"),
                              )),
                            ],
                          )
                        ],
                      ),
                    ),
                    Card(
                      child: Column(
                        children: [
                          SizedBox(height: 10),
                          Text(
                            AppLocalizations.of(context)!
                                .trans("destination_title")!,
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey[600],
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          InkWell(
                            onTap: () => GeneralWidget.showPlacePicker(context)
                                .then((result) {
                              if (result != null) {
                                print("3:${result.formattedAddress}");
                                print("4:${result.city!.name}");
                                print("5:${result.country!.name}");
                                print("6:${result.latLng!.latitude}");
                                print("7:${result.latLng!.longitude}");
                                setState(() {
                                  destinationTitle = result.formattedAddress;
                                  destinationLat = result.latLng!.latitude;
                                  destinationLong = result.latLng!.longitude;
                                  bloc.model.destinationLatitude =
                                      "${result.latLng!.latitude}";
                                  bloc.model.destinationLongitude =
                                      "${result.latLng!.longitude}";
                                });
                              }
                            }),
                            child: Container(
                              width: double.infinity,
                              child: ListTile(
                                leading: Icon(Entypo.location),
                                title: Text(
                                  destinationTitle ??
                                      AppLocalizations.of(context)!
                                          .trans("set_location_on_map")!,
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: destinationTitle == null
                                        ? Colors.grey[400]
                                        : Colors.green[600],
                                  ),
                                ),
                                trailing: Icon(Icons.keyboard_arrow_down),
                              ),
                            ),
                          ),
                          Divider(height: 25, thickness: 2),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Expanded(
                                  child: ListTile(
                                title: Text(AppLocalizations.of(context)!
                                    .trans("latitude")!),
                                subtitle: Text("${destinationLat ?? ''}"),
                              )),
                              Container(
                                width: 1,
                                height: 30,
                                color: Colors.grey,
                              ),
                              Expanded(
                                  child: ListTile(
                                title: Text(AppLocalizations.of(context)!
                                    .trans("longitude")!),
                                subtitle: Text("${destinationLong ?? ''}"),
                              )),
                            ],
                          )
                        ],
                      ),
                    ),
                    Divider(height: 25, thickness: 2),
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                                AppLocalizations.of(context)!
                                    .trans("local_description")!,
                                style: TextStyle(color: Colors.grey[600])),
                            TextField(
                              onChanged: (str) {
                                bloc.model.localDescription = str;
                              },
                              controller: localDesController,
                              maxLength: 1000,
                              maxLines: null,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.never,
                                hintText: AppLocalizations.of(context)!
                                    .trans("local_description"),
                              ),
                              autofocus: false,
                            ),
                          ],
                        ),
                      ),
                    ),
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                                AppLocalizations.of(context)!
                                    .trans("latin_description")!,
                                style: TextStyle(color: Colors.grey[600])),
                            TextField(
                              onChanged: (str) {
                                bloc.model.latinDescription = str;
                              },
                              controller: latinDesController,
                              maxLength: 1000,
                              maxLines: null,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.never,
                                hintText: AppLocalizations.of(context)!
                                    .trans("latin_description"),
                              ),
                              autofocus: false,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Container(
            width: double.infinity,
            color: AppColors.Russet,
            child: InkWell(
              onTap: () {
                FocusScope.of(context).unfocus();
                if (widget.model != null) {
                  bloc.editTrip(context, widget.model!.id);
                } else
                  bloc.createTrip(context);
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  widget.model != null
                      ? AppLocalizations.of(context)!.trans("edit_trip")!
                      : AppLocalizations.of(context)!.trans("add_trip")!,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: AppColors.white,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
