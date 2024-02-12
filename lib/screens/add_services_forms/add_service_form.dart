import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:pawlly_employee/components/app_scaffold.dart';
import 'package:pawlly_employee/main.dart';
import 'package:pawlly_employee/screens/add_services_forms/add_service_controller.dart';
import 'package:pawlly_employee/utils/app_common.dart';
import '../../components/bottom_selection_widget.dart';
import '../../components/cached_image_widget.dart';
import '../../components/event_file_widget.dart';
import '../../utils/colors.dart';
import '../../utils/common_base.dart';
import '../../utils/constants.dart';
import 'model/category_model.dart';

class AddServiceForm extends StatelessWidget {
  AddServiceForm({super.key});

  final AddServiceController vetServiceController = Get.put(AddServiceController());

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
        appBartitleText: locale.value.addServices,
        body: SingleChildScrollView(
          padding: const EdgeInsets.only(bottom: 150),
          child: Column(
            children: [
              Form(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    16.height,
                    AppTextField(
                      title: locale.value.serviceName,
                      textStyle: primaryTextStyle(size: 12),
                      controller: vetServiceController.serviceCont,
                      focus: vetServiceController.serviceNameFocus,
                      nextFocus: vetServiceController.serviceDurationFocus,
                      textFieldType: TextFieldType.NAME,
                      decoration: inputDecoration(
                        context,
                        hintText: loginUserData.value.userRole.contains(EmployeeKeyConst.veterinary)
                            ? "${locale.value.eG}  ${locale.value.pet}-${locale.value.nutrition}-${locale.value.consultation}"
                            : loginUserData.value.userRole.contains(EmployeeKeyConst.grooming)
                                ? "${locale.value.eG}  ${locale.value.flea}-${locale.value.and}-${locale.value.tick}-${locale.value.bath}"
                                : loginUserData.value.userRole.contains(EmployeeKeyConst.veterinary)
                                    ? "${locale.value.eG}  ${locale.value.leashTraining}"
                                    : "${locale.value.eG}  ${locale.value.serviceName}",
                        fillColor: context.cardColor,
                        filled: true,
                      ),
                    )
                        .visible(loginUserData.value.userRole.contains(EmployeeKeyConst.veterinary) || loginUserData.value.userRole.contains(EmployeeKeyConst.grooming) || loginUserData.value.userRole.contains(EmployeeKeyConst.training))
                        .paddingSymmetric(horizontal: 16),
                    16.height,
                    AppTextField(
                      title: "${locale.value.serviceDuration} ${(locale.value.mins)}",
                      textStyle: primaryTextStyle(size: 12),
                      controller: vetServiceController.durationCont,
                      // Optional
                      focus: vetServiceController.serviceDurationFocus,
                      nextFocus: vetServiceController.defaultPriceFocus,
                      textFieldType: TextFieldType.NUMBER,
                      decoration: inputDecoration(
                        context,
                        hintText: "${locale.value.eG} 30 ${locale.value.min}",
                        fillColor: context.cardColor,
                        filled: true,
                      ),
                    ).visible(loginUserData.value.userRole.contains(EmployeeKeyConst.veterinary) || loginUserData.value.userRole.contains(EmployeeKeyConst.grooming)).paddingSymmetric(horizontal: 16),
                    16.height,
                    AppTextField(
                      title: locale.value.defaultPrice,
                      textStyle: primaryTextStyle(size: 12),
                      controller: vetServiceController.priceCont,
                      textFieldType: TextFieldType.NUMBER,
                      focus: vetServiceController.defaultPriceFocus,
                      nextFocus: vetServiceController.descriptionFocus,
                      decoration: inputDecoration(
                        context,
                        hintText: "${locale.value.eG} \$90.00",
                        fillColor: context.cardColor,
                        filled: true,
                      ),
                    ).visible(loginUserData.value.userRole.contains(EmployeeKeyConst.veterinary) || loginUserData.value.userRole.contains(EmployeeKeyConst.grooming)).paddingSymmetric(horizontal: 16),
                    16.height,
                    AppTextField(
                      title: locale.value.description,
                      textStyle: primaryTextStyle(size: 12),
                      controller: vetServiceController.descriptionCont,
                      focus: vetServiceController.descriptionFocus,
                      minLines: 3,
                      nextFocus: vetServiceController.descriptionFocus,
                      textFieldType: TextFieldType.MULTILINE,
                      decoration: inputDecoration(
                        context,
                        hintText: loginUserData.value.userRole.contains(EmployeeKeyConst.veterinary)
                            ? "${locale.value.eG}  ${locale.value.healthyDogFeedingGuide}"
                            : loginUserData.value.userRole.contains(EmployeeKeyConst.grooming)
                                ? "${locale.value.eG}  ${locale.value.targetedTreatmentToEliminate} & ${locale.value.ticks}"
                                : loginUserData.value.userRole.contains(EmployeeKeyConst.training)
                                    ? "${locale.value.eG}  ${locale.value.teachingPetsToWalk}"
                                    : "${locale.value.eG}  ${locale.value.description}",
                        fillColor: context.cardColor,
                        filled: true,
                      ),
                    )
                        .visible(loginUserData.value.userRole.contains(EmployeeKeyConst.veterinary) || loginUserData.value.userRole.contains(EmployeeKeyConst.grooming) || loginUserData.value.userRole.contains(EmployeeKeyConst.training))
                        .paddingSymmetric(horizontal: 16),
                    16.height,
                    Obx(
                      () => AppTextField(
                        title: locale.value.category,
                        textStyle: primaryTextStyle(size: 12),
                        controller: vetServiceController.vetCont,
                        textFieldType: TextFieldType.NAME,
                        readOnly: true,
                        onTap: () async {
                          serviceCommonBottomSheet(context,
                              child: Obx(
                                () => BottomSelectionSheet(
                                  title: locale.value.chooseCategory,
                                  hintText: locale.value.searchForCategory,
                                  controller: vetServiceController.searchCont,
                                  hasError: vetServiceController.hasErrorFetchingVet.value,
                                  onChanged: vetServiceController.onCategorySearchChange,
                                  isEmpty: vetServiceController.isShowFullList ? vetServiceController.categoryList.isEmpty : vetServiceController.categoryFilterList.isEmpty,
                                  errorText: vetServiceController.errorMessageVet.value,
                                  isLoading: vetServiceController.isLoading,
                                  noDataTitle: locale.value.categoryListIsEmpty,
                                  noDataSubTitle: locale.value.thereAreNoCategory,
                                  onRetry: () {
                                    vetServiceController.getCategory();
                                  },
                                  listWidget: Obx(
                                    () => veterinaryTypeListWid(
                                      vetServiceController.isShowFullList ? vetServiceController.categoryList : vetServiceController.categoryFilterList,
                                    ).expand(),
                                  ),
                                ),
                              ));
                        },
                        decoration: inputDecoration(context,
                            hintText: loginUserData.value.userRole.contains(EmployeeKeyConst.veterinary)
                                ? "${locale.value.eG}  ${locale.value.videoConsultancy}"
                                : loginUserData.value.userRole.contains(EmployeeKeyConst.grooming)
                                    ? "${locale.value.eG}  ${locale.value.bathingAndShampooing}"
                                    : "${locale.value.eG} ${locale.value.categoryType}",
                            fillColor: context.cardColor,
                            filled: true,
                            prefixIconConstraints: BoxConstraints.loose(const Size.square(60)),
                            prefixIcon: vetServiceController.selectedVeterinaryType.value.categoryImage.isEmpty && vetServiceController.selectedVeterinaryType.value.id.isNegative
                                ? null
                                : CachedImageWidget(
                                    url: vetServiceController.selectedVeterinaryType.value.categoryImage,
                                    height: 35,
                                    width: 35,
                                    firstName: vetServiceController.selectedVeterinaryType.value.name,
                                    fit: BoxFit.cover,
                                    circle: true,
                                    usePlaceholderIfUrlEmpty: true,
                                  ).paddingOnly(left: 12, top: 8, bottom: 8, right: 12),
                            suffixIcon: vetServiceController.selectedVeterinaryType.value.categoryImage.isNotEmpty && vetServiceController.selectedVeterinaryType.value.id.isNegative
                                ? Icon(Icons.keyboard_arrow_down_rounded, size: 24, color: darkGray.withOpacity(0.5))
                                : Icon(Icons.keyboard_arrow_down_rounded, size: 24, color: darkGray.withOpacity(0.5))),
                      ),
                    ).visible(loginUserData.value.userRole.contains(EmployeeKeyConst.veterinary) || loginUserData.value.userRole.contains(EmployeeKeyConst.grooming)).paddingSymmetric(horizontal: 16),
                    16.height,
                    AddFilesWidget(
                      fileList: vetServiceController.servicefiles,
                      onFilePick: vetServiceController.handleFilesPickerClick,
                      onFilePathRemove: (index) {
                        vetServiceController.servicefiles.remove(vetServiceController.servicefiles[index]);
                      },
                    ),
                    /*Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(locale.value.featureImage, style: primaryTextStyle()),
                        4.height,
                        Obx(
                          () => Container(
                            decoration: boxDecorationDefault(color: context.cardColor),
                            child: Row(
                              children: [
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    TextButton(
                                      onPressed: () {
                                        vetServiceController.showBottomSheet(context);
                                      },
                                      style: ButtonStyle(
                                        visualDensity: VisualDensity.compact,
                                        padding: MaterialStateProperty.all(
                                          const EdgeInsets.only(top: 0, right: 8, left: 8, bottom: 0),
                                        ),
                                        shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: radius(), side: BorderSide(color: context.scaffoldBackgroundColor))),
                                      ),
                                      child: Row(
                                        children: [
                                          Text(locale.value.chooseFile, style: secondaryTextStyle()),
                                          8.width,
                                        ],
                                      ),
                                    ),
                                  ],
                                ).paddingSymmetric(horizontal: 8),
                                4.width,
                                Text(vetServiceController.imageFile.value.path, style: secondaryTextStyle(size: 3)),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ).visible(loginUserData.value.userRole.contains(EmployeeKeyConst.veterinary) || loginUserData.value.userRole.contains(EmployeeKeyConst.grooming)).paddingSymmetric(horizontal: 16),
             */
                    16.height,
                    AppButton(
                      width: Get.width,
                      color: primaryColor,
                      onTap: () {
                        if (loginUserData.value.userRole.contains(EmployeeKeyConst.veterinary) || loginUserData.value.userRole.contains(EmployeeKeyConst.grooming)) {
                          vetServiceController.addServices();
                        } else if (loginUserData.value.userRole.contains(EmployeeKeyConst.training)) {
                          vetServiceController.addServicesTraining();
                        }
                      },
                      child: Text(locale.value.save, style: primaryTextStyle(color: white)),
                    ).paddingSymmetric(horizontal: 16),
                  ],
                ),
              )
            ],
          ),
        ));
  }

  Widget veterinaryTypeListWid(List<ShopCategoryModel> list) {
    return ListView.separated(
      itemCount: list.length,
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return SettingItemWidget(
          title: list[index].name,
          titleTextStyle: primaryTextStyle(size: 14),
          leading: CachedImageWidget(url: list[index].categoryImage, height: 35, fit: BoxFit.cover, width: 35, circle: true),
          onTap: () {
            vetServiceController.selectedVeterinaryType(list[index]);
            vetServiceController.vetCont.text = list[index].name;
            Get.back();
          },
        );
      },
      separatorBuilder: (context, index) => commonDivider.paddingSymmetric(vertical: 6),
    );
  }
}
