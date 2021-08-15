import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:agriunions_logistics/Localization/AppLocal.dart';
import 'package:agriunions_logistics/blocs/list_link_requests_bloc.dart';
import 'package:agriunions_logistics/helper/TextSizes.dart';
import 'package:agriunions_logistics/models/link_request_model.dart';
import 'package:agriunions_logistics/user_interfaces/cards/link_request_card.dart';
import 'package:agriunions_logistics/user_interfaces/widget/general_widget.dart';

class EmployeePage extends StatefulWidget {
  @override
  _EmployeePageState createState() => _EmployeePageState();
}

class _EmployeePageState extends State<EmployeePage> {
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

  Future<Null> _refresh() async {
    _bloc.clearLinkRequests();
    _bloc.getLinkRequests(context);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 60,
          title: Text(
            AppLocalizations.of(context)!.trans("employees")!,
            style: TextStyle(
              fontSize: TextSizes.text,
            ),
          ),
          flexibleSpace: Container(
            color: Color(0xff7a0808),
          ),
          elevation: 0,
        ),
        body: RefreshIndicator(
          onRefresh: _refresh,
          child: StreamBuilder<List<LinkRequestModel>?>(
            stream: _bloc.linkRequestsStream,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                if (snapshot.data!.length != 0) {
                  return SingleChildScrollView(
                    child: Column(
                      children: [
                        SizedBox(
                          height: 10,
                        ),
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
                              image: AssetImage("assets/images/oops_data.png")),
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
      ),
    );
  }
}
