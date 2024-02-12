import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:pawlly_employee/screens/add_services_forms/service_api.dart';
import 'package:pawlly_employee/utils/app_common.dart';

import '../../utils/common_base.dart';
import '../../utils/constants.dart';
import '../auth/sign_in_controller.dart';
import 'model/category_model.dart';

class AddServiceController extends GetxController {
  RxBool isLoading = false.obs;
  TextEditingController serviceCont = TextEditingController();
  TextEditingController durationCont = TextEditingController();
  TextEditingController priceCont = TextEditingController();
  TextEditingController vetCont = TextEditingController();
  TextEditingController searchCont = TextEditingController();
  TextEditingController descriptionCont = TextEditingController();
  RxBool hasErrorFetchingVet = false.obs;
  RxString errorMessageVet = "".obs;
  RxInt categoryId = 0.obs;
  XFile? pickedFile;
  Rx<File> imageFile = File("").obs;
  FocusNode serviceNameFocus = FocusNode();
  FocusNode serviceDurationFocus = FocusNode();
  FocusNode defaultPriceFocus = FocusNode();
  FocusNode descriptionFocus = FocusNode();
  RxBool isUpdateProfile = false.obs;
  RxList<PlatformFile> servicefiles = RxList();
  //Category
  Rx<ShopCategoryModel> selectedVeterinaryType = ShopCategoryModel().obs;
  RxList<ShopCategoryModel> categoryList = RxList();
  RxList<ShopCategoryModel> categoryFilterList = RxList();
  Rx<LoginData> selectedDemoUser = LoginData().obs;

  @override
  void onInit() {
    getCategory();
    super.onInit();
  }

  Future<void> handleFilesPickerClick() async {
    final pickedFiles = await pickFiles();
    Set<String> filePathsSet = servicefiles.map((file) => file.name.trim().toLowerCase()).toSet();
    for (var i = 0; i < pickedFiles.length; i++) {
      if (!filePathsSet.contains(pickedFiles[i].name.trim().toLowerCase())) {
        servicefiles.add(pickedFiles[i]);
      }
    }
  }

  //Get Category List
  getCategory() {
    isLoading(true);
    ServiceFormApis.getCategory(categoryType: serviceRole(loginUserData: loginUserData)).then((value) {
      isLoading(false);
      categoryList(value.data);
      hasErrorFetchingVet(false);
    }).onError((error, stackTrace) {
      hasErrorFetchingVet(true);
      errorMessageVet(error.toString());
      isLoading(false);
      // toast(error.toString());
    });
  }

  /* void _getFromGallery() async {
    pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery, maxWidth: 1800, maxHeight: 1800);
    if (pickedFile != null) {
      imageFile(File(pickedFile!.path));
      // setState(() {});
    }
  }

  _getFromCamera() async {
    pickedFile = await ImagePicker().pickImage(source: ImageSource.camera, maxWidth: 1800, maxHeight: 1800);
    if (pickedFile != null) {
      imageFile(File(pickedFile!.path));
    }
  }*/

  void searchCategoryFunc({
    required String searchtext,
    required RxList<ShopCategoryModel> categoryFilterList,
    required RxList<ShopCategoryModel> categorySList,
  }) {
    categoryFilterList.value = List.from(categorySList.where((element) => element.name.toString().toLowerCase().contains(searchtext.toString().toLowerCase())));
    for (var i = 0; i < categoryFilterList.length; i++) {
      log('SEARCHEDNAMES : ${categoryFilterList[i].toJson()}');
    }
    log('SEARCHEDNAMES.LENGTH: ${categoryFilterList.length}');
  }

  void onCategorySearchChange(searchtext) {
    searchCategoryFunc(
      searchtext: searchtext,
      categoryFilterList: categoryFilterList,
      categorySList: categoryList,
    );
  }

  /*void showBottomSheet(BuildContext context) {
    showModalBottomSheet<void>(
      backgroundColor: context.cardColor,
      context: context,
      builder: (BuildContext context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            SettingItemWidget(
              title: locale.value.gallery,
              leading: const Icon(Icons.image, color: primaryColor),
              onTap: () async {
                _getFromGallery();
                finish(context);
              },
            ),
            SettingItemWidget(
              title: locale.value.camera,
              leading: const Icon(Icons.camera, color: primaryColor),
              onTap: () {
                _getFromCamera();
                finish(context);
              },
              hoverColor: Colors.transparent,
              highlightColor: Colors.transparent,
              splashColor: Colors.transparent,
            ),
          ],
        ).paddingAll(16.0);
      },
    );
  }*/

  bool get isShowFullList => categoryFilterList.isEmpty && searchCont.text.trim().isEmpty;

  serviceRole({loginUserData}) {
    if (loginUserData.value.userRole.contains(EmployeeKeyConst.veterinary)) {
      return ServicesKeyConst.veterinary;
    } else if (loginUserData.value.userRole.contains(EmployeeKeyConst.grooming)) {
      return ServicesKeyConst.grooming;
    } else if (loginUserData.value.userRole.contains(EmployeeKeyConst.training)) {
      return ServicesKeyConst.training;
    } else {
      return "";
    }
  }

  Future<void> addServices() async {
    isLoading(true);
    hideKeyBoardWithoutContext();
    if (selectedVeterinaryType.value.id.isNegative) return;
    ServiceFormApis.addServices(
      name: serviceCont.text.trim(),
      durationmin: durationCont.text.trim(),
      defaultprice: priceCont.text.trim(),
      description: descriptionCont.text.trim(),
      type: serviceRole(loginUserData: loginUserData),
      categoryid: selectedVeterinaryType.value.id.toString(),
      /* files: imageFile.value.path.isNotEmpty ? imageFile.value : null,*/
    ).catchError((e) {
      isLoading(false);
      toast(e.toString());
    });
  }

  Future<void> addServicesTraining() async {
    isLoading(true);
    hideKeyBoardWithoutContext();
    if (selectedVeterinaryType.value.id.isNegative) return;
    ServiceFormApis.addServicesTraining(
      name: serviceCont.text.trim(),
      description: descriptionCont.text.trim(),
      type: serviceRole(loginUserData: loginUserData),
    ).catchError((e) {
      isLoading(false);
      toast(e.toString());
    });
  }
}
