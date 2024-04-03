import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';

import '../../../manager/app_user_info_manager.dart';
import '../api/user_info_api.dart';
import '../../../net/net_manager.dart';

class DelAccountPageViewModel extends GetxController {
  final userInfoApi = Get.find<UserInfoApi>();

  var verifCode = ''.obs; // 验证码
  var reSendCodeTime = 0.obs; // 发送验证码倒计时

  // 事件
  Timer? timer;

  /// 点击重新发送验证码
  void reSendVerifCode() {
    if (reSendCodeTime.value == 0) {
      debugPrint("> > > 重新发送验证码 ");

      NetManager.request(
        netFun: userInfoApi.sendDelAccountCode(),
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

  void delAccount() {
    NetManager.request(
      netFun: userInfoApi.delAccount(verifCode.value),
      onDataSuccess: (rightData) async {
        SmartDialog.showToast(rightData.toString());
        // 退出登陆
        AppUserInfoManager().signOut();
      },
    );
  }

  @override
  void onReady() {
    super.onReady();

    reSendVerifCode();
  }
}
