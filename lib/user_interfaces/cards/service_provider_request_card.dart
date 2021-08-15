import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:agriunions_logistics/Localization/AppLocal.dart';
import 'package:agriunions_logistics/helper/AppColors.dart';

import 'package:agriunions_logistics/models/service_provider_requests_model.dart';
import 'package:agriunions_logistics/user_interfaces/pages/general/image_view.dart';
import 'package:agriunions_logistics/user_interfaces/widget/description_text_widget.dart';
import 'package:agriunions_logistics/user_interfaces/widget/load_network_image.dart';
import 'package:agriunions_logistics/helper/general_func.dart';

class ServiceProviderRequestsCard extends StatefulWidget {
  final ProviderRequestsModel model;
  ServiceProviderRequestsCard({
    required this.model,
  });

  @override
  __ServiceProviderRequestsCardState createState() =>
      __ServiceProviderRequestsCardState();
}

class __ServiceProviderRequestsCardState
    extends State<ServiceProviderRequestsCard> {
  bool show = false;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey.shade200,
          boxShadow: kElevationToShadow[2],
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.only(top: 5, left: 10, right: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              new Container(
                child:
                    new DescriptionTextWidget(text: widget.model.description),
              ),
              Text(
                "${AppLocalizations.of(context)!.trans('created_at')}: ${GeneralFanc.dateformated(widget.model.createdAt)}",
                style: TextStyle(
                  color: Colors.grey[600],
                  fontSize: 14,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(
                        Icons.access_time,
                        size: MediaQuery.of(context).size.width / 18,
                      ),
                    ),
                    Text(
                      AppLocalizations.of(context)!.trans(widget.model.status)!,
                      style:
                          TextStyle(fontSize: 15, color: AppColors.Russet), //12
                    ),
                  ]),
                  Visibility(
                    visible: widget.model.attachments!.isNotEmpty,
                    child: IconButton(
                        icon:
                            Icon(!show ? Icons.expand_more : Icons.expand_less,color: AppColors.Russet1,),
                        onPressed: () {
                          show = !show;
                          setState(() {});
                        }),
                  ),
                ],
              ),
              Visibility(
                visible: show,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                  height: MediaQuery.of(context).size.height / 5,
                  child: GridView.builder(
                    shrinkWrap: true,
                    itemCount: widget.model.attachments!.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3),
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            CupertinoPageRoute(
                              fullscreenDialog: true,
                              builder: (context) => ImageView(
                                imagePath: widget.model.attachments![index],
                                isNetworkUrl: true,
                              ),
                            ),
                          );
                        },
                        child: Padding(
                          padding: EdgeInsets.all(6),
                          child: Container(
                            decoration: new BoxDecoration(
                              color: Colors.grey.shade200,
                              boxShadow: kElevationToShadow[2],
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(30),
                              child: LoadNetworkImage(
                                  src: widget.model.attachments![index]),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
