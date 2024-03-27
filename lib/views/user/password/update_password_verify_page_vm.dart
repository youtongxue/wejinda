import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';
import 'package:wejinda/manager/app_user_info_manager.dart';
import 'package:wejinda/views/user/password/update_password_dto.dart';

import '../../../net/api/user_info_api.dart';
import '../../../utils/net_uitl.dart';
import 'update_password_page_vm.dart';

class UpdatePasswordVerifyPageViewModel extends GetxController {
  final updatePasswordVM = Get.find<UpdatePasswordPageViewModel>();
  final userInfoApi = Get.find<UserInfoApi>();

  var verifCode = ''.obs; // 验证码
  var reSendCodeTime = 0.obs; // 发送验证码倒计时

  // 事件
  Timer? timer;

  /// 点击重新发送验证码
  void reSendVerifCode() {
    if (reSendCodeTime.value == 0) {
      debugPrint("> > > 重新发送验证码 ");

      NetUtil.request(
        netFun: userInfoApi.sendUpdatePasswordCode(
            AppUserInfoManager().appUserDTO.value!.email),
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

  void updatePassword() {
    final ppdatePasswordDto = UpdatePasswordDto(
        verifyCode: verifCode.value, password: updatePasswordVM.password.value);
    NetUtil.request(
      netFun: userInfoApi.updatePassword(ppdatePasswordDto),
      onDataSuccess: (rightData) async {
        SmartDialog.showToast(rightData.toString());
        // 再次自动登陆
        await AppUserInfoManager().appUserLogin(
            AppUserInfoManager().appUserDTO.value!.email,
            updatePasswordVM.password.value);
        Get.back();
      },
    );
  }

  @override
  void onReady() {
    super.onReady();

    reSendVerifCode();
  }
}
