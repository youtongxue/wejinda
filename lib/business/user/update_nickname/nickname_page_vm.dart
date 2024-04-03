import 'package:flutter/widgets.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';
import 'package:wejinda/business/user/dto/app_user_dto.dart';
import 'package:wejinda/manager/app_user_info_manager.dart';

import '../api/user_info_api.dart';
import '../../../net/net_manager.dart';
import '../account_center/user_page_vm.dart';

class NicknamePageViewModel extends GetxController {
  final userInfoApi = Get.find<UserInfoApi>();
  final userModel = Get.find<UserPageViewModel>();

  TextEditingController textController = TextEditingController();

  int maxLines = 2;

  String nicknameTemp = '';
  var errorInfo = ''.obs;

  void updateNickname() {
    if (errorInfo.value.isEmpty) {
      final newAppUserDTO = AppUserInfoManager()
          .appUserDTO
          .value!
          .copyWith(username: textController.text);

      NetManager.request(
        netFun: userInfoApi.userUpdate(newAppUserDTO),
        onDataSuccess: (rightData) async {
          final newAppUserDTO = AppUserDTO.fromJson(rightData);
          SmartDialog.showToast('修改成功!');
          AppUserInfoManager().updateAppUserInfoDTO(newAppUserDTO);
          Get.back();
        },
      );
    }
  }

  @override
  void onInit() {
    super.onInit();

    nicknameTemp = AppUserInfoManager().appUserDTO.value?.username ?? '';
    textController.text = nicknameTemp;

    textController.addListener(() {
      if (textController.text.isEmpty) {
        errorInfo.value = '昵称不能为空';
      } else if (textController.text.isEmail) {
        errorInfo.value = '昵称不能为邮箱';
      } else {
        errorInfo.value = '';
      }
    });
  }
}
