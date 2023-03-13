import 'dart:convert';
import 'dart:core';

import 'package:dio/dio.dart';
import 'package:get/get_connect/http/src/status/http_status.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';

import '../net/base/SuccessErrorData.dart';

typedef OnNetDone<Response> = void Function(Response response);
typedef OnSuccessRightData<String> = void Function(String rightData);
typedef OnSuccessErrorData<String> = void Function(String errorData);
typedef OnError<String> = void Function(String errorData);
typedef OnDioError<DioError> = void Function(DioError dioError);

class NetUtil {
  // 执行 HTTP 请求
  static request(
      {required Future<dynamic> netFun, required OnNetDone netDone}) async {
    // 开始HTTP请求
    SmartDialog.showLoading(
      backDismiss: false,
      msg: "加载中",
      clickMaskDismiss: false,
    );

    dynamic response = await netFun;
    netDone(response);

    // 请求完成关闭 Loading 加载框
    SmartDialog.dismiss();
  }

  // 检查HTTP返回内容
  static checkResponse(dynamic response,
      {required OnSuccessRightData onSuccessRightData,
      required OnSuccessErrorData onSuccessErrorData,
      required OnError onError,
      required OnDioError onDioError}) {
    if (response is Response) {
      // http请求成功
      if (response.statusCode == HttpStatus.ok) {
        var jsonData = jsonDecode(response.toString());

        //请求成功，返回正确值
        if (int.parse(jsonData['code']) == HttpStatus.ok) {
          onSuccessRightData(response.toString());
        } else {
          //请求成功，返回错误值
          onSuccessErrorData(response.toString());
          // Toast
          var successErrorData =
              SuccessErrorData.fromJson(jsonDecode(response.toString()));
          SmartDialog.showToast(successErrorData.message);
        }
      } else {
        // http请求失败，状态码非200
        onError(response.toString());
        // Toast
        SmartDialog.showToast(response.toString());
      }
    } else {
      DioError error = response as DioError;
      onDioError(error);
      // Toast
      SmartDialog.showToast(error.message);
    }
  }
}
