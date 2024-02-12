import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:pawlly_employee/utils/common_base.dart';
import '../../../utils/constants.dart';
import '../../home/home_controller.dart';
import '../model/bookings_model.dart';
import 'package:stream_transform/stream_transform.dart';
import '../services/booking_api.dart';

class BookingsController extends GetxController {
  Rx<Future<RxList<BookingDataModel>>> getBookingsFuture = Future(() => RxList<BookingDataModel>()).obs;
  RxList<BookingDataModel> bookings = RxList();
  RxBool isLoading = false.obs;
  RxBool isRefresh = false.obs;
  RxBool isLastPage = false.obs;
  RxInt page = 1.obs;

  TextEditingController searchCont = TextEditingController();
  RxSet<String> selectedStatus = RxSet();
  RxSet<String> selectedService = RxSet();
  RxBool isSearchText = false.obs;
  StreamController<String> searchStream = StreamController<String>();
  final _scrollController = ScrollController();

  @override
  void onReady() {
    _scrollController.addListener(() => Get.context != null ? hideKeyboard(Get.context) : null);
    searchStream.stream.debounce(const Duration(seconds: 1)).listen((s) {
      getBookingList();
    });
    getBookingList();
    super.onReady();
  }

  getBookingList({bool showloader = true, String search = ""}) {
    if (showloader) {
      isLoading(true);
    }
    getBookingsFuture(BookingApi.getBookingFilterList(
      filterByStatus: selectedStatus.join(","),
      filterByService: selectedService.join(","),
      page: page.value,
      search: searchCont.text.trim(),
      bookings: bookings,
      lastPageCallBack: (p0) {
        isLastPage(p0);
      },
    )).whenComplete(() => isLoading(false));
  }

  updateBooking({required int bookingId, required String status, VoidCallback? onUpdateBooking}) async {
    isLoading(true);
    hideKeyBoardWithoutContext();

    Map<String, dynamic> req = {
      "id": bookingId,
      "status": status,
    };
    await BookingApi.updateBooking(request: req).then((value) async {
      if (onUpdateBooking != null) {
        onUpdateBooking.call();
      }
      try {
        HomeController hCont = Get.find();
        hCont.getHomeBookings();
      } catch (e) {
        log('onItemSelected Err: $e');
      }
      isLoading(false);
    }).catchError(
      (e) {
        isLoading(false);
        toast(e.toString(), print: true);
      },
    );
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

  @override
  void onClose() {
    searchStream.close();
    if (Get.context != null) {
      _scrollController.removeListener(() => hideKeyboard(Get.context));
    }
    super.onClose();
  }
}
