import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:agriunions_logistics/Localization/AppLocal.dart';
import 'package:agriunions_logistics/blocs/retrieveRequestBloc.dart';
import 'package:agriunions_logistics/helper/AppColors.dart';
import 'package:agriunions_logistics/helper/TextSizes.dart';
import 'package:agriunions_logistics/models/service_provider_requests_model.dart';
import 'package:agriunions_logistics/user_interfaces/cards/service_provider_request_card.dart';
import 'package:agriunions_logistics/user_interfaces/pages/home_page_drawer/register_service_provider_page.dart';
import 'package:agriunions_logistics/user_interfaces/widget/general_widget.dart';

class ServiceProviderRequestsPage extends StatefulWidget {
  @override
  _ServiceProviderRequestsPageState createState() =>
      _ServiceProviderRequestsPageState();
}

class _ServiceProviderRequestsPageState
    extends State<ServiceProviderRequestsPage> {
  ServiceProviderRequestsBloc _bloc = ServiceProviderRequestsBloc();

  @override
  void initState() {
    _bloc.getRequestsList(context);
    super.initState();
  }

  @override
  void dispose() {
    _bloc.dispose();
    super.dispose();
  }

  Future<Null> _refresh() async {
    _bloc.clearRequestsList();
    _bloc.getRequestsList(context);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 60,
          title: Text(
            AppLocalizations.of(context)!.trans("my_requests")!,
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
          child: StreamBuilder<List<ProviderRequestsModel>?>(
            stream: _bloc.requestsStream,
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
                            return ServiceProviderRequestsCard(
                              model: snapshot.data![index],
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
        floatingActionButton: FloatingActionButton.extended(
          backgroundColor: AppColors.Russet1,
          onPressed: () async {
            bool? isSendRequst = await Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => RegisterServiceProvidersPage()),
            );
            if (isSendRequst != null) {
              _refresh();
            }
          },
          icon: Icon(Icons.local_shipping),
          label: Text(AppLocalizations.of(context)!.trans("register")!),
        ),
      ),
    );
  }
}
