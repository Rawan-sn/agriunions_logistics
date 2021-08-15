import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:agriunions_logistics/Localization/AppLocal.dart';
import 'package:agriunions_logistics/models/branch_model.dart';

class BranchCard extends StatefulWidget {
  final BranchesModel model;

  BranchCard({
    required this.model,
  });

  @override
  __BranchCardCardState createState() => __BranchCardCardState();
}

class __BranchCardCardState extends State<BranchCard> {
  @override
  Widget build(BuildContext context) {
    return
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
                        AppLocalizations.of(context)!.trans("branch_number")!,
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
                                AppLocalizations.of(context)!.trans("country")! +
                                    ": ",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15.0),
                              ),
                              Text(
                                widget.model.countryName!,
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
                                widget.model.branchName!,
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
      );
  }
}
