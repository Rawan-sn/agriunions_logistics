import 'package:flutter/material.dart';
import 'package:fluttericon/entypo_icons.dart';
import 'package:agriunions_logistics/Localization/AppLocal.dart';
import 'package:agriunions_logistics/blocs/LogoutBloc.dart';
import 'package:agriunions_logistics/helper/AppColors.dart';
import 'package:agriunions_logistics/helper/app_permissions.dart';
import 'package:agriunions_logistics/helper/data_store.dart';
import 'package:agriunions_logistics/main.dart';
import 'package:agriunions_logistics/providers/api_general_data.dart';
import 'package:agriunions_logistics/user_interfaces/dialogs&bottom_sheets/show_bottom_sheets.dart';
import 'package:agriunions_logistics/user_interfaces/dialogs&bottom_sheets/show_dialogs.dart';
import 'package:agriunions_logistics/user_interfaces/pages/home_page_drawer/branch_page.dart';
import 'package:agriunions_logistics/user_interfaces/pages/home_page_drawer/employee_page.dart';
import 'package:agriunions_logistics/user_interfaces/pages/home_page_drawer/login_page.dart';
import 'package:agriunions_logistics/user_interfaces/pages/home_page_drawer/profile_page.dart';
import 'package:agriunions_logistics/user_interfaces/pages/home_page_drawer/service_provider_requests_page.dart';
import 'package:agriunions_logistics/user_interfaces/pages/home_page_drawer/today_trips_page.dart';
import 'package:agriunions_logistics/user_interfaces/pages/home_page_drawer/trip_tab_page.dart';
import 'package:agriunions_logistics/user_interfaces/pages/home_page_drawer/vehicles_page.dart';
import 'package:agriunions_logistics/user_interfaces/widget/general_widget.dart';
import 'package:agriunions_logistics/user_interfaces/widget/progress_dialog.dart';

import 'management_page.dart';

class HomePageDrawer extends StatefulWidget {
  @override
  _HomePageDrawerState createState() => _HomePageDrawerState();
}

