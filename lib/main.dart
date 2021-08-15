import 'package:agriunions_logistics/user_interfaces/pages/splash.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'Localization/AppLocal.dart';
import 'helper/TextSizes.dart';
import 'helper/data_store.dart';
import 'helper/enums.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  dataStore.setProjectType(ProjectType.staging);
  await dataStore.getLang().then((val) {
    runApp(new MyApp());
  });
}

class MyApp extends StatefulWidget {
  static void restartApp(BuildContext context) {
    context.findAncestorStateOfType<_MyAppState>()!.restartApp();
  }

  static void changeLang(BuildContext context) {
    context.findAncestorStateOfType<_MyAppState>()!.changeLang();
  }

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Key key = UniqueKey();

  void restartApp() {
    setState(() {
      key = UniqueKey();
    });
  }

  void changeLang() {
    setState(() {});
  }

  ScreenSizes screenSizes = ScreenSizes.medium;
  @override
  void initState() {
    // SystemChrome.setSystemUIOverlayStyle(
    //     SystemUiOverlayStyle(statusBarColor: AppColors.darkRed));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    return KeyedSubtree(
      key: key,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          fontFamily: 'Grandstander',
          primarySwatch: Colors.red,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        localizationsDelegates: [
          const AppLocalizationsDelegate(),
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate
        ],
        supportedLocales: [
          const Locale('en'), // English
          const Locale('ar'), // Arabic
        ],
        locale: Locale(dataStore.lang!),
        home: LayoutBuilder(
          builder: (context, constraints) {
            if (constraints.maxWidth >= 480) {
              screenSizes = ScreenSizes.extraLarge;
            } else if (constraints.maxWidth >= 414) {
              screenSizes = ScreenSizes.large;
            } else if (constraints.maxWidth >= 375) {
              screenSizes = ScreenSizes.medium;
            } else if (constraints.maxWidth >= 360) {
              screenSizes = ScreenSizes.small;
            } else if (constraints.maxWidth >= 320) {
              screenSizes = ScreenSizes.extraSmall;
            } else {
              screenSizes = ScreenSizes.twoExtraSmall;
            }
            TextSizes.init(screenSizes);
            return Splash();
          },
        ),
      ),
    );
  }
}
