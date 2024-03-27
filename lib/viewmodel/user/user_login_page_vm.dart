import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';
import 'package:wejinda/manager/app_user_info_manager.dart';
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

  /// 用户登陆
  void userLogin() async {
    if (email.isEmpty ||
        password.value.isEmpty ||
        checkboxSelected.value == false) {
      return;
    }

    if (!email.value.isEmail) {
      SmartDialog.showToast("非邮箱账号");
      return;
    }

    await AppUserInfoManager().appUserLogin(email.value, password.value);
    if (AppUserInfoManager().isLogined()) {
      Get.offAndToNamed(PagePathUtil.bottomNavPage);
    }
  }
}
