import 'dart:convert';

import 'package:file_picker/file_picker.dart';
import 'package:http/http.dart';
import 'package:nb_utils/nb_utils.dart';
import '../../network/network_utils.dart';
import '../../utils/api_end_points.dart';
import '../../utils/app_common.dart';
import '../../utils/constants.dart';
import 'model/category_model.dart';

class ServiceFormApis {
  static Future<CategoryRes> getCategory({required String categoryType}) async {
    return CategoryRes.fromJson(await handleResponse(await buildHttpResponse("${APIEndPoints.getCategory}?type=$categoryType", method: HttpMethodType.GET)));
  }

  /*static Future<BaseResponseModel> addServices({required Map request, String? categoryId, required String type}) async {
    String categoryIdParam = categoryId != null ? '&category_id=$categoryId' : "";
    return BaseResponseModel.fromJson(await handleResponse(await buildHttpResponse("${APIEndPoints.addService}?$categoryIdParam&type=$type", request: request, method: HttpMethodType.POST)));
  }
*/
  static Future<dynamic> addServices({
    /*  File? imageFile,*/
    String name = '',
    String durationmin = '',
    String defaultprice = '',
    String type = '',
    String description = '',
    String categoryid = '',
    List<PlatformFile>? files,
    Function(dynamic)? onSuccess,
  }) async {
    if (isLoggedIn.value) {
      MultipartRequest multiPartRequest = await getMultiPartRequest(APIEndPoints.addService);
      if (name.isNotEmpty) multiPartRequest.fields[ServiceConst.name] = name;
      if (durationmin.isNotEmpty) multiPartRequest.fields[ServiceConst.durationmin] = durationmin;
      if (defaultprice.isNotEmpty) multiPartRequest.fields[ServiceConst.defaultprice] = defaultprice;
      if (description.isNotEmpty) multiPartRequest.fields[ServiceConst.description] = description;
      if (type.isNotEmpty) multiPartRequest.fields[ServiceConst.type] = type;
      if (categoryid.isNotEmpty) multiPartRequest.fields[ServiceConst.categoryid] = categoryid;
      if (files.validate().isNotEmpty) {
        multiPartRequest.files.add(await MultipartFile.fromPath('feature_image', files.validate().first.path.validate()));
        /*multiPartRequest.files.add(await MultipartFile.fromPath(ServiceConst.featureimage, imageFile.path));*/
      }
      log("Multipart ${jsonEncode(multiPartRequest.fields)}");
      log("Multipart Images ${multiPartRequest.files.map((e) => e.filename)}");
      multiPartRequest.headers.addAll(buildHeaderTokens());

      await sendMultiPartRequest(
        multiPartRequest,
        onSuccess: (data) async {
          onSuccess?.call(data);
        },
        onError: (error) {
          throw error;
        },
      ).catchError((error) {
        throw error;
      });
    }
  }

  static Future<dynamic> addServicesTraining({
    String name = '',
    String type = '',
    String description = '',
    Function(dynamic)? onSuccess,
  }) async {
    if (isLoggedIn.value) {
      MultipartRequest multiPartRequest = await getMultiPartRequest(APIEndPoints.addServiceTraining);
      if (name.isNotEmpty) multiPartRequest.fields[ServiceConst.name] = name;
      if (description.isNotEmpty) multiPartRequest.fields[ServiceConst.description] = description;
      if (type.isNotEmpty) multiPartRequest.fields[ServiceConst.type] = type;
      multiPartRequest.headers.addAll(buildHeaderTokens());
      await sendMultiPartRequest(
        multiPartRequest,
        onSuccess: (data) async {
          onSuccess?.call(data);
        },
        onError: (error) {
          throw error;
        },
      ).catchError((error) {
        throw error;
      });
    }
  }
}
