import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:pawlly_employee/components/app_scaffold.dart';
import 'package:pawlly_employee/components/loader_widget.dart';
import 'package:pawlly_employee/main.dart';
import '../../../utils/empty_error_state_widget.dart';
import 'employee_review_components.dart';
import 'employee_review_controller.dart';

class EmployeeReviewScreen extends StatelessWidget {
  EmployeeReviewScreen({Key? key}) : super(key: key);
  final EmployeeReviewController employeeReviewController = Get.put(EmployeeReviewController());

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      hasLeadingWidget: false,
      appBartitleText: locale.value.myReviews,
      isLoading: employeeReviewController.isLoading,
      body: Obx(
        () => SnapHelperWidget(
            future: employeeReviewController.getReview.value,
            errorBuilder: (error) {
              return NoDataWidget(
                title: error,
                retryText: locale.value.reload,
                imageWidget: const ErrorStateWidget(),
                onRetry: () {
                  employeeReviewController.page(1);
                  employeeReviewController.isLoading(true);
                  employeeReviewController.init();
                },
              ).paddingSymmetric(horizontal: 32);
            },
            loadingWidget: const LoaderWidget(),
            onSuccess: (reviews) {
              return AnimatedListView(
                shrinkWrap: true,
                itemCount: reviews.length,
                physics: const AlwaysScrollableScrollPhysics(),
                padding: const EdgeInsets.symmetric(horizontal: 16),
                emptyWidget: NoDataWidget(
                  title: locale.value.noDataFound,
                  subTitle: locale.value.thereAreNoReview,
                  titleTextStyle: primaryTextStyle(),
                  imageWidget: const EmptyStateWidget(),
                  onRetry: () {
                    employeeReviewController.page(1);
                    employeeReviewController.isLoading(false);
                    employeeReviewController.init();
                  },
                ).paddingSymmetric(horizontal: 32),
                itemBuilder: (context, index) {
                  return EmployeeReviewComponents(employeeReview: reviews[index]);
                },
                onNextPage: () async {
                  if (!employeeReviewController.isLastPage.value) {
                    employeeReviewController.page(employeeReviewController.page.value + 1);
                    employeeReviewController.isLoading(true);
                    employeeReviewController.init();
                    return await Future.delayed(const Duration(seconds: 2), () {
                      employeeReviewController.isLoading(false);
                    });
                  }
                },
                onSwipeRefresh: () async {
                  employeeReviewController.page(1);
                  employeeReviewController.init();
                  return await Future.delayed(const Duration(seconds: 2));
                },
              );
            }),
      ),
    );
  }
}
