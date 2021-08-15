import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:agriunions_logistics/Localization/AppLocal.dart';
import 'package:agriunions_logistics/blocs/list_link_requests_bloc.dart';
import 'package:agriunions_logistics/helper/AppColors.dart';
import 'package:agriunions_logistics/helper/TextSizes.dart';
import 'package:agriunions_logistics/models/link_request_model.dart';
import 'package:agriunions_logistics/user_interfaces/cards/link_request_card.dart';
import 'package:agriunions_logistics/user_interfaces/dialogs&bottom_sheets/show_dialogs.dart';
import 'package:agriunions_logistics/user_interfaces/widget/general_widget.dart';

class ManagementPage extends StatefulWidget {
  @override
  _ManagementPageState createState() => _ManagementPageState();
}

class _ManagementPageState extends State<ManagementPage> {
  LinkRequestsBloc _bloc = LinkRequestsBloc();

  @override
  void initState() {
    _bloc.getLinkRequests(context);
    super.initState();
  }

  @override
  void dispose() {
    _bloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 60,
          title: Text(
            AppLocalizations.of(context)!.trans("management")!,
            style: TextStyle(
              fontSize: TextSizes.text,
            ),
          ),
          flexibleSpace: Container(
            color: Color(0xff7a0808),
          ),
          elevation: 0,
        ),
        body: Column(
          children: [
            InkWell(
              onTap: () {
                ShowDialogs.createLinkRequestsDialog(context).then((value) {
                  if (value ?? false) {
                    _bloc.clearLinkRequests();
                    _bloc.getLinkRequests(context);
                  }
                });
              },
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Container(
                  padding: const EdgeInsets.all(20.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                    boxShadow: kElevationToShadow[3],
                  ),
                  child: Row(
                    children: [
                      Image.asset(
                        "assets/icons/create_link.png",
                        scale: 2.7,
                        color: AppColors.Russet,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12.0),
                        child: Text(
                          AppLocalizations.of(context)!
                              .trans("create_link_request")!,
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w200),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              child: StreamBuilder<List<LinkRequestModel>?>(
                stream: _bloc.linkRequestsStream,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    if (snapshot.data!.length != 0) {
                      return SingleChildScrollView(
                        child: Column(
                          children: [
                            ListView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              primary: false,
                              itemCount: snapshot.data!.length,
                              itemBuilder: (BuildContext context, int index) {
                                return Column(
                                  children: [
                                    LinkRequestCard(
                                      model: snapshot.data![index],
                                      onTap: () {
                                        _bloc.clearLinkRequests();
                                        _bloc.getLinkRequests(context);
                                      },
                                    ),
                                  ],
                                );
                              },
                            ),
                          ],
                        ),
                      );
                    } else {
                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Container(
                              height: 80,
                              width: 80,
                              child: Image(
                                  image: AssetImage(
                                      "assets/images/oops_data.png")),
                            ),
                            SizedBox(height: 20),
                            Text(AppLocalizations.of(context)!
                                .trans('no_data_found')!),
                          ],
                        ),
                      );
                    }
                  }
                  return Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: GeneralWidget.listProgressIndicator(),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
