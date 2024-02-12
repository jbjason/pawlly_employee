import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:get/get.dart';
import 'package:pawlly_employee/configs.dart';
import 'package:pawlly_employee/main.dart';
import 'package:pawlly_employee/screens/auth/password/forget_password_screen.dart';
import 'package:pawlly_employee/screens/auth/sign_in_controller.dart';

import '../../components/app_logo_widget.dart';
import '../../components/app_scaffold.dart';
import '../../generated/assets.dart';
import '../../utils/app_common.dart';
import '../../utils/colors.dart';
import '../../utils/common_base.dart';
import '../../utils/constants.dart';

class SignInScreen extends StatelessWidget {
  SignInScreen({Key? key}) : super(key: key);
  final SignInController signInController = Get.put(SignInController());
  final GlobalKey<FormState> _signInformKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      hideAppBar: true,
      isLoading: signInController.isLoading,
      body: SizedBox(
        width: Get.width,
        height: Get.height,
        child: Stack(
          fit: StackFit.expand,
          children: [
            SingleChildScrollView(
              scrollDirection: Axis.vertical,
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  65.height,
                  Image.asset(
                    isDarkMode.value
                        ? Assets.imagesLogoDark
                        : Assets.imagesLogo,
                    height: Constants.appLogoSize,
                    width: Constants.appLogoSize,
                    fit: BoxFit.contain,
                    errorBuilder: (context, error, stackTrace) =>
                        const AppLogoWidget(),
                  ),
                  16.height,
                  Text(
                    '${locale.value.hello} ${signInController.userName.value.isNotEmpty ? signInController.userName.value : locale.value.guest}!',
                    style: primaryTextStyle(size: 24),
                  ),
                  8.height,
                  Text(
                    signInController.userName.value.isNotEmpty
                        ? '${locale.value.welcomeBackToThe}  $APP_NAME'
                        : '${locale.value.welcomeToThe} $APP_NAME',
                    style: secondaryTextStyle(size: 14),
                  ),

                  50.height,
                  Form(
                    key: _signInformKey,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Obx(
                          () => AppTextField(
                            title: locale.value.email,
                            controller: signInController.emailCont,
                            textFieldType: TextFieldType.EMAIL,
                            decoration: inputDecoration(
                              context,
                              fillColor: context.cardColor,
                              filled: true,
                              hintText:
                                  "${locale.value.eG} merry_456@gmail.com",
                            ),
                            suffix: Assets.iconsIcMail
                                .iconImage(fit: BoxFit.contain)
                                .paddingAll(14),
                          ),
                        ),
                        16.height,
                        Obx(
                          () => AppTextField(
                            title: locale.value.password,
                            controller: signInController.passwordCont,
                            // Optional
                            textFieldType: TextFieldType.PASSWORD,
                            decoration: inputDecoration(
                              context,
                              fillColor: context.cardColor,
                              filled: true,
                              hintText: "••••••••",
                            ),
                            suffixPasswordVisibleWidget: commonLeadingWid(
                                    imgPath: Assets.iconsIcEye,
                                    icon: Icons.password_outlined,
                                    size: 14)
                                .paddingAll(12),
                            suffixPasswordInvisibleWidget: commonLeadingWid(
                                    imgPath: Assets.iconsIcEyeSlash,
                                    icon: Icons.password_outlined,
                                    size: 14)
                                .paddingAll(12),
                          ),
                        ),
                        8.height,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Obx(
                              () => InkWell(
                                onTap: signInController.toggleSwitch,
                                borderRadius: radius(),
                                child: Row(
                                  children: [
                                    Transform.scale(
                                      scale: 0.75,
                                      child: Switch(
                                        activeTrackColor:
                                            switchActiveTrackColor,
                                        value:
                                            signInController.isRememberMe.value,
                                        activeColor: switchActiveColor,
                                        inactiveTrackColor:
                                            switchColor.withOpacity(0.2),
                                        onChanged: (bool value) {
                                          signInController.toggleSwitch();
                                        },
                                      ),
                                    ),
                                    Text(
                                      locale.value.rememberMe,
                                      style: secondaryTextStyle(
                                          color: darkGrayGeneral),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                Get.to(() => ForgetPassword());
                              },
                              child: Text(
                                locale.value.forgotPassword,
                                style: primaryTextStyle(
                                  size: 12,
                                  color: primaryColor,
                                  decoration: TextDecoration.underline,
                                  fontStyle: FontStyle.italic,
                                  decorationColor: primaryColor,
                                ),
                              ),
                            ),
                          ],
                        ),
                        32.height,
                        AppButton(
                            width: Get.width,
                            text: locale.value.signIn,
                            textStyle: appButtonTextStyleWhite,
                            onTap: () {
                              if (_signInformKey.currentState!.validate()) {
                                _signInformKey.currentState!.save();
                                signInController.saveForm();
                              }
                            }),
                        26.height,
                        Center(
                            child: Text(locale.value.demoAccounts,
                                style: primaryTextStyle())),
                        8.height,
                        Obx(
                          () => Container(
                            decoration: boxDecorationDefault(
                              color: context.cardColor,
                              shape: BoxShape.rectangle,
                            ),
                            width: Get.width,
                            child: DropdownButtonHideUnderline(
                              child: DropdownButtonFormField(
                                decoration: InputDecoration(
                                    hintStyle: secondaryTextStyle(),
                                    enabledBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                            color: context.cardColor)),
                                    focusedBorder: InputBorder.none),
                                padding:
                                    const EdgeInsets.only(left: 8, right: 8),
                                dropdownColor: context.cardColor,
                                borderRadius:
                                    BorderRadius.circular(defaultRadius),
                                items:
                                    signInController.selectRole.map((element) {
                                  return DropdownMenuItem(
                                    value: element,
                                    child: Text(element.serviceName,
                                        style: primaryTextStyle(size: 13)),
                                  );
                                }).toList(),
                                onChanged: (newValue) {
                                  // if (newValue is LoginData) {
                                  //   signInController.selectedDemoUser(newValue);
                                  //   signInController.emailCont.text =
                                  //       signInController
                                  //           .selectedDemoUser.value.email;
                                  //   signInController.passwordCont.text =
                                  //       signInController
                                  //           .selectedDemoUser.value.password;
                                  // }
                                },
                                value: signInController
                                            .selectedDemoUser.value.id >
                                        0
                                    ? signInController.selectedDemoUser.value
                                    : signInController.selectRole.first,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  8.height,
                  /*  16.height,
                  Row(children: [
                    Container(
                        margin: const EdgeInsets.only(left: 10.0),
                        child: const Divider(
                          color: borderColor,
                        )).expand(),
                    Text('OR', style: primaryTextStyle(color: secondaryTextColor, size: 14)).paddingSymmetric(horizontal: 20),
                    Container(
                      margin: const EdgeInsets.only(right: 10.0),
                      child: const Divider(
                        color: borderColor,
                      ),
                    ).expand(),
                  ]),
                  28.height,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(20),
                        decoration: boxDecorationDefault(
                          image: const DecorationImage(image: AssetImage(Assets.imagesGoogleImages)),
                          color: scafoldColor,
                          shape: BoxShape.circle,
                        ),
                      ),
                      16.width,
                      Container(
                        padding: const EdgeInsets.all(20),
                        decoration: boxDecorationDefault(
                          image: const DecorationImage(image: AssetImage(Assets.imagesApplePay)),
                          color: scafoldColor,
                          shape: BoxShape.circle,
                        ),
                      ),
                    ],
                  ), */ //TODO don't Remove
                ],
              ),
            ),
            /* Positioned(
              top: Get.height * 0.05,
              right: Get.width * 0.03,
              child: TextButton(
                onPressed: () {
                  Get.offAll(() => DashboardScreen(), binding: BindingsBuilder(() {
                    Get.put(HomeScreenController());
                  }));
                },
                child: Text(
                  'Skip',
                  style: primaryTextStyle(size: 14, color: primaryColor),
                ),
              ),
            ) */
          ],
        ),
      ),
    );
  }
}
