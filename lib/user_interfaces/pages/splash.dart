import 'dart:async';
import 'package:flutter/material.dart';
import 'package:agriunions_logistics/helper/AppColors.dart';
import 'package:agriunions_logistics/helper/data_store.dart';
import 'package:agriunions_logistics/models/country_model.dart';
import 'package:agriunions_logistics/models/initial_data_model.dart';
import 'package:agriunions_logistics/models/user_model.dart';
import 'package:agriunions_logistics/providers/api_general_data.dart';
import 'package:agriunions_logistics/user_interfaces/pages/schedules_trips_page.dart';

class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  double angle = 0;
  late Timer timer;
  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(Duration(milliseconds: 10), (timer) {
      angle += 0.01;
      setState(() {});
    });
    dataStore.getCountry().then((country) {
      ApiGeneralData(context).getInitialData().then((initdata) {
        if (initdata != null) {
          dataStore.initialData = InitialDataModel.fromMap(initdata.data);
          dataStore.setInitialData(dataStore.initialData!.toJson()).then((_) {
            dataStore.getInitialData().then((_) {
              dataStore.getAuthUser().then((authUser) {
                print("Token: ${dataStore.authUser?.token}");
                if (authUser == null) {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => SchedulesTripsPage()),
                  );
                } else {
                  if (country == null) {
                    dataStore
                        .setCountry(CountryModel(
                            id:  dataStore.initialData!
                                .defaultCountryId,
                            localName:  dataStore.initialData!
                                .defaultCountryLocalName,
                            latinName:  dataStore.initialData!
                                .defaultCountryLatinName,
                            name: dataStore.initialData!.name))
                        .then((_) {
                      setState(() {});
                    });
                  }
                  ApiGeneralData(context).getProfile().then((profileData) {
                    if (profileData != null) {
                      dataStore.authUser!.user =
                          UserModel.fromMap(profileData.data);
                      dataStore
                          .setAuthUser(dataStore.authUser!.toJson())
                          .then((_) {
                        dataStore.getAuthUser().then((_) {
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(builder: (context) => SchedulesTripsPage()),
                          );
                        });
                      });
                    }
                  });
                }
              });
            });
          });
        }
      });
    });
  }

  @override
  void dispose() {
    print("splash dispose");
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Image.asset(
            "assets/images/splash_bc1.png",
            fit: BoxFit.fill,
            height: double.infinity,
            width: double.infinity,
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 100),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Transform.rotate(
                    angle: angle,
                    child: Image.asset(
                      "assets/images/logo3.png",
                      fit: BoxFit.fill,
                      height: 40,
                      width: 40,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      "Logistic",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 50,
                        color: AppColors.Russet,
                      ),
                    ),
                  ),
                  Transform.rotate(
                    angle: angle,
                    child: Image.asset(
                      "assets/images/logo3.png",
                      fit: BoxFit.fill,
                      height: 40,
                      width: 40,
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
