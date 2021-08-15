import 'package:flutter/material.dart';

import 'package:agriunions_logistics/Localization/AppLocal.dart';
import 'package:agriunions_logistics/blocs/find_user_bloc.dart';
import 'package:agriunions_logistics/helper/AppColors.dart';
import 'package:agriunions_logistics/helper/enums.dart';
import 'package:agriunions_logistics/models/user_model.dart';
import 'package:agriunions_logistics/user_interfaces/widget/general_widget.dart';

class FindUserBottomSheet extends StatefulWidget {
  final UserTypes? userTypes;
  const FindUserBottomSheet(this.userTypes);
  @override
  _FindUserBottomSheetState createState() => _FindUserBottomSheetState();
}

class _FindUserBottomSheetState extends State<FindUserBottomSheet> {
  FindUsersBloc _bloc = FindUsersBloc();
  
  @override
  void dispose() {
    _bloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      padding: MediaQuery.of(context).viewInsets,
      duration: const Duration(milliseconds: 300),
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
              color: AppColors.Russet,
            ),
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height / 10,
            child: Center(
              child: TextFormField(
                textAlign: TextAlign.center,
                onChanged: (term) {
                  if (term.length >= 3) {
                    _bloc.clearSubUsers();
                    _bloc.findUsers(context, term, type: widget.userTypes);
                  }else{
                    _bloc.emptySubUsers();
                  }
                },
                style: TextStyle(color: AppColors.white),
                decoration: new InputDecoration(
                  border: InputBorder.none,
                  prefixIcon: new Icon(Icons.search, color: AppColors.white),
                  hintText:
                      AppLocalizations.of(context)!.trans('search_for_user'),
                  hintStyle: new TextStyle(color: Colors.grey, height: 1.2),
                ),
              ),
            ),
          ),
          Expanded(
            child: StreamBuilder<List<UserModel>?>(
              stream: _bloc.findUserStream,
              initialData: [],
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  if (snapshot.data!.length != 0) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ListView.builder(
                        shrinkWrap: true,
                        primary: false,
                        itemCount: snapshot.data!.length,
                        itemBuilder: (BuildContext context, int index) {
                          return InkWell(
                            child: Padding(
                              padding: EdgeInsets.only(
                                top: 4,
                                bottom: 4,
                              ),
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(25),
                                  boxShadow: kElevationToShadow[1],
                                  color: Colors.white,
                                ),
                                child: Padding(
                                  padding: EdgeInsets.all(16),
                                  child: Center(
                                    child: Text(
                                      snapshot.data![index].name!,
                                      style: TextStyle(
                                        fontSize:
                                            MediaQuery.of(context).size.width /
                                                20,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            onTap: () =>
                                Navigator.pop(context, snapshot.data![index]),
                          );
                        },
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
                                image:
                                    AssetImage("assets/images/oops_data.png")),
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
          )
        ],
      ),
    );
  }
}
