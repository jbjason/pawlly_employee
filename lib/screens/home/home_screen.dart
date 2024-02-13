// ignore_for_file: invalid_use_of_protected_member

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:pawlly_employee/components/app_scaffold.dart';
import '../../generated/assets.dart';
import '../../main.dart';
import '../../utils/app_common.dart';
import '../../utils/common_base.dart';
import '../../utils/empty_error_state_widget.dart';
import '../../utils/view_all_label_component.dart';
import '../auth/other/notification_screen.dart';
import '../auth/review/employee_review_components.dart';
import '../booking_module/booking_list/bookings_card.dart';
import 'dashboard_controller.dart';
import 'home_controller.dart';

class HomeScreen extends StatelessWidget {
  final HomeController homeController = Get.put(HomeController());

  HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      hideAppBar: true,
      hasLeadingWidget: false,
      isLoading: homeController.employeeReviewCacheList.isEmpty &&
              homeController.bookingsCacheList.isEmpty
          ? null
          : homeController.isLoading,
      body: RefreshIndicator(
        onRefresh: () async {
          homeController.init();
          return await Future.delayed(const Duration(seconds: 2));
        },
        child: AnimatedScrollView(
          listAnimationType: ListAnimationType.None,
          physics: const AlwaysScrollableScrollPhysics(),
          padding: const EdgeInsets.only(bottom: 16),
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // appbar
                Row(
                  children: [
                    Obx(
                      () => Text(
                        '${locale.value.hello}, ${loginUserData.value.userName.isNotEmpty ? loginUserData.value.userName : locale.value.guest} 👋',
                        style: primaryTextStyle(size: 20),
                      ),
                    ),
                    const Spacer(),
                    GestureDetector(
                      onTap: () {
                        Get.to(() => NotificationScreen());
                      },
                      child: Image.asset(
                        Assets.iconsIcNotification,
                        width: 26,
                        height: 26,
                      ),
                    ),
                  ],
                ).paddingSymmetric(horizontal: 16),
                16.height,
                Obx(
                  () => Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        children: [
                          ViewAllLabel(
                            label: locale.value.bookings,
                            onTap: () {
                              bottomNavigateByIndex(1);
                            },
                          ).paddingSymmetric(horizontal: 16),
                          Obx(
                            () => SnapHelperWidget(
                              future: homeController.bookings.value,
                              initialData:
                                  homeController.bookingsCacheList.isEmpty
                                      ? null
                                      : homeController.bookingsCacheList,
                              errorBuilder: (error) {
                                return NoDataWidget(
                                  title: error,
                                  retryText: locale.value.reload,
                                  onRetry: () {
                                    homeController.getHomeBookings();
                                  },
                                ).paddingSymmetric(horizontal: 16);
                              },
                              loadingWidget: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text("${locale.value.loading}.... ",
                                          style: secondaryTextStyle(
                                              size: 14,
                                              fontFamily: fontFamilyFontBold))
                                      .paddingSymmetric(
                                          vertical: Get.height * 0.12),
                                ],
                              ),
                              onSuccess: (bookingList) {
                                return AnimatedListView(
                                  shrinkWrap: true,
                                  listAnimationType: ListAnimationType.None,
                                  itemCount: bookingList.length,
                                  physics: const NeverScrollableScrollPhysics(),
                                  emptyWidget: NoDataWidget(
                                    title: locale.value.noBookingsFound,
                                    onRetry: () {
                                      homeController.getHomeBookings();
                                    },
                                    subTitle: locale.value.thereAreCurrentlyNo,
                                  ).paddingSymmetric(horizontal: 16),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16),
                                  itemBuilder: (context, index) {
                                    return BookingsCard(
                                        booking: bookingList[index],
                                        isfromBookings: true);
                                  },
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                      12.height,
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Obx(
                            () => ViewAllLabel(
                              label: locale.value.myReviews,
                              onTap: () {
                                bottomNavigateByIndex(2);
                              },
                              list:
                                  homeController.employeeReviewCacheList.value,
                            ).paddingSymmetric(horizontal: 16),
                          ),
                          Obx(
                            () => SnapHelperWidget(
                              future: homeController.getReview.value,
                              initialData:
                                  homeController.employeeReviewCacheList.isEmpty
                                      ? null
                                      : homeController.employeeReviewCacheList,
                              errorBuilder: (error) {
                                return NoDataWidget(
                                  title: error,
                                  retryText: locale.value.reload,
                                  imageWidget: const ErrorStateWidget(),
                                  onRetry: () {
                                    homeController.getReviewApi();
                                  },
                                ).paddingSymmetric(horizontal: 32);
                              },
                              loadingWidget: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text("${locale.value.loading}... ",
                                          style: secondaryTextStyle(
                                              size: 14,
                                              fontFamily: fontFamilyFontBold))
                                      .paddingSymmetric(
                                          vertical: Get.height * 0.12),
                                ],
                              ),
                              onSuccess: (reviews) {
                                return AnimatedListView(
                                  shrinkWrap: true,
                                  listAnimationType: ListAnimationType.None,
                                  itemCount: reviews.length,
                                  physics: const NeverScrollableScrollPhysics(),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16),
                                  emptyWidget: NoDataWidget(
                                    title: locale.value.noDataFound,
                                    subTitle: locale.value.thereAreNoReview,
                                    titleTextStyle: primaryTextStyle(),
                                    imageWidget: const EmptyStateWidget(),
                                    onRetry: () {
                                      homeController.getReviewApi();
                                    },
                                  ).paddingSymmetric(horizontal: 32),
                                  itemBuilder: (context, index) {
                                    return EmployeeReviewComponents(
                                        employeeReview: reviews[index]);
                                  },
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ).paddingOnly(top: 60),
          ],
        ),
      ),
    );
  }
}
