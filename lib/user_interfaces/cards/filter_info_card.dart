import 'package:flutter/material.dart';
import 'package:agriunions_logistics/Localization/AppLocal.dart';
import 'package:agriunions_logistics/helper/general_func.dart';

import 'package:agriunions_logistics/models/create_models/search_filter_model.dart';

class FilterInfoCard extends StatelessWidget {
  final SearchFilterModel? filterModel;

  const FilterInfoCard({this.filterModel});

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: filterModel != null &&
          (filterModel?.fromDate != null) &&
          (filterModel?.toDate != null),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "${AppLocalizations.of(context)!.trans("from_date")}: ",
                    ),
                    Text(
                      GeneralFanc.dateformatedFromDate(filterModel!.fromDate!),
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "${AppLocalizations.of(context)!.trans("to_date")}: ",
                    ),
                    Text(
                      GeneralFanc.dateformatedFromDate(filterModel!.toDate!),
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Row(
            children: [
              Visibility(
                visible: filterModel!.departureCity != null,
                child: Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "${AppLocalizations.of(context)!.trans("departure_city")}: ",
                      ),
                      Text(
                        filterModel!.departureCity?.name ?? "",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ),
              Visibility(
                visible: filterModel!.destinationCity != null,
                child: Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "${AppLocalizations.of(context)!.trans("destination_city")}: ",
                      ),
                      Text(
                        filterModel!.destinationCity?.name ?? "",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
