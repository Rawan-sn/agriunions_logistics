import 'package:agriunions_logistics/helper/enums.dart';

class TextSizes {
  static double? title;
  static double? subtitle;
  static double? bigText;
  static double? text;
  static double? smallText;
  static double? notice;

  static void init(ScreenSizes size) {
    if (size == ScreenSizes.extraLarge) {
      title = 40.0;
      subtitle = 35.0;
      bigText = 32.5;
      text = 30.0;
      smallText = 26.5;
      notice = 19.0;
    } else if (size == ScreenSizes.large) {
      title = 34.0;
      subtitle = 29.0;
      bigText = 27.5;
      text = 26.0;
      smallText = 23.5;
      notice = 17.0;
    } else if (size == ScreenSizes.medium) {
      title = 30.0;
      subtitle = 26.0;
      bigText = 24.5;
      text = 23.0;
      smallText = 20.5;
      notice = 14.0;
    } else if (size == ScreenSizes.small) {
      title = 28.0;
      subtitle = 25.0;
      bigText = 23.5;
      text = 22.0;
      smallText = 19.5;
      notice = 13.0;
    } else if (size == ScreenSizes.extraSmall) {
      title = 24.0;
      subtitle = 21.0;
      bigText = 20.0;
      text = 19.0;
      smallText = 17.5;
      notice = 12.0;
    } else {
      title = 23.0;
      subtitle = 19.0;
      bigText = 18.0;
      text = 17.0;
      smallText = 15.5;
      notice = 10.0;
    }
  }
}