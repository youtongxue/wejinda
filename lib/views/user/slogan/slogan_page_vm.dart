import 'package:flutter/widgets.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';
import 'package:wejinda/manager/app_user_info_manager.dart';

import '../../../bean/to/user/app_user_dto.dart';
import '../../../net/api/user_info_api.dart';
import '../../../utils/net_uitl.dart';
import '../../../viewmodel/user/user_page_vm.dart';

class SloganPageViewModel extends GetxController {
  final userInfoApi = Get.find<UserInfoApi>();
  final userModel = Get.find<UserPageViewModel>();

  TextEditingController sloganController = TextEditingController();
  String sloganTemp = '';

  void updateSlogan() {
    final newAppUserDTO = AppUserInfoManager()
        .appUserDTO
        .value!
        .copyWith(introduction: sloganController.text);

    NetUtil.request(
      netFun: userInfoApi.userUpdate(newAppUserDTO),
      onDataSuccess: (rightData) async {
        final newAppUserDTO = AppUserDTO.fromJson(rightData);
        SmartDialog.showToast('修改成功!');
        AppUserInfoManager().updateAppUserInfoDTO(newAppUserDTO);
        Get.back();
      },
    );
  }

  @override
  void onInit() {
    super.onInit();

    sloganTemp = AppUserInfoManager().appUserDTO.value?.introduction ?? '';
    sloganController.text = sloganTemp;
  }
}
