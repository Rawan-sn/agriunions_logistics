import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:agriunions_logistics/Localization/AppLocal.dart';
import 'package:agriunions_logistics/helper/AppColors.dart';
import 'package:agriunions_logistics/helper/data_store.dart';
import 'package:agriunions_logistics/helper/general_func.dart';
import 'package:agriunions_logistics/models/create_models/search_filter_model.dart';
import 'package:agriunions_logistics/user_interfaces/dialogs&bottom_sheets/show_bottom_sheets.dart';

class SearchFilterDialog extends StatefulWidget {
  final SearchFilterModel? filterModel;
  SearchFilterDialog({this.filterModel});
  @override
  _SearchFilterDialogState createState() => _SearchFilterDialogState();
}

class _SearchFilterDialogState extends State<SearchFilterDialog> {
  SearchFilterModel? _filterModel = SearchFilterModel();
  @override
  void initState() {
    if (widget.filterModel == null) {
      _filterModel!.fromDate = DateTime.now();
      _filterModel!.toDate = DateTime.now();
    } else {
      _filterModel = widget.filterModel;
    }
    _filterModel!.country = dataStore.country;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
          side: BorderSide(color: AppColors.Russet1)),
      elevation: 0,
      child: contentBox(context),
    );
  }

  contentBox(context) {
    return Stack(
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(right: 10, left: 10, bottom: 8),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Text(
                    AppLocalizations.of(context)!.trans("search_filter")!,
                    style: TextStyle(
                        color: AppColors.Russet1,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Divider(
                  color: AppColors.Russet1,
                  thickness: 2,
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
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
                              initialDate: _filterModel!.fromDate!,
                              firstDate: DateTime(2010),
                              lastDate: DateTime(2100),
                            ).then((date) {
                              if (date != null) {
                                setState(() {
                                  _filterModel!.fromDate = date;
                                  if (_filterModel!.toDate!
                                          .difference(date)
                                          .inDays <
                                      0) {
                                    _filterModel!.toDate = date;
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
                                    GeneralFanc.dateformatedFromDate(
                                        _filterModel!.fromDate!),
                                    style: TextStyle(color: AppColors.Russet),
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
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
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
                              initialDate: _filterModel!.toDate!,
                              firstDate: DateTime(2010),
                              lastDate: DateTime(2100),
                            ).then((date) {
                              if (date != null) {
                                setState(() {
                                  _filterModel!.toDate = date;
                                  if (date
                                          .difference(_filterModel!.fromDate!)
                                          .inDays <
                                      0) {
                                    setState(() {
                                      _filterModel!.fromDate = date;
                                    });
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
                                    GeneralFanc.dateformatedFromDate(
                                        _filterModel!.toDate!),
                                    style: TextStyle(color: AppColors.Russet),
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
                InkWell(
                  onTap: () {
                    ShowBottomSheets.selectCity(context, (selectedCity) {
                      setState(() {
                        _filterModel!.departureCity = selectedCity;
                      });
                    });
                  },
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
                            _filterModel!.departureCity?.name ??
                                AppLocalizations.of(context)!
                                    .trans("departure_city")!,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: _filterModel?.departureCity == null
                                  ? Colors.grey
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
                SizedBox(height: 5),
                InkWell(
                  onTap: () {
                    ShowBottomSheets.selectCity(context, (selectedCity) {
                      setState(() {
                        _filterModel!.destinationCity = selectedCity;
                      });
                    });
                  },
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
                              _filterModel!.destinationCity?.name ??
                                  AppLocalizations.of(context)!
                                      .trans("destination_city")!,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: _filterModel?.destinationCity == null
                                    ? Colors.grey
                                    : AppColors.Russet,
                              )),
                          Icon(
                            Icons.keyboard_arrow_down_sharp,
                            color: AppColors.Russet,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () => Navigator.pop(context, _filterModel),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(
                        Icons.search,
                        color: AppColors.white,
                      ),
                      SizedBox(width: 5),
                      Text(
                        AppLocalizations.of(context)!.trans("search")!,
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: AppColors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
