// ignore_for_file: depend_on_referenced_packages

import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';
import '../screens/auth/model/app_configuration_res.dart';
import '../screens/auth/model/login_response.dart';
import '../screens/auth/signin_screen.dart';
import '../utils/app_common.dart';
import '../utils/constants.dart';
import '../utils/local_storage.dart';
import 'auth/profile/profile_screen.dart';
import 'auth/services/auth_services.dart';
import 'booking_module/booking_list/bookings_controller.dart';
import 'home/dashboard_screen.dart';

class SplashScreenController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    init();
    // Future.delayed(Duration(milliseconds: 7000), () {
    //   init();
    // });
  }

  void init() {
    try {
      final configurationResFromLocal = getValueFromLocal(APICacheConst.APP_CONFIGURATION_RESPONSE);
      if (configurationResFromLocal != null) {
        appConfigs(ConfigurationResponse.fromJson(configurationResFromLocal));
        appCurrency(appConfigs.value.currency);
      }
    } catch (e) {
      log('configurationResFromLocal from cache E: $e');
    }
    getAppConfigurations();
  }
}

Rx<Future<ConfigurationResponse>> appConfigsFuture = Future(() => ConfigurationResponse(currency: Currency(), onesignalEmployeeApp: OnesignalEmployeeApp(), employeeAppUrl: EmployeeAppUrl(), zoom: ZoomConfig())).obs;
RxBool isLoading = false.obs;

///Get ChooseService List
getAppConfigurations() {
  appConfigsFuture(AuthService.getAppConfigurations()).then((value) {
    appCurrency(value.currency);
    appConfigs(value);
    setValueToLocal(APICacheConst.APP_CONFIGURATION_RESPONSE, value.toJson());

    ///Navigation logic
    if (getValueFromLocal(SharedPreferenceConst.IS_LOGGED_IN) == true) {
      try {
        final userData = getValueFromLocal(SharedPreferenceConst.USER_DATA);
        isLoggedIn(true);
        loginUserData.value = UserData.fromJson(userData);
        if (loginUserData.value.userRole.contains(EmployeeKeyConst.petSitter)) {
          Get.offAll(() => ProfileScreen());
        } else {
          Get.offAll(() => DashboardScreen(), binding: BindingsBuilder(() {
            Get.put(BookingsController());
          }));
        }
      } catch (e) {
        log('SplashScreenController Err: $e');

        Get.offAll(() => SignInScreen());
      }
    } else {
      Get.offAll(() => SignInScreen());
    }
  }).whenComplete(() => isLoading(false));
}
