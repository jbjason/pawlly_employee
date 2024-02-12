import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:pawlly_employee/utils/common_base.dart';

import '../../models/review_data.dart';
import '../../utils/constants.dart';
import '../booking_module/model/bookings_model.dart';
import '../booking_module/services/booking_api.dart';

class HomeController extends GetxController with GetSingleTickerProviderStateMixin {
  RxBool isLoading = false.obs;
  RxList<ReviewData> employeeReviewCacheList = RxList();
  RxList<BookingDataModel> bookingsCacheList = RxList();
  Rx<Future<List<ReviewData>>> getReview = Future(() => <ReviewData>[]).obs;
  Rx<Future<List<BookingDataModel>>> bookings = Future(() => <BookingDataModel>[]).obs;

  @override
  void onInit() {
    init();
    super.onInit();
  }

  init() {
    getHomeBookings();
    getReviewApi();
  }

  void getHomeBookings() {
    isLoading(true);
    bookings(BookingApi.getHomeBookingList(bookings: bookingsCacheList)).whenComplete(() => isLoading(false));
  }

  void getReviewApi() {
    isLoading(true);
    getReview(BookingApi.getHomeEmployeeReviews()).then((value) {
      employeeReviewCacheList(value);
      isLoading(false);
    }).whenComplete(() => isLoading(false));
  }

  String scheduleDate(BookingDataModel appointment) {
    try {
      if (appointment.service.slug.contains(ServicesKeyConst.boarding)) {
        return appointment.dropoffDateTime.isValidDateTime ? appointment.dropoffDateTime : " - ";
      } else {
        return appointment.serviceDateTime.isValidDateTime ? appointment.serviceDateTime : " - ";
      }
    } catch (e) {
      log('scheduleDate E: $e');
      return " - ";
    }
  }
}
