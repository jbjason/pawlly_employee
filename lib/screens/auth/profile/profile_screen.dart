import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:pawlly_employee/main.dart';
import 'package:pawlly_employee/screens/auth/profile/profile_controller.dart';

import '../../../components/app_scaffold.dart';
import '../../../components/common_profile_widget.dart';
import '../../../generated/assets.dart';
import '../../../utils/app_common.dart';
import '../../../utils/colors.dart';
import '../../../utils/common_base.dart';

import '../other/about_us_screen.dart';
import '../other/settings_screen.dart';
import 'edit_employee_profile.dart';
import 'edit_user_profile_controller.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({Key? key}) : super(key: key);
  final ProfileController profileController = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      hideAppBar: true,
      isLoading: profileController.isLoading,
      body: AnimatedScrollView(
        padding: const EdgeInsets.only(top: 39),
        children: [
          CommonAppBar(
            title: locale.value.profile,
            hasLeadingWidget: false,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Obx(() => ProfilePicWidget(
                    heroTag: loginUserData.value.profileImage,
                    profileImage: loginUserData.value.profileImage,
                    firstName: loginUserData.value.firstName,
                    lastName: loginUserData.value.lastName,
                    userName: loginUserData.value.userName,
                    subInfo: loginUserData.value.email,
                    onCameraTap: () {
                      EditUserProfileController editUserProfileController = EditUserProfileController(isProfilePhoto: true);
                      editUserProfileController.showBottomSheet(context);
                    },
                  )),
              32.height,
              SettingItemWidget(
                title: locale.value.editProfile,
                subTitle: locale.value.personalizeYourProfile,
                splashColor: transparentColor,
                onTap: () {
                  Get.to(() => EditUserProfileScreen(), duration: const Duration(milliseconds: 800));
                },
                titleTextStyle: primaryTextStyle(),
                leading: commonLeadingWid(imgPath: Assets.imagesIcEditprofileOutlined, icon: Icons.person_3_outlined, color: primaryColor),
                trailing: trailing,
                padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 16),
              ),
              commonDivider,
              SettingItemWidget(
                title: locale.value.settings,
                subTitle: "${locale.value.appLanguage}, ${locale.value.theme}, ${locale.value.deleteAccount}",
                splashColor: transparentColor,
                onTap: () {
                  Get.to(() => SettingScreen());
                },
                titleTextStyle: primaryTextStyle(),
                leading: commonLeadingWid(imgPath: Assets.profileIconsIcSettingOutlined, icon: Icons.settings_outlined, color: secondaryColor),
                trailing: trailing,
                padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 16),
              ),
              /* commonDivider,
              SettingItemWidget(
                title: locale.value.addServices,
                subTitle: locale.value.addParticularServices,
                splashColor: transparentColor,
                onTap: () {
                  Get.to(() => AddServiceForm());
                },
                titleTextStyle: primaryTextStyle(),
                leading: commonLeadingWid(imgPath: Assets.iconsAddServices, icon: Icons.settings_outlined, color: primaryColor),
                trailing: trailing,
                padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 16),
              ).visible(loginUserData.value.userRole.contains(EmployeeKeyConst.veterinary) || loginUserData.value.userRole.contains(EmployeeKeyConst.grooming) || loginUserData.value.userRole.contains(EmployeeKeyConst.training)),
            */
              commonDivider,
              SettingItemWidget(
                title: locale.value.rateApp,
                subTitle: locale.value.showSomeLoveShare,
                splashColor: transparentColor,
                onTap: () {
                  handleRate();
                },
                titleTextStyle: primaryTextStyle(),
                leading: commonLeadingWid(imgPath: Assets.profileIconsIcStarOutlined, icon: Icons.star_outline_rounded, color: primaryColor),
                trailing: trailing,
                padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 16),
              ),
              commonDivider,
              SettingItemWidget(
                title: locale.value.aboutApp,
                subTitle: "${locale.value.privacyPolicy}, ${locale.value.termsConditions}",
                splashColor: transparentColor,
                onTap: () {
                  Get.to(() => const AboutScreen());
                },
                titleTextStyle: primaryTextStyle(),
                leading: commonLeadingWid(imgPath: Assets.profileIconsIcInfoOutlined, icon: Icons.info_outline_rounded, color: secondaryColor),
                trailing: trailing,
                padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 16),
              ),
              commonDivider,
              SettingItemWidget(
                title: locale.value.logout,
                subTitle: locale.value.securelyLogOutOfAccount,
                splashColor: transparentColor,
                onTap: () {
                  profileController.handleLogout(context);
                },
                titleTextStyle: primaryTextStyle(),
                leading: commonLeadingWid(imgPath: Assets.profileIconsIcLogoutOutlined, icon: Icons.logout_outlined, color: primaryColor),
                padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 16),
              ),
              30.height,
              SnapHelperWidget<PackageInfoData>(
                future: getPackageInfo(),
                onSuccess: (data) {
                  return VersionInfoWidget(prefixText: 'v', textStyle: primaryTextStyle()).center();
                },
              ),
              32.height,
            ],
          ),
        ],
      ).visible(!updateUi.value),
    );
  }

  Widget get trailing => Icon(Icons.arrow_forward_ios, size: 12, color: darkGray.withOpacity(0.5));
}
