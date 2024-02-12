// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:pawlly_employee/main.dart';
import 'package:pawlly_employee/screens/auth/services/auth_services.dart';

import '../../network/network_utils.dart';
import '../../utils/app_common.dart';
import '../../utils/common_base.dart';
import '../../utils/constants.dart';
import '../../utils/local_storage.dart';
import '../booking_module/booking_list/bookings_controller.dart';
import '../home/dashboard_screen.dart';
import 'profile/profile_screen.dart';

class SignInController extends GetxController {
  RxBool isRememberMe = true.obs;
  RxBool isLoading = false.obs;
  RxString userName = "".obs;
  Rx<LoginData> selectedDemoUser = LoginData().obs;
  List<LoginData> selectRole = [
    LoginData(id: 1, serviceName: "Boarder", email: "miles@gmail.com", password: "12345678"),
    LoginData(id: 2, serviceName: "Veterinarian", email: "felix@gmail.com", password: "12345678"),
    LoginData(id: 3, serviceName: "Groomer", email: "richard@gmail.com", password: "12345678"),
    LoginData(id: 4, serviceName: "Trainer", email: "tristan@gmail.com", password: "12345678"),
    LoginData(id: 5, serviceName: "Walker", email: "pedro@gmail.com", password: "12345678"),
    LoginData(id: 6, serviceName: "Daycare Taker", email: "justin@gmail.com", password: "12345678"),
    LoginData(id: 7, serviceName: "Pet Sitter", email: "harry@gmail.com", password: "12345678"),
  ];
  TextEditingController emailCont = TextEditingController(text: Constants.DEFAULT_EMAIL);
  TextEditingController passwordCont = TextEditingController(text: Constants.DEFAULT_PASS);

  void toggleSwitch() {
    isRememberMe.value = !isRememberMe.value;
  }

  @override
  void onInit() {
    final userIsRemeberMe = getValueFromLocal(SharedPreferenceConst.IS_REMEMBER_ME);
    final userNameFromLocal = getValueFromLocal(SharedPreferenceConst.USER_NAME);
    if (userNameFromLocal is String) {
      userName(userNameFromLocal);
    }
    if (userIsRemeberMe == true) {
      final userEmail = getValueFromLocal(SharedPreferenceConst.USER_EMAIL);
      if (userEmail is String) {
        emailCont.text = userEmail;
      }
      final userPASSWORD = getValueFromLocal(SharedPreferenceConst.USER_PASSWORD);
      if (userPASSWORD is String) {
        passwordCont.text = userPASSWORD;
      }
    }
    super.onInit();
  }

  saveForm() async {
    isLoading(true);
    hideKeyBoardWithoutContext();

    Map<String, dynamic> req = {
      'email': emailCont.text.trim(),
      'password': passwordCont.text.trim(),
      'player_id': playerId.value,
    };

    await AuthService.loginUser(request: req).then((value) async {
      if (value.userData.userRole.contains(EmployeeKeyConst.veterinary) ||
          value.userData.userRole.contains(EmployeeKeyConst.walking) ||
          value.userData.userRole.contains(EmployeeKeyConst.boarding) ||
          value.userData.userRole.contains(EmployeeKeyConst.grooming) ||
          value.userData.userRole.contains(EmployeeKeyConst.training) ||
          value.userData.userRole.contains(EmployeeKeyConst.dayCare) ||
          value.userData.userRole.contains(EmployeeKeyConst.petSitter)) {
        loginUserData(value.userData);

        setValueToLocal(SharedPreferenceConst.USER_DATA, loginUserData.toJson());
        setValueToLocal(SharedPreferenceConst.USER_PASSWORD, passwordCont.text.trim());
        isLoading(false);
        isLoggedIn(true);
        setValueToLocal(SharedPreferenceConst.IS_LOGGED_IN, true);
        setValueToLocal(SharedPreferenceConst.IS_REMEMBER_ME, isRememberMe.value);

        ///This method called for update onesignal playerId to database
        reGenerateToken();
        if (loginUserData.value.userRole.contains(EmployeeKeyConst.petSitter)) {
          Get.offAll(() => ProfileScreen());
        } else {
          Get.offAll(() => DashboardScreen(), binding: BindingsBuilder(() {
            Get.put(BookingsController());
          }));
        }
      } else {
        toast(locale.value.sorryUserCannotSignin);
      }
    }).catchError((e) {
      toast(e.toString(), print: true);
    }).whenComplete(() => isLoading(false));
  }
}

class LoginData {
  int id;
  String serviceName;
  String email;
  String password;

  LoginData({
    this.id = -1,
    this.serviceName = "",
    this.email = "",
    this.password = "",
  });

  factory LoginData.fromJson(Map<String, dynamic> json) {
    return LoginData(
      id: json['id'] is int ? json['id'] : -1,
      serviceName: json['serviceName'] is String ? json['serviceName'] : "",
      email: json['serviceName'] is String ? json['email'] : "",
      password: json['password'] is String ? json['password'] : "",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'serviceName': serviceName,
      'email': email,
      'password': password,
    };
  }
}
