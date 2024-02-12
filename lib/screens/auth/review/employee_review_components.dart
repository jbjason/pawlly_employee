import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:pawlly_employee/models/review_data.dart';
import 'package:pawlly_employee/utils/common_base.dart';

import '../../../components/cached_image_widget.dart';
import '../../booking_module/booking_detail/booking_detail_controller.dart';

class EmployeeReviewComponents extends StatelessWidget {
  final ReviewData employeeReview;
  const EmployeeReviewComponents({super.key, required this.employeeReview});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(16),
          margin: const EdgeInsets.symmetric(vertical: 8),
          width: Get.width,
          decoration: boxDecorationWithRoundedCorners(backgroundColor: context.cardColor),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Row(
                    children: [
                      CachedImageWidget(
                        url: employeeReview.profileImage,
                        firstName: employeeReview.username,
                        height: 46,
                        width: 46,
                        fit: BoxFit.cover,
                        circle: true,
                      ),
                      10.width,
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(employeeReview.username, style: primaryTextStyle()),
                            ],
                          ),
                          4.height,
                          Row(
                            children: [
                              RatingBarWidget(
                                size: 15,
                                disable: true,
                                activeColor: getRatingBarColor(employeeReview.rating),
                                rating: employeeReview.rating.toDouble(),
                                onRatingChanged: (aRating) {},
                              ),
                            ],
                          ),
                        ],
                      ),
                      const Spacer(),
                      Text(employeeReview.createdAt.dateInyyyyMMddHHmmFormat.timeAgoWithLocalization, style: secondaryTextStyle()),
                    ],
                  ).expand(),
                ],
              ),
              16.height,
              Text(employeeReview.reviewMsg, style: secondaryTextStyle()).visible(employeeReview.reviewMsg.isNotEmpty),
            ],
          ),
        ),
      ],
    );
  }
}
