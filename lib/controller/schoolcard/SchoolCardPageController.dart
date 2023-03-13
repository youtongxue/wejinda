import 'dart:convert';

import 'package:get/get.dart';
import 'package:dio/dio.dart';
import 'package:wejinda/net/schoolCard/schoolcarduser.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:wejinda/enum/netPageStateEnum.dart';
import 'package:wejinda/service/SchoolCardApi.dart';

import '../../compoents/mySmartDialog.dart';
import '../../enum/loginEnum.dart';
import '../../net/base/NormalSuccessData.dart';
import '../../service/PrefesService.dart';
import '../../utils/netUtil.dart';

class SchoolCardPageController extends GetxController {
  final PrefesService prefesService = Get.find<PrefesService>();
  final SchoolCardApi schoolCardApi = Get.find<SchoolCardApi>();

  final schoolCardUser = SchoolCardUser.now().obs;

  var netPageState = NetPageStateEnum.PagaLoading.obs;
  var errorPageData = ''.obs;

  // 主页直接进入网络请求
  autoLogin() {
    final username =
        prefesService.prefers.getString(UserLoginEnum.SchoolCard.username)!;
    final password =
        prefesService.prefers.getString(UserLoginEnum.SchoolCard.password)!;

    NetUtil.request(
      netFun: schoolCardApi.login(username, password),
      netDone: (response) {
        NetUtil.checkResponse(
          response,
          onSuccessRightData: (rightData) {
            final SchoolCardUser newSchoolCardUser =
                SchoolCardUser.fromJson(jsonDecode(rightData)['result']);
            newSchoolCardUser.username = username;
            newSchoolCardUser.password = password;

            // 更新 Controller 中数据
            schoolCardUser(newSchoolCardUser);
            netPageState.value = NetPageStateEnum.PageSuccess;
          },
          onSuccessErrorData: (errorData) {
            netPageState.value = NetPageStateEnum.PagaError;
            errorPageData.value = errorData.toString();
          },
          onError: (errorData) {
            netPageState.value = NetPageStateEnum.PagaError;
            errorPageData.value = errorData.toString();
          },
          onDioError: (dioError) {
            var data = dioError as DioError;

            netPageState.value = NetPageStateEnum.PagaError;
            errorPageData.value = data.message;
          },
        );
      },
    );
  }

  // 挂失解挂网络请求
  lossCardRequest() {
    Map<String, dynamic> lossRequestData = {
      "username": schoolCardUser.value.username,
      "password": schoolCardUser.value.password,
      "state": schoolCardUser.value.state
    };

    NetUtil.request(
      netFun: schoolCardApi.loss(lossRequestData),
      netDone: (response) {
        NetUtil.checkResponse(
          response,
          onSuccessRightData: (rightData) {
            final NormalSuccessData data =
                NormalSuccessData.fromJson(jsonDecode(rightData));

            schoolCardUser.update((schoolCardUser) {
              schoolCardUser?.state = data.result;
            });

            SmartDialog.showToast(data.result == '26' ? "挂失成功!" : "解除挂失成功!");
          },
          onSuccessErrorData: (errorData) {},
          onError: (errorData) {},
          onDioError: (dioError) {},
        );
      },
    );
  }

  // 挂失 Dialog
  lossDialog() {
    MySmartDialog.ContentDialog(
      schoolCardUser.value.state == '8' ? "挂失此账户" : "解除挂失此账户",
      onCancel: () {
        SmartDialog.dismiss();
      },
      onDetermine: () {
        SmartDialog.dismiss();
        SmartDialog.showLoading(msg: '加载中');
        lossCardRequest();
      },
    );
  }

  //修改限额网络请求
  limitMoneyRequest(String money) {
    Map<String, dynamic> requestData = {
      "username": schoolCardUser.value.username,
      "password": schoolCardUser.value.password,
      "money": money,
    };

    NetUtil.request(
      netFun: schoolCardApi.limitMoney(requestData),
      netDone: (response) {
        NetUtil.checkResponse(
          response,
          onSuccessRightData: (rightData) {
            // 根据返回数据更新Controller中bean数据
            NormalSuccessData data =
                NormalSuccessData.fromJson(jsonDecode(rightData));
            schoolCardUser.update((schoolCardUser) {
              schoolCardUser?.limitMoney = data.result;
            });
            SmartDialog.showToast('修改成功!');
          },
          onSuccessErrorData: (errorData) {
            SmartDialog.showToast(errorData.toString());
          },
          onError: (errorData) {
            SmartDialog.showToast(errorData.toString());
          },
          onDioError: (dioError) {},
        );
      },
    );
  }

  // 修改限额 Dialog
  limiMoneyDialog() {
    MySmartDialog.editTextDialog(
      '修改单日限额',
      onCancel: () {
        SmartDialog.dismiss();
      },
      onDetermineText: (text) {
        if (text.toString().isEmpty) {
          SmartDialog.showToast('请输入额度');
          return;
        }
        SmartDialog.dismiss();
        limitMoneyRequest(text);
      },
    );
  }
}
