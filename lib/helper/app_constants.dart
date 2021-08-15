import 'package:intl/intl.dart';
import 'package:agriunions_logistics/helper/data_store.dart';

class AppConstants {
  static String googleMapKey = "AIzaSyCc30757bF1ymBSeUTl5wrcXi9Aal8sj0c";
  static var ads = [
    "assets/images/banner01.png",
    "assets/images/banner02.png",
    "assets/images/banner03.png",
  ];

  static List<String> rotationType = ["one_time", "daily", "weekly", "monthly"];

  static List<String> tripStatus = [
    "started",
    "on_way",
    "delivered",
    "cancelled",
    "completed"
  ];
  static List<String> shippingRequestStatus = [
    "Picked",
    "Started",
    "Ended",
    "Delivered",
  ];
  static List<String> imagesList = [
    "assets/images/image1.jpg",
    "assets/images/image2.jpg",
    "assets/images/image3.jpg"
  ];

  static DateFormat dateFormat1 = DateFormat("dd-MM-yyyy");
  DateFormat dateFormat2 = DateFormat("MMM d, yyyy", dataStore.lang);
  DateFormat dateFormat3 = DateFormat("EEE dd-MM-yyyy", dataStore.lang);
}
