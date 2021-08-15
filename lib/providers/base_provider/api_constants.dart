import 'package:agriunions_logistics/helper/data_store.dart';

class ApiConstants {
  static String? authority = dataStore.baseUrl;
  static String _usersSuffix = "/User/";
  static String _branchSuffix = "/Branches";
  static String _homeSuffix = "/Home/";
  static String _vehicleSuffix = "/Vehicles";
  static String _chatSuffix = "/Chat/";
  static String _shippingSuffix = "/ShippingRequests";
  static String _realTimeShippingSuffix = "/RealtimeShipping";
  static String login = _usersSuffix + "Login";
  static String profile = _usersSuffix + "Profile";
  static String logout = _usersSuffix + "LogOut";
  static String register = _usersSuffix + "Register";
  static String registerProvider = _usersSuffix + "RegisterServiceProvider";
  static String retrieveProviderRequests =
      _usersSuffix + "ServiceProviderRequests";
  static String updateLocation = _usersSuffix + "UpdateLocation";
  static String setOnline = _usersSuffix + "SetOnline";
  static String branches = _branchSuffix;
  static String createBranch = _branchSuffix + "/Create";
  static String updateBranch = _branchSuffix + "/";
  static String initialData = _homeSuffix + "InitialData";
  static String countries = _homeSuffix + "Countries";
  static String cities = _homeSuffix + "Cities";
  static String vehicleClassifications = _homeSuffix + "VehicleClassifications";
  static String createVehicle = _vehicleSuffix + "/Create";
  static String updateVehicle = _vehicleSuffix + "/";
  static String vehicles = _vehicleSuffix;
  static String myTripOffers = "TripOffers/Index";
  static String schedulesTripOffers = "TripOffers/Scheduled";
  static String createTripOffers = "TripOffers/Create";
  static String editTripOffers = "TripOffers/";
  static String tripOfferDetails = "TripOffers/Details/";
  static String tripOfferRequests = "TripOfferRequests/Index";
  static String tripOfferRequestsSetStatus = "TripOfferRequests/SetStatus";
  static String createTripOfferRequest = "TripOfferRequests/Create";
  static String startTripProcess = "TripOfferProcess/StartTripProcess/";
  static String updateTripOfferStatus = "TripOffers/UpdateStatus/";
  static String find = _usersSuffix + "Find";
  static String subUserList = _usersSuffix + "SubUserList";
  static String sendLinkRequest = _usersSuffix + "SendLinkRequest";
  static String linkRequests = _usersSuffix + "LinkRequests";
  static String unlinkUser = _usersSuffix + "UnlinkUser";
  static String processLinkRequest = _usersSuffix + "ProcessLinkRequest";
  static String sendChatMessage = _chatSuffix + "SendMessage";
  static String getConversationDetails = _chatSuffix + "Conversation";
  static String getListOfConversations = _chatSuffix + "ConversationList";
  static String getShippingRequests = _shippingSuffix;
  static String createShippingRequest = _shippingSuffix + "/Create";
  static String getShippingRequestDetails = _shippingSuffix + "/";
  static String sendShippingRequestQuote = _shippingSuffix + "/SendQuote/";
  static String changeQuoteStatus = _shippingSuffix + "/SetQuoteStatus/";
  static String changeQuoteProcessStatus =
      _shippingSuffix + "/SetQuoteProcessStatus/";
  static String getRealTimeShippingRequests = _realTimeShippingSuffix;
  static String createRealTimeShippingRequest =
      _realTimeShippingSuffix + "/Create";
  static String getRealTimeShippingRequestDetails =
      _realTimeShippingSuffix + "/";
  static String sendRealTimeShippingRequestQuote =
      _realTimeShippingSuffix + "/SendQuote/";
  static String changeRealTimeQuoteStatus =
      _realTimeShippingSuffix + "/SetQuoteStatus/";
  static String changeRealTimeQuoteProcessStatus =
      _realTimeShippingSuffix + "/SetQuoteProcessStatus/";
}
