import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';
import 'package:wejinda/utils/net_uitl.dart';

import '../../bean/to/user/app_user_dto.dart';
import '../../enumm/storage_key_enum.dart';
import '../../net/api/user_info_api.dart';
import '../../repository/account/account_data_service.dart';
import '../../utils/page_path_util.dart';
import 'user_page_vm.dart';

class UserLoginPageViewModel extends GetxController {
  final userInfoApi = Get.find<UserInfoApi>();
  final userVm = Get.find<UserPageViewModel>();
  final accountDataService = Get.find<AccountDataService>();

  var email = ''.obs; // 邮箱
  var password = ''.obs; // 密码
  var userAvatarImg = ''.obs; // 用户头像
  var checkboxSelected = false.obs; // 同意服务协议

  void getUserAvatarByEmail(String inputEmail) {
    email.value = inputEmail;
    if (email.value.isEmail) {
      NetUtil.request(
        netFun: userInfoApi.getUserAvatarByEmail(email.value),
        onDataSuccess: (rightData) async {
          userAvatarImg.value = rightData;
        },
        onDataError: (errorData) async {
          userAvatarImg.value = '';
        },
        enableLoadingDialog: false,
        enableShowErrorMsg: false,
      );
    } else {
      userAvatarImg.value = '';
    }
  }

  /*
   * 用户登陆 
   */
  void userLogin() {
    if (email.isEmpty ||
        password.value.isEmpty ||
        checkboxSelected.value == false) {
      return;
    }

    if (!email.value.isEmail) {
      SmartDialog.showToast("非邮箱账号");
      return;
    }

    NetUtil.request(
      netFun: userInfoApi.userLogin(email.value, password.value),
      onDataSuccess: (rightData) async {
        final appUserLoginRec = AppUserDTO.fromJson(rightData);

        // 更新登陆状态
        userVm.loginInit(appUserLoginRec);

        // 本地存储用户账号、密码信息
        accountDataService.saveAccount(AccountStorageKeyEnum.appUser,
            appUserLoginRec.email, password.value); // 这里密码需要存储真实密码

        // 如果第一次进入，为登陆则上级路由为空
        debugPrint("上级路由: ${Get.routing.previous}");
        if (Get.routing.previous.isEmpty ||
            Get.routing.previous == PagePathUtil.registerAccountPage) {
          Get.toNamed(PagePathUtil.bottomNavPage);
        } else {
          Get.back();
        }
      },
    );
  }
}
