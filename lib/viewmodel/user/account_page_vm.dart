import 'package:flutter/widgets.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';
import 'package:wejinda/bean/to/user/other_account.dart';
import 'package:wejinda/components/view/custom_bottom_sheet_msg_dialog.dart';
import 'package:wejinda/enumm/storage_key_enum.dart';
import 'package:wejinda/manager/app_user_info_manager.dart';

import '../../bean/to/user/app_user_dto.dart';
import '../../components/input/custom_autoscroller_picker.dart';
import '../../components/input/custom_bottom_sheet_picker.dart';
import '../../components/view/custom_bottom_sheet.dart';
import '../../net/api/user_info_api.dart';
import '../../repository/account/account_data_service.dart';
import '../../utils/net_uitl.dart';
import '../../utils/static_date_util.dart';
import 'user_page_vm.dart';

class AccountPageViewModel extends GetxController {
  // 依赖
  final userInfoApi = Get.find<UserInfoApi>();
  final accountDataService = Get.find<AccountDataService>();
  final userModel = Get.find<UserPageViewModel>();
  // 状态
  var jwwAccount = ''.obs;
  // 界面

  @override
  void onInit() {
    super.onInit();

    // 读取本地账号信息
    jwwAccount.value =
        accountDataService.getAccount(AccountStorageKeyEnum.jww).username ?? '';
  }

  void delJwwAccount() {
    // 当本地信息不为空时，退出账号，即删除本地信息
    if (jwwAccount.isNotEmpty) {
      showBottomMsgDialog(
        Get.context!,
        title: "退出登陆",
        msg: "是否退出教务网账号🫣",
        entr: () {
          accountDataService.delAccount(AccountStorageKeyEnum.jww);
          jwwAccount.value = '';
          delOtherAccount(OtherAccountEnum.jww.type);
        },
      );
    }
  }

  /// 选择性别弹窗
  void choseGender(BuildContext context) {
    showMyBottomSheet(context,
        showChild: CustomBottomSheetPicker(
          title: "性别",
          firstList: StaticDateUtil.sexList,
          firstListDefaultSelect: StaticDateUtil.sexList
              .indexOf(AppUserInfoManager().appUserDTO.value!.sex!),
          enter: (allSelectIndex) {
            final newSex = StaticDateUtil.sexList[allSelectIndex[0]];
            final newAppUserDTO =
                AppUserInfoManager().appUserDTO.value!.copyWith(sex: newSex);

            NetUtil.request(
              netFun: userInfoApi.userUpdate(newAppUserDTO),
              onDataSuccess: (rightData) async {
                final newAppUserDTO = AppUserDTO.fromJson(rightData);
                SmartDialog.showToast('修改成功!');
                AppUserInfoManager().updateAppUserInfoDTO(newAppUserDTO);
              },
            );
          },
        ));
  }

  /// 选择专业弹窗
  void choseMajor(BuildContext context) {
    int firstDefaultSelect = 0;
    int secondDefaultSelect = 0;
    if (AppUserInfoManager().appUserDTO.value!.major!.isNotEmpty) {
      final major = StaticDateUtil.findMajorIndex(
          AppUserInfoManager().appUserDTO.value!.major!);
      if (major.length != 2) return;

      firstDefaultSelect = major[0];
      secondDefaultSelect = major[1];
    }

    showMyBottomSheet(
      context,
      showChild: TwoAutoScrollerPicker(
          title: "专业",
          dateList: StaticDateUtil.majorDateList,
          firstDefaultSelect: firstDefaultSelect,
          secondDefaultSelect: secondDefaultSelect,
          firstFontSize: 14,
          secondFontSize: 14,
          enter: (allSelectIndex) async {
            final newMajor = StaticDateUtil.majorDateList[StaticDateUtil
                .majorDateList.keys
                .toList()[allSelectIndex[0]]]![allSelectIndex[1]];
            final newAppUserDTO = AppUserInfoManager()
                .appUserDTO
                .value!
                .copyWith(major: newMajor);

            NetUtil.request(
              netFun: userInfoApi.userUpdate(newAppUserDTO),
              onDataSuccess: (rightData) async {
                final newAppUserDTO = AppUserDTO.fromJson(rightData);
                SmartDialog.showToast('修改成功!');
                AppUserInfoManager().updateAppUserInfoDTO(newAppUserDTO);
              },
            );
          }),
    );
  }

  Future<void> delOtherAccount(int otherAccountEnum) async {
    final loginedOtherAccountList =
        AppUserInfoManager().appUserDTO.value!.otherAccount;
    for (var i = 0; i < loginedOtherAccountList.length; i++) {
      if (loginedOtherAccountList[i].otherAccountEnum == otherAccountEnum) {
        loginedOtherAccountList.removeAt(i);
      }
    }

    NetUtil.request(
      netFun: userInfoApi.userUpdate(AppUserInfoManager().appUserDTO.value!),
      onDataSuccess: (rightData) async {
        final newAppUserDTO = AppUserDTO.fromJson(rightData);
        SmartDialog.showToast('修改成功!');
        AppUserInfoManager().updateAppUserInfoDTO(newAppUserDTO);
      },
    );
  }
}