class _HomePageDrawerState extends State<HomePageDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Column(
                children: <Widget>[
                  Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height / 2.9,
                      color: AppColors.Russet,
                      child: Center(
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            Visibility(
                              visible: AppPermissions.isLogged(),
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    top: 25, right: 3, left: 3),
                                child: Align(
                                    alignment: dataStore.lang == 'ar'
                                        ? Alignment.topRight
                                        : Alignment.topLeft,
                                    child: IconButton(
                                        onPressed: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      ProfilePage()));
                                        },
                                        icon: Icon(Icons.edit,
                                            color: Colors.white))),
                              ),
                            ),
                            Column(
                              // mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                // SizedBox(
                                //   height:
                                //       MediaQuery.of(context).size.height / 8,
                                // ),
                                Expanded(child: Container()),
                                Image.asset(
                                  'assets/images/profile.png',
                                  width:
                                      MediaQuery.of(context).size.height / 7.5,
                                  height:
                                      MediaQuery.of(context).size.height / 7.5,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 8.0),
                                  child: Text(
                                    dataStore.authUser?.user?.name ??
                                        AppLocalizations.of(context)!
                                            .trans("username")!,
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 14),
                                  ),
                                ),
                                Visibility(
                                  visible:
                                      dataStore.authUser?.user?.mobile != null,
                                  child: Padding(
                                    padding: const EdgeInsets.only(top: 2.0),
                                    child: Text(
                                      dataStore.authUser?.user?.mobile ??
                                          AppLocalizations.of(context)!
                                              .trans("mobile")!,
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 14),
                                    ),
                                  ),
                                ),
                                Visibility(
                                  visible: dataStore.authUser != null,
                                  child: Padding(
                                    padding: const EdgeInsets.only(top: 2.0),
                                    child: Text(
                                      dataStore.authUser?.user?.email ??
                                          AppLocalizations.of(context)!
                                              .trans("email")!,
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 14),
                                    ),
                                  ),
                                ),
                                Visibility(
                                  visible: AppPermissions
                                      .isCanChangeOnlineOfflineStatus(),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Expanded(
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Radio(
                                              value: 1,
                                              groupValue: (dataStore.authUser
                                                          ?.user?.online ??
                                                      false)
                                                  ? 1
                                                  : 0,
                                              onChanged: (dynamic value) {
                                                if (!(dataStore.authUser?.user
                                                        ?.online ??
                                                    false)) {
                                                  ProgressDialog
                                                      progressDialog =
                                                      GeneralWidget
                                                          .progressDialog(
                                                              context);
                                                  progressDialog
                                                      .show()
                                                      .then((_) {
                                                    ApiGeneralData(context)
                                                        .setOnline(value)
                                                        .then((data) {
                                                      progressDialog.hide();
                                                      if (data != null) {
                                                        MyApp.restartApp(
                                                            context);
                                                      }
                                                    });
                                                  });
                                                }
                                              },
                                              activeColor: Colors.green,
                                            ),
                                            Text(
                                              "online",
                                              style: TextStyle(
                                                color: AppColors.white,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Expanded(
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Radio(
                                              value: 0,
                                              groupValue: (dataStore.authUser
                                                          ?.user?.online ??
                                                      false)
                                                  ? 1
                                                  : 0,
                                              onChanged: (dynamic value) {
                                                if (dataStore.authUser?.user
                                                        ?.online ??
                                                    false) {
                                                  ProgressDialog
                                                      progressDialog =
                                                      GeneralWidget
                                                          .progressDialog(
                                                              context);
                                                  progressDialog
                                                      .show()
                                                      .then((_) {
                                                    ApiGeneralData(context)
                                                        .setOnline(value)
                                                        .then((data) {
                                                      progressDialog.hide();
                                                      if (data != null) {
                                                        MyApp.restartApp(
                                                            context);
                                                      }
                                                    });
                                                  });
                                                }
                                              },
                                              activeColor: Colors.yellow[700],
                                            ),
                                            Text(
                                              "offline",
                                              style: TextStyle(
                                                color: AppColors.white,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      )),
                  ListTile(
                    leading: Icon(
                      Entypo.flag,
                      color: Colors.black54,
                      size: 26,
                    ),
                    title: Text(
                      dataStore.country?.name ??
                          AppLocalizations.of(context)!.trans('choose_country')!,
                      style: TextStyle(
                        fontSize: 15,
                        color: dataStore.country != null
                            ? AppColors.Russet
                            : AppColors.lightGray2,
                      ),
                    ),
                    onTap: () {
                      ShowBottomSheets.selectCountry(context,
                          (selectedCountry) {
                        dataStore
                            .setCountry(selectedCountry)
                            .then((_) => setState(() {}));
                      });
                    },
                  ),
                  Visibility(
                    visible: AppPermissions.isAccessServeceProvider(),
                    child: ListTile(
                      leading: Image.asset('assets/icons/request.png',
                          width: 30, height: 30),
                      title: Text(
                          AppLocalizations.of(context)!
                              .trans('service_provider_requests')!,
                          style: TextStyle(fontSize: 15)),
                      onTap: () {
                        Navigator.pop(context);
                        Navigator.of(context).push(
                          MaterialPageRoute(
                              builder: (context) =>
                                  ServiceProviderRequestsPage()), //RegisterProvidersPage
                        );
                      },
                    ),
                  ),
                  Visibility(
                    visible: AppPermissions.isServiceProvider(),
                    child: ListTile(
                      leading: Image.asset(
                        'assets/icons/branch.png',
                        width: 30,
                        height: 30,
                        color: Colors.black54,
                      ),
                      title: Text(
                          AppLocalizations.of(context)!.trans('branches')!,
                          style: TextStyle(fontSize: 15)),
                      onTap: () {
                        Navigator.pop(context);
                        Navigator.of(context).push(
                          MaterialPageRoute(
                              builder: (context) =>
                                  BranchPage()), //RegisterProvidersPage
                        );
                      },
                    ),
                  ),
                  Visibility(
                    visible: AppPermissions.isServiceProvider(),
                    child: ListTile(
                      leading: Image.asset(
                        'assets/icons/car.png',
                        width: 30,
                        height: 30,
                        color: Colors.black54,
                      ),
                      title: Text(
                          AppLocalizations.of(context)!.trans('vehicles')!,
                          style: TextStyle(fontSize: 15)),
                      onTap: () {
                        Navigator.pop(context);
                        Navigator.of(context).push(
                          MaterialPageRoute(
                              builder: (context) =>
                                  VehiclesPage()), //RegisterProvidersPage
                        );
                      },
                    ),
                  ),
                  Visibility(
                    visible: AppPermissions.isLogged(),
                    child: ListTile(
                      leading: Image.asset(
                        'assets/icons/trip.png',
                        width: 30,
                        height: 30,
                        color: Colors.black54,
                      ),
                      title: Text(AppLocalizations.of(context)!.trans('trips')!,
                          style: TextStyle(fontSize: 15)),
                      onTap: () {
                        Navigator.pop(context);
                        Navigator.of(context).push(
                          MaterialPageRoute(
                              builder: (context) =>
                                  TripTabPage()), //RegisterProvidersPage
                        );
                      },
                    ),
                  ),
                  Visibility(
                    visible: AppPermissions.isServiceProvider(),
                    child: ListTile(
                      leading: Image.asset(
                        'assets/icons/trip.png',
                        width: 30,
                        height: 30,
                        color: Colors.black54,
                      ),
                      title: Text(
                          AppLocalizations.of(context)!.trans('today_trips')!,
                          style: TextStyle(
                            fontSize: 15,
                          )),
                      onTap: () {
                        Navigator.pop(context);
                        Navigator.of(context).push(
                          MaterialPageRoute(
                              builder: (context) => TodayTripsPage()),
                        );
                      },
                    ),
                  ),
                  Visibility(
                    visible: AppPermissions.isAccessMenegmentPage(),
                    child: ListTile(
                      leading: Image.asset(
                        'assets/icons/management.png',
                        width: 30,
                        height: 30,
                        color: Colors.black54,
                      ),
                      title: Text(
                          AppLocalizations.of(context)!.trans('management')!,
                          style: TextStyle(fontSize: 15)),
                      onTap: () {
                        Navigator.pop(context);
                        Navigator.of(context).push(
                          MaterialPageRoute(
                              builder: (context) =>
                                  ManagementPage()), //RegisterProvidersPage
                        );
                      },
                    ),
                  ),
                  Visibility(
                    visible: AppPermissions.isServiceProvider(),
                    child: ListTile(
                      leading: Image.asset(
                        'assets/icons/employees.png',
                        width: 30,
                        height: 30,
                        color: Colors.black54,
                      ),
                      title: Text(
                          AppLocalizations.of(context)!.trans('employees')!,
                          style: TextStyle(fontSize: 15)),
                      onTap: () {
                        Navigator.pop(context);
                        Navigator.of(context).push(
                          MaterialPageRoute(
                              builder: (context) =>
                                  EmployeePage()), //RegisterProvidersPage
                        );
                      },
                    ),
                  ),
                  ListTile(
                    leading: Image.asset(
                      'assets/icons/translate.png',
                      width: 35,
                      height: 30,
                    ),
                    title: Text(AppLocalizations.of(context)!.trans('language')!,
                        style: TextStyle(fontSize: 15)),
                    onTap: () {
                      ShowDialogs.showAlert(
                          context,
                          AppLocalizations.of(context)!.trans('language'),
                          AppLocalizations.of(context)!.trans('change_language'),
                          () {
                        dataStore.lang == 'ar'
                            ? dataStore.setLang('en').then((_) {
                               dataStore.country!.name=dataStore.country!.latinName;
                                MyApp.changeLang(context);
                              })
                            : dataStore.setLang('ar').then((_) {
                               dataStore.country!.name=dataStore.country!.localName;
                                MyApp.changeLang(context);
                              });
                        Navigator.of(context).pop();
                      });
                    },
                  ),
                  Visibility(
                    visible: AppPermissions.isLogged(),
                    child: ListTile(
                      leading: Image.asset(
                        'assets/icons/password.png',
                        width: 25,
                        height: 25,
                        color: Colors.black54,
                      ),
                      title: Text(
                          AppLocalizations.of(context)!.trans('change_password')!,
                          style: TextStyle(fontSize: 15)),
                      onTap: () {
                        Navigator.pop(context);
                        ShowDialogs.changPasswordDialog(context)
                            .then((value) {});
                      },
                    ),
                  ),
                  Visibility(
                    visible: AppPermissions.isLogged(),
                    child: ListTile(
                      leading: Icon(
                        Entypo.logout,
                        color: Colors.black54,
                        size: 26,
                      ),
                      title: Text(AppLocalizations.of(context)!.trans('logout')!,
                          style: TextStyle(fontSize: 15)),
                      onTap: () {
                        ShowDialogs.showAlert(
                            context,
                            AppLocalizations.of(context)!.trans('logout'),
                            AppLocalizations.of(context)!
                                .trans('do_you_want_to_logout'), () {
                          Navigator.pop(context);
                          LogoutBloc.logout(context);
                        });
                      },
                    ),
                    replacement: ListTile(
                      leading: Icon(
                        Entypo.login,
                        color: Colors.black54,
                        size: 26,
                      ),
                      title: Text(AppLocalizations.of(context)!.trans('login')!,
                          style: TextStyle(fontSize: 15)),
                      onTap: () {
                        Navigator.pop(context);
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return LoginPage();
                        }));
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
