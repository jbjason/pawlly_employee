import 'package:get/get.dart';
import 'package:pawlly_employee/screens/auth/model/app_configuration_res.dart';

import '../configs.dart';
import '../screens/home/model/about_page_res.dart';
import '../screens/home/model/pet_center_detail.dart';
import '../screens/home/model/status_list_res.dart';
import '../screens/auth/model/login_response.dart';

import 'constants.dart';

RxString selectedLanguageCode = DEFAULT_LANGUAGE.obs;
RxBool isLoggedIn = false.obs;
RxString playerId = "".obs;
Rx<UserData> loginUserData = UserData().obs;
// Rx<EmployeeData> loginEmployeeData = EmployeeData().obs;
RxBool isDarkMode = false.obs;
Rx<Currency> appCurrency = Currency().obs;
Rx<ConfigurationResponse> appConfigs = ConfigurationResponse(currency: Currency(), onesignalEmployeeApp: OnesignalEmployeeApp(), employeeAppUrl: EmployeeAppUrl(), zoom: ZoomConfig()).obs;

//DashBoard var

RxList<StatusModel> allStatus = RxList();
RxList<AboutDataModel> aboutPages = RxList();
Rx<PetCenterDetail> petCenterDetail = PetCenterDetail().obs;
//Bookings var
// Rx<AllBookingLists> cacheAllBookingLists = AllBookingLists().obs;

// Currency position common
bool get isCurrencyPositionLeft => appCurrency.value.currencyPosition == CurrencyPosition.CURRENCY_POSITION_LEFT;

bool get isCurrencyPositionRight => appCurrency.value.currencyPosition == CurrencyPosition.CURRENCY_POSITION_RIGHT;

bool get isCurrencyPositionLeftWithSpace => appCurrency.value.currencyPosition == CurrencyPosition.CURRENCY_POSITION_LEFT_WITH_SPACE;

bool get isCurrencyPositionRightWithSpace => appCurrency.value.currencyPosition == CurrencyPosition.CURRENCY_POSITION_RIGHT_WITH_SPACE;
//endregion

RxBool updateUi = false.obs;
