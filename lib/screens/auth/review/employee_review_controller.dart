import 'package:get/get.dart';

import '../../../models/review_data.dart';
import '../../booking_module/services/booking_api.dart';

class EmployeeReviewController extends GetxController {
  Rx<Future<List<ReviewData>>> getReview = Future(() => <ReviewData>[]).obs;
  RxBool isLoading = false.obs;
  RxBool isLastPage = false.obs;
  RxInt page = 1.obs;
  RxList<ReviewData> employeeReview = RxList();

  @override
  void onInit() {
    init();
    super.onInit();
  }

  void init() {
    getReview(BookingApi.getEmployeeReviews(
      page: page.value,
      reviews: employeeReview,
      lastPageCallBack: (p0) {
        isLastPage(p0);
      },
    ).whenComplete(() => isLoading(false)));
  }
}
