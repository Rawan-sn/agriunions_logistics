import 'package:agriunions_logistics/helper/data_store.dart';
import 'package:agriunions_logistics/models/link_request_model.dart';

class AppPermissions {
  static bool isAccessServeceProvider() =>
      (isLogged() && !isServiceProvider() && !isIHaveMaster());

  static bool isAccessMenegmentPage() => (isLogged() && !isServiceProvider());

  static bool isAllowToAddShippingRequest() =>
      (isLogged() && !isServiceProvider());

  static bool isServiceProvider() =>
      dataStore.authUser?.user?.isServiceProvider ?? false;

  static bool isLogged() => dataStore.authUser != null;

  bool isAllowToRemoveUserLink(LinkRequestModel model) {
    if (model.status != 'Accepted') return false;
    if ((model.currentMasterUserId ?? '').isEmpty) return false;
    if (model.currentMasterUserId == dataStore.authUser?.user?.id) return true;
    if (model.currentMasterUserId == dataStore.authUser?.user?.masterUserId)
      return true;
    return false;
  }

  static bool isShouldUpdateLocation() {
    if (isLogged() &&
        isServiceProvider() &&
        (dataStore.authUser?.user?.online ?? false)) {
      return true;
    }
    return false;
  }

  static bool isCanChangeOnlineOfflineStatus() {
    if (isLogged()) {
      if (isServiceProvider() ||
          (dataStore.authUser?.user?.masterUserId ?? '').isNotEmpty)
        return true;
    }
    return false;
  }

  static bool isIHaveMaster() =>
      (dataStore.authUser?.user?.masterUserId ?? '').isNotEmpty;
}
