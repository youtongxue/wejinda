import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';

import '../../../net/api/user_info_api.dart';
import '../../../utils/net_uitl.dart';
import '../../../utils/page_path_util.dart';
import 'retrieve_password_dto.dart';
import 'retrieve_password_page_vm.dart';

class RetrievePasswordVerifyPageViewModel extends GetxController {
  final retrievePasswordPageViewModel =
      Get.find<RetrievePasswordPageViewModel>();
  final userInfoApi = Get.find<UserInfoApi>();

  var verifCode = ''.obs; // 验证码
  var reSendCodeTime = 0.obs; // 发送验证码倒计时

  // 事件
  Timer? timer;

  /// 点击重新发送找回密码验证码
  void reSendRetrievePasswordVerifCode() {
    if (reSendCodeTime.value == 0) {
      debugPrint("> > > 点击重新发送找回密码验证码 ");

      NetUtil.request(
        netFun: userInfoApi.sendRetrievePasswordCode(
            retrievePasswordPageViewModel.email.value),
        onDataSuccess: (rightData) async {
          SmartDialog.showToast(rightData.toString());

          reSendCodeTime.value = 60; // 倒计时置为 60秒
          timer = Timer.periodic(
            const Duration(seconds: 1),
            (timer) {
              if (reSendCodeTime.value > 0) {
                reSendCodeTime.value = reSendCodeTime.value - 1;
              } else {
                timer.cancel();
              }
            },
          );
        },
      );
    }
  }

  void retrievePassword() {
    final retrievePasswordDto = RetrievePasswordDto(
        verifyCode: verifCode.value,
        email: retrievePasswordPageViewModel.email.value,
        password: retrievePasswordPageViewModel.password.value);
    NetUtil.request(
      netFun: userInfoApi.retrievePassword(retrievePasswordDto),
      onDataSuccess: (rightData) async {
        SmartDialog.showToast(rightData.toString());
        Get.offAllNamed(PagePathUtil.userLoginPage);
      },
    );
  }

  @override
  void onReady() {
    super.onReady();

    reSendRetrievePasswordVerifCode();
  }
}
