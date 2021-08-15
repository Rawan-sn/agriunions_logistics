import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:agriunions_logistics/Localization/AppLocal.dart';
import 'package:agriunions_logistics/helper/AppColors.dart';
import 'package:agriunions_logistics/helper/enums.dart';
import 'package:agriunions_logistics/models/vehicle_model.dart';
import 'package:agriunions_logistics/user_interfaces/widget/load_network_image.dart';

class VehicleCard extends StatefulWidget {
  final VehicleModel model;

  VehicleCard({
    required this.model,
  });

  @override
  __VehicleCardState createState() => __VehicleCardState();
}

class __VehicleCardState extends State<VehicleCard> {
  @override
  Widget build(BuildContext context) {
    return


      Stack(
        alignment: Alignment.topCenter,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(
              top: 60 / 2.0,
            ),
            child: Container(
              height: 232.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15.0),
                color: Colors.grey.shade200,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 8.0,
                    offset: Offset(0.0, 5.0),
                  ),
                ],
              ),
              width: double.infinity,
              child: Padding(
                  padding: const EdgeInsets.only(bottom: 15.0),
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        height: 100 / 2,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              AppLocalizations.of(context)!.trans("vehicle_number")!,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16.0,
                                  color: Colors.amber
                              ),
                            ),
                            Text(
                              "${widget.model.number}",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 22.0,
                                  color: Colors.amber
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 5.0,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10.0, right: 10),
                        child: Container(
                          height: 140,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15.0),
                            color: Colors.grey.shade100,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black26,
                                blurRadius: 2.0,
                                offset: Offset(0.0, 1.0),
                              ),
                            ],                            ),
                          child: Padding(
                            padding:
                            const EdgeInsets.symmetric(vertical: 8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Center(
                                  child: Container(
                                    width: 150,
                                    child: Divider(
                                      color: Colors.amberAccent.shade100,
                                      thickness: 1.0,
                                    ),
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,

                                  children: [
                                    Text(
                                      AppLocalizations.of(context)!.trans("classification")! +
                                          ": ",
                                      textAlign: TextAlign.center,

                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15.0),
                                    ),
                                    Text(
                                      widget.model.classification!.name!,
                                      style: TextStyle(
                                          fontSize: 14.0,
                                          color: Colors.black54),
                                    ),
                                  ],
                                ),
                                Center(
                                  child: Container(
                                    width: 150,
                                    child: Divider(
                                      color: Colors.amberAccent.shade100,
                                      thickness: 1.0,
                                    ),
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,

                                  children: [
                                    Text(
                                      AppLocalizations.of(context)!.trans("branch")! +
                                          ": ",
                                      textAlign: TextAlign.center,

                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15.0),
                                    ),
                                    Text(
                                      widget.model.branch!.name!,
                                      style: TextStyle(
                                          fontSize: 14.0,
                                          color: Colors.black54),
                                    ),
                                  ],
                                ),
                                Center(
                                  child: Container(
                                    width: 150,
                                    child: Divider(
                                      color: Colors.amberAccent.shade100,
                                      thickness: 1.0,
                                    ),
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,

                                  children: [
                                    Text(
                                      AppLocalizations.of(context)!.trans("driver")! +
                                          ": ",
                                      textAlign: TextAlign.center,

                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15.0),
                                    ),
                                    Text(
                                      widget.model.user!.userName!,
                                      style: TextStyle(
                                          fontSize: 14.0,
                                          color: Colors.black54),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      )
                    ],
                  )),
            ),
          ),
          Container(
            width: 70,
            height: 70,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.grey.shade100,
              boxShadow: [
                BoxShadow(
                  color: Colors.amber.shade200,
                  blurRadius: 4.0,
                  offset: Offset(0, 1),
                ),
              ],
            ),
            child: Padding(
              padding: EdgeInsets.all(4.0),
              child: Center(
                child: Container(
                  child:  LoadNetworkImage(
                    src: widget.model.attachments!.isNotEmpty
                        ? widget.model.attachments?.first
                        : null,
                    errorAssetsType: ErrorAssetsType.vehicle,
                    fit: BoxFit.cover,
                    width: MediaQuery.of(context).size.width / 4.2,
                    height: MediaQuery.of(context).size.width / 4.2,
                  ),
                ),
              ),
            ),
          ),
        ],
      );










      Padding(
      padding: const EdgeInsets.all(10.0),
      child:

      Padding(
        padding: const EdgeInsets.symmetric(horizontal:20.0,vertical: 8),
        child: Container(
          height: 140.0,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15.0),
            color: Colors.grey.shade200,
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 8.0,
                offset: Offset(0.0, 5.0),
              ),
            ],
          ),
          width: MediaQuery.of(context).size.width/1.2,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 4),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        AppLocalizations.of(context)!.trans("vehicle_number")!,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16.0,
                            color: Colors.amber
                        ),
                      ),
                      Text(
                        "${widget.model.number}",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 22.0,
                            color: Colors.amber
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 5.0,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10.0, right: 10),
                  child: Container(
                    height: 80,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15.0),
                      color: Colors.grey.shade100,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 2.0,
                          offset: Offset(0.0, 1.0),
                        ),
                      ],                            ),
                    child: Padding(
                      padding:
                      const EdgeInsets.symmetric(vertical: 8.0,horizontal: 4),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                AppLocalizations.of(context)!.trans("vehicle_name")! +
                                    ": ",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15.0),
                              ),
                              Text(
                                widget.model.name!,
                                style: TextStyle(
                                    fontSize: 14.0,
                                    color: Colors.black54),
                              ),
                            ],
                          ),
                          Center(
                            child: Container(
                              width: 150,
                              child: Divider(
                                color: Colors.amberAccent.shade100,
                                thickness: 1.0,
                              ),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,

                            children: [
                              Text(
                                AppLocalizations.of(context)!.trans("classification")! +
                                    ": ",
                                textAlign: TextAlign.center,

                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15.0),
                              ),
                              Text(
                                widget.model.classification!.name!,
                                style: TextStyle(
                                    fontSize: 14.0,
                                    color: Colors.black54),
                              ),
                            ],
                          ),
                          Center(
                            child: Container(
                              width: 150,
                              child: Divider(
                                color: Colors.amberAccent.shade100,
                                thickness: 1.0,
                              ),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,

                            children: [
                              Text(
                                AppLocalizations.of(context)!.trans("branch")! +
                                    ": ",
                                textAlign: TextAlign.center,

                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15.0),
                              ),
                              Text(
                                widget.model.branch!.name!,
                                style: TextStyle(
                                    fontSize: 14.0,
                                    color: Colors.black54),
                              ),
                            ],
                          ),
                          Center(
                            child: Container(
                              width: 150,
                              child: Divider(
                                color: Colors.amberAccent.shade100,
                                thickness: 1.0,
                              ),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,

                            children: [
                              Text(
                                AppLocalizations.of(context)!.trans("driver")! +
                                    ": ",
                                textAlign: TextAlign.center,

                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15.0),
                              ),
                              Text(
                                widget.model.user!.userName!,
                                style: TextStyle(
                                    fontSize: 14.0,
                                    color: Colors.black54),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      )



























    );
  }
}
/*
 Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height / 5,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          boxShadow: kElevationToShadow[1],
          color: Colors.white,
        ),
        child: Row(
          children: [
            SizedBox(
              width: 5,
            ),
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: AppColors.Russet),
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    topRight: Radius.circular(20)),
                boxShadow: kElevationToShadow[4],
                color: Colors.white,
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    topRight: Radius.circular(20)),
                child: LoadNetworkImage(
                  src: widget.model.attachments!.isNotEmpty
                      ? widget.model.attachments?.first
                      : null,
                  errorAssetsType: ErrorAssetsType.vehicle,
                  fit: BoxFit.cover,
                  width: MediaQuery.of(context).size.width / 4.2,
                  height: MediaQuery.of(context).size.width / 4.2,
                ),
              ),
            ),
            SizedBox(
              width: 15,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 50.0),
                  child: Text(
                    AppLocalizations.of(context)!.trans("number")! +
                        ":${widget.model.number}",
                    style: TextStyle(color: AppColors.Russet),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Center(
                    child: Container(
                      width: 150,
                      child: Divider(
                        color: AppColors.Russet1,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(3.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 3.4,
                        child: Text(
                          widget.model.name!,
                          style: TextStyle(fontWeight: FontWeight.w300),
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 3.4,
                        child: Text(
                          widget.model.classification!.name!,
                          style: TextStyle(fontWeight: FontWeight.w200),
                        ),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(3.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 3.4,
                        child: Text(
                          AppLocalizations.of(context)!.trans("driver_name")! +
                              ":",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 3.4,
                        child: Text(
                          widget.model.user!.userName!,
                          style: TextStyle(fontWeight: FontWeight.w200),
                        ),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(3.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 3.4,
                        child: Text(
                          AppLocalizations.of(context)!.trans("branch")! + ":",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 3.4,
                        child: Text(
                          widget.model.branch!.name!,
                          style: TextStyle(fontWeight: FontWeight.w200),
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 8,
                ),
              ],
            ),
          ],
        ),
      ),
 */